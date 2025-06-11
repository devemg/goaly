import 'package:firebase_auth/firebase_auth.dart';

String authErrorMessage(FirebaseAuthException e, bool signUp) {
  var errorMsg = '';
  switch (e.code) {
    // sign in errors
    case 'invalid-credential':
      errorMsg = 'Invalid email or password. Please try again.';
      break;
    case 'user-not-found':
      errorMsg = 'No account found with this email.';
      break;
    case 'wrong-password':
      errorMsg = 'Incorrect password. Please try again.';
      break;
    case 'user-disabled':
      errorMsg = 'This account has been disabled.';
      break;
    // Email/Password Signup Errors
    case 'email-already-in-use':
      errorMsg =
          'This email is already registered. Please log in or use another email.';
      break;
    case 'invalid-email':
      errorMsg = 'The email address is badly formatted.';
      break;
    case 'operation-not-allowed':
      errorMsg = 'Email/password accounts are not enabled. Contact support.';
      break;
    case 'weak-password':
      errorMsg = 'Password is too weak (must be at least 6 characters).';
      break;
    // General Errors
    case 'network-request-failed':
      errorMsg = 'Network error. Check your internet connection.';
      break;
    case 'too-many-requests':
      errorMsg = 'Too many attempts. Try again later or reset your password.';
      break;
    default:
      if (signUp) {
        errorMsg = 'Signup failed. Please try again.';
      } else {
        errorMsg = 'Login failed. Please try again later.';
      }
  }
  return errorMsg;
}
