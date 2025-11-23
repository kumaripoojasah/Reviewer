import os
import pandas as pd
import io
import requests
import json
from flask import Flask, request, jsonify
from flask_cors import CORS
from transformers import pipeline
from collections import Counter

# --- 1. Initialize Flask App ---
app = Flask(__name__)
# Allow your frontend to call this backend
CORS(app) 

# --- 2. Load your AI Model (This happens only ONCE on startup) ---
print("Loading ABSA model... (This will take a moment, it's downloading the model)")
# This is the model you chose, loaded directly with transformers
absa_classifier = pipeline(
    "text-classification", 
    model="yangheng/deberta-v3-base-absa-v1.1"
)
print("✅ ABSA model loaded successfully!")

# --- 3. Define Your Aspects ---
# These are the "features" you will check for in every review.
ASPECT_LIST = [
    'battery', 'camera', 'screen', 'price', 'delivery', 
    'service', 'performance', 'design', 'value', 'quality', 'shipping'
]

# --- 4. ONE Gemini Report Function (for BOTH endpoints) ---
def generate_gemini_report(product_name, praised, criticized):
    # Get the API key from the environment variable you set
    api_key = os.environ.get("GEMINI_API_KEY")
    if not api_key:
        print("WARNING: GEMINI_API_KEY environment variable not set. Cannot generate summary.")
        return "Summary generation failed: API key not set in environment."

    gemini_url = f"https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash-preview-09-2025:generateContent?key={api_key}"

    prompt = f"""
    Act as a product manager analyzing customer reviews for the product: {product_name}.
    I will give you the top praised and top criticized product features based on an analysis of 1000s of reviews.
    
    Your task is to write a concise, bullet-pointed "Manager's Report" based *only* on this data.
    - Address the report to "Management".
    - Start with a 1-sentence executive summary.
    - Highlight what is working well (Strengths).
    - Highlight what needs immediate attention (Weaknesses).

    DATA:
    Top Praised Features: {praised}
    Top Criticized Features: {criticized}

    Begin the report now:
    """

    payload = {
        "contents": [
            {
                "parts": [{"text": prompt}]
            }
        ],
        "generationConfig": {
            "temperature": 0.5,
            "topK": 1,
            "topP": 1,
            "maxOutputTokens": 256,
        }
    }

    try:
        response = requests.post(gemini_url, json=payload, headers={"Content-Type": "application/json"})
        response.raise_for_status()
        data = response.json()
        
        text = data.get('candidates', [{}])[0].get('content', {}).get('parts', [{}])[0].get('text', 'No content found.')
        return text
    
    except requests.exceptions.HTTPError as http_err:
        print(f"HTTP error occurred: {http_err} - {response.text}")
        return f"Error generating summary: {http_err} - {response.text}"
    except Exception as e:
        print(f"Error generating Gemini report: {e}")
        return f"Error generating summary: {str(e)}"


# --- 5. Your First Endpoint (File Upload) ---
@app.route("/analyze", methods=["POST"])
def analyze_reviews():
    try:
        if 'file' not in request.files:
            return jsonify({"error": "No file part"}), 400

        file = request.files['file']
        if file.filename == '':
            return jsonify({"error": "No selected file"}), 400

        df = None
        file_content = file.read().decode('utf-8')
        
        if file.filename.endswith('.csv'):
            df = pd.read_csv(io.StringIO(file_content))
        elif file.filename.endswith('.json'):
            df = pd.read_json(io.StringIO(file_content))
        else:
            return jsonify({"error": "Unsupported file type. Please upload a .csv or .json file."}), 400

        if 'review_text' in df.columns:
            text_column = 'review_text'
        elif 'review' in df.columns:
            text_column = 'review'
        elif 'text' in df.columns:
            text_column = 'text'
        else:
            return jsonify({"error": "Could not find a 'review_text', 'review', or 'text' column in your file."}), 400
            
        print(f"Successfully loaded {len(df)} reviews from '{file.filename}'.")

        # --- C. Process All Reviews with the Model ---
        praised_aspects = Counter()
        criticized_aspects = Counter()
        all_reviews_with_aspects = [] 

        reviews = df[text_column].dropna().astype(str).tolist()

        print(f"Starting analysis of {len(reviews)} reviews...")
        
        for i, review_text in enumerate(reviews):
            review_aspects = []
            
            for aspect in ASPECT_LIST:
                try:
                    result = absa_classifier(review_text, text_pair=aspect)
                    sentiment = result[0]['label']
                    
                    if sentiment == 'Positive':
                        praised_aspects[aspect] += 1
                        review_aspects.append({'aspect': aspect, 'sentiment': 'Positive'})
                    elif sentiment == 'Negative':
                        criticized_aspects[aspect] += 1
                        review_aspects.append({'aspect': aspect, 'sentiment': 'Negative'})
                        
                except Exception as e:
                    print(f"Skipping aspect '{aspect}' for review due to error: {e}")
            
            all_reviews_with_aspects.append({
                'id': i,
                'review_text': review_text,
                'aspects': review_aspects
            })

        print("✅ Analysis complete.")

        # --- D. Format the Results for the Dashboard ---
        top_5_praised = praised_aspects.most_common(5)
        top_5_criticized = criticized_aspects.most_common(5)

        # --- E. Generate Summary if Requested ---
        summary = None
        if request.args.get('summarize') == 'true':
            print("Summarization requested. Calling Gemini API...")
            summary = generate_gemini_report(
                product_name="the uploaded product", 
                praised=top_5_praised, 
                criticized=top_5_criticized
            )
            print("✅ Summary received from Gemini.")

        # --- F. Send the Final JSON Response ---
        return jsonify({
            'top_praised': top_5_praised,
            'top_criticized': top_5_criticized,
            'all_reviews_with_aspects': all_reviews_with_aspects,
            'summary': summary
        })

    except Exception as e:
        print(f"An error occurred: {e}")
        return jsonify({"error": str(e)}), 500

# --- 6. YOUR SECOND ENDPOINT (Product Report - Reads File from Disk) ---
@app.route("/product-report", methods=["POST"])
def product_report():
    try:
        data = request.get_json()
        if not data or "product" not in data:
            return jsonify({"error": "Please provide a product name"}), 400

        product_name = data["product"]
        print(f"📌 Generating report for product: {product_name}")
        
        # --- File Lookup (uses the single test file) ---
        filename = "/reviews/samsung_s23.csv" 

        if not os.path.exists(filename):
            return jsonify({
                "error": f"The test file was not found.",
                "expected_file": filename
            }), 404

        df = pd.read_csv(filename) 

        if "review_text" not in df.columns:
            return jsonify({"error": "CSV must contain 'review_text' column"}), 400

        reviews = df["review_text"].dropna().astype(str).tolist()

        print(f"📌 Loaded {len(reviews)} reviews from {filename}")

        # --- Analysis and Summarization ---
        praised_aspects = Counter()
        criticized_aspects = Counter()

        for review_text in reviews:
            for aspect in ASPECT_LIST:
                try:
                    result = absa_classifier(review_text, text_pair=aspect)
                    sentiment = result[0]["label"]

                    if sentiment == "Positive":
                        praised_aspects[aspect] += 1
                    elif sentiment == "Negative":
                        criticized_aspects[aspect] += 1

                except Exception as e:
                    print(f"Error on review: {e}")
                    continue

        top_praised = praised_aspects.most_common(5)
        top_criticized = criticized_aspects.most_common(5)

        ai_summary = generate_gemini_report(
            product_name=product_name,
            praised=top_praised,
            criticized=top_criticized
        )

        # --- Final Response ---
        return jsonify({
            "product": product_name,
            "top_praised": top_praised,
            "top_criticized": top_criticized,
            "summary": ai_summary,
            "total_reviews": len(reviews)
        })

    except Exception as e:
        print("❌ Error:", e)
        return jsonify({"error": str(e)}), 500

# --- 7. YOUR THIRD ENDPOINT (Sample Reviews for Frontend) ---
@app.route("/reviews", methods=["GET"])
def get_reviews():
    top_praised = [
        {"review": "Amazing display and battery!", "rating": 5},
        {"review": "Camera quality is outstanding", "rating": 5},
        {"review": "Performance is super smooth", "rating": 5},
        {"review": "Very premium build feel", "rating": 5},
        {"review": "Great value for money overall", "rating": 4.8},
    ]

    worst_reviews = [
        {"review": "Heats a lot while gaming", "rating": 2},
        {"review": "Battery drains fast after 6 months", "rating": 2.5},
        {"review": "Night mode is slow", "rating": 2.8},
        {"review": "Too much bloatware installed", "rating": 3},
        {"review": "Slippery without case", "rating": 3},
    ]

    return jsonify({
        "top_praised": top_praised,
        "worst_reviews": worst_reviews
    })

# --- 8. Run the App ---
if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8080, debug=True)