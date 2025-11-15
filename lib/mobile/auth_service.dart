// lib/services/auth_service.dart
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // 🔹 Sign Up
  Future<User?> signUp(String email, String password) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user;
    } catch (e) {
      print("Signup Error: $e");
      rethrow;
    }
  }
 Future<void> updateUsername({required String username}) async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        await user.updateDisplayName(username);
        await user.reload(); // refresh user data
      }
    } catch (e) {
      print("Update Username Error: $e");
      rethrow;
    }
  }

  // 🔹 Login
  Future<User?> login(String email, String password) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user;
    } catch (e) {
      print("Login Error: $e");
      rethrow;
    }
  }

  // 🔹 Forgot password
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print("Reset Password Error: $e");
      rethrow;
    }
  }
    // 🔹 Send OTP to phone
  Future<void> sendOtpToPhone(
  String phoneNumber, {
  required Function(String verificationId) onCodeSent,
}) async {
  await _auth.verifyPhoneNumber(
    phoneNumber: phoneNumber,
    verificationCompleted: (PhoneAuthCredential credential) async {
      await _auth.signInWithCredential(credential);
    },
    verificationFailed: (FirebaseAuthException e) {
      throw Exception("Verification failed: ${e.message}");
    },
    codeSent: (String verificationId, int? resendToken) {
      onCodeSent(verificationId); // ✅ callback
    },
    codeAutoRetrievalTimeout: (String verificationId) {},
  );
}

  // 🔹 Verify the OTP
  Future<User?> verifyOtp(String verificationId, String smsCode) async {
    final credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: smsCode,
    );

    final userCredential = await _auth.signInWithCredential(credential);
    return userCredential.user;
  }

  // 🔹 Logout
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // 🔹 Current user
  User? get currentUser => _auth.currentUser;
}



