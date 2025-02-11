import 'package:firebase_auth/firebase_auth.dart';

class AuthExceptionHandler {
  static String handleAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case 'wrong-password':
        return 'The password you entered is incorrect. Please try again.';
      case 'invalid-email':
        return 'The email address you entered is not valid.';
      case 'user-disabled':
        return 'Your account has been disabled. Please contact support for assistance.';
      case 'user-not-found':
        return 'There is no account associated with this email address.';
      case 'email-already-in-use':
        return 'An account with this email address already exists.';
      case 'operation-not-allowed':
        return 'Email/password accounts are not enabled. Please enable them in the Firebase Console under the Auth tab.';
      case 'weak-password':
        return 'The password is too weak. Please choose a stronger one.';
      case 'account-exists-with-different-credential':
        return 'An account already exists with the same email address but different sign-in credentials. Sign in using a provider associated with this email address.';
      case 'invalid-credential':
        return 'The provided credential is invalid.';
      case 'invalid-verification-code':
        return 'The verification code is invalid.';
      case 'invalid-verification-id':
        return 'The verification ID is invalid.';
      case 'user-mismatch':
        return 'The provided credential does not correspond to this user.';
      case 'expired-action-code':
        return 'The action code has expired.';
      case 'too-many-requests':
        return 'Too many requests, please try again after some time';
      case 'network-request-failed':
        return 'No internet connection';
      default:
        return 'An unknown error occurred. Please try again later.';
    }
  }
}
