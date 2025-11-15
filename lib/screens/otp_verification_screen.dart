
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../glass_container.dart';
import '../widgets/auth_background.dart';
import '../mobile/auth_service.dart'; // 🔹 for backend OTP verification

class OtpVerificationScreen extends StatefulWidget {
  // ❌ REMOVED: final String emailOrPhone;
  
  // ✅ ADDED: The required parameters from the Navigator.push call
  final String verificationId;
  final String phoneNumber;

  const OtpVerificationScreen({
    super.key, 
    required this.verificationId, // Now required
    required this.phoneNumber,    // Now required
  });

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final int otpLength = 4;
  late List<TextEditingController> otpControllers;
  late List<FocusNode> focusNodes;
  bool isVerifying = false;

  final AuthService _authService = AuthService();

  @override
  void initState() {
    super.initState();
    otpControllers = List.generate(otpLength, (_) => TextEditingController());
    focusNodes = List.generate(otpLength, (_) => FocusNode());
  }

  @override
  void dispose() {
    for (final controller in otpControllers) {
      controller.dispose();
    }
    for (final node in focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _onOtpChanged(String value, int index) {
    if (value.isNotEmpty && index < otpLength - 1) {
      FocusScope.of(context).requestFocus(focusNodes[index + 1]);
    } else if (value.isEmpty && index > 0) {
      FocusScope.of(context).requestFocus(focusNodes[index - 1]);
    }
  }

  Future<void> _verifyOtp() async {
    final otp = otpControllers.map((c) => c.text).join();

    if (otp.length < otpLength) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter the complete OTP")),
      );
      return;
    }

    setState(() => isVerifying = true);

    try {
  // ❌ Current code (fake loading)
  // await Future.delayed(const Duration(seconds: 1)); 

  // ✅ Integrate Firebase verification using the actual method:
  await _authService.verifyOtp(widget.verificationId, otp);
  
  // After successful verification, the user is signed in.
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text("OTP Verified Successfully ✅")),
  );

      // You can navigate to ResetPasswordScreen or Home
      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => ResetPasswordScreen()));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Invalid OTP: $e")),
      );
    } finally {
      setState(() => isVerifying = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return AuthBackground(
      child: GlassContainer(
        width: size.width * 0.85,
        height: size.height * 0.58,
        baseColor: Colors.grey.shade900,
        opacity: 0.15,
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Verify OTP",
                  style: GoogleFonts.poppins(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  "We’ve sent a 4-digit OTP to ${widget.phoneNumber}",
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white70),
                ),
                const SizedBox(height: 40),

                // 🔹 OTP Input Fields
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(otpLength, (index) {
                    return SizedBox(
                      width: 55,
                      child: TextField(
                        controller: otpControllers[index],
                        focusNode: focusNodes[index],
                        textAlign: TextAlign.center,
                        maxLength: 1,
                        keyboardType: TextInputType.number,
                        style: const TextStyle(color: Colors.white, fontSize: 24),
                        decoration: InputDecoration(
                          counterText: "",
                          fillColor: Colors.white.withOpacity(0.05),
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white.withOpacity(0.4),
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.white,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onChanged: (value) => _onOtpChanged(value, index),
                      ),
                    );
                  }),
                ),

                const SizedBox(height: 40),

                // 🔹 Verify Button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 55),
                    backgroundColor: Colors.white.withOpacity(0.3),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                      side: BorderSide(color: Colors.white.withOpacity(0.5)),
                    ),
                  ),
                  onPressed: isVerifying ? null : _verifyOtp,
                  child: isVerifying
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                          "Verify OTP",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),

                const SizedBox(height: 20),

                // 🔹 Resend OTP
                TextButton(
                  onPressed: () async {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Resending OTP...")),
                    );
                    // await _authService.sendOtpToPhone(widget.emailOrPhone);
                  },
                  child: const Text(
                    "Resend OTP",
                    style: TextStyle(
                      color: Colors.lightBlueAccent,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}




