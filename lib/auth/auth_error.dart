import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuthException;

const Map<String, AuthError> authErrorMapping = {
  'no-current-user': AuthErrorNoCurrentUser(),
  'operation-not-allowed': AuthErrorOperationNotAllowed(),
  'weak-password': AuthErrorWeakPassword(),
  'email-already-in-use': AuthErrorEmailAlreadyInUse(),
  'invalid-email': AuthErrorInvalidEmail(),
  'user-disabled': AuthErrorUserDisabled(),
  'user-not-found': AuthErrorUserNotFound(),
  'wrong-password': AuthErrorWrongPassword(),
  'too-many-requests': AuthErrorTooManyRequests(),
  'invalid-credential': AuthErrorInvalidCredential(),
  'account-exists-with-different-credential':
      AuthErrorAccountExistsWithDifferentCredential(),
  'invalid-verification-code': AuthErrorInvalidVerificationCode(),
  'invalid-verification-id': AuthErrorInvalidVerificationId(),
  'session-expired': AuthErrorSessionExpired(),
  'requires-recent-login': AuthErrorRequiresRecentLogin(),
};

@immutable
abstract class AuthError {
  final String dialogTitle;
  final String dialogText;

  const AuthError({
    required this.dialogTitle,
    required this.dialogText,
  });

  factory AuthError.from(FirebaseAuthException exception) =>
      authErrorMapping[exception.code.toLowerCase().trim()] ??
       AuthErrorUnknown(exception);
}

@immutable
class AuthErrorUnknown extends AuthError {
  final FirebaseAuthException innerException;
  const AuthErrorUnknown(this.innerException)
      : super(
          dialogTitle: 'Authentication error',
          dialogText: 'Unknown authentication error',
        );
}

@immutable
class AuthErrorNoCurrentUser extends AuthError {
  const AuthErrorNoCurrentUser()
      : super(
          dialogTitle: 'No current user!',
          dialogText: 'No current user with this informaitons',
        );
}

@immutable
class AuthErrorOperationNotAllowed extends AuthError {
  const AuthErrorOperationNotAllowed()
      : super(
          dialogTitle: 'Operation not allowed',
          dialogText: 'You cannot register using this method at this moment!',
        );
}

@immutable
class AuthErrorWeakPassword extends AuthError {
  const AuthErrorWeakPassword()
      : super(
          dialogTitle: 'Weak Password',
          dialogText: 'The password you have entered is too weak.',
        );
}

@immutable
class AuthErrorEmailAlreadyInUse extends AuthError {
  const AuthErrorEmailAlreadyInUse()
      : super(
          dialogTitle: 'Email Already In Use',
          dialogText: 'The email address is already in use by another account.',
        );
}

@immutable
class AuthErrorInvalidEmail extends AuthError {
  const AuthErrorInvalidEmail()
      : super(
          dialogTitle: 'Invalid Email',
          dialogText: 'The email address is not valid.',
        );
}

@immutable
class AuthErrorUserDisabled extends AuthError {
  const AuthErrorUserDisabled()
      : super(
          dialogTitle: 'User Disabled',
          dialogText: 'The user account has been disabled by an administrator.',
        );
}

@immutable
class AuthErrorUserNotFound extends AuthError {
  const AuthErrorUserNotFound()
      : super(
          dialogTitle: 'User Not Found',
          dialogText: 'There is no user corresponding to the given email.',
        );
}

@immutable
class AuthErrorWrongPassword extends AuthError {
  const AuthErrorWrongPassword()
      : super(
          dialogTitle: 'Wrong Password',
          dialogText:
              'The password is invalid or the user does not have a password.',
        );
}

@immutable
class AuthErrorTooManyRequests extends AuthError {
  const AuthErrorTooManyRequests()
      : super(
          dialogTitle: 'Too Many Requests',
          dialogText:
              'We have blocked all requests from this device due to unusual activity. Try again later.',
        );
}

@immutable
class AuthErrorInvalidCredential extends AuthError {
  const AuthErrorInvalidCredential()
      : super(
          dialogTitle: 'Invalid Credential',
          dialogText: 'The credential is invalid or has expired.',
        );
}

@immutable
class AuthErrorAccountExistsWithDifferentCredential extends AuthError {
  const AuthErrorAccountExistsWithDifferentCredential()
      : super(
          dialogTitle: 'Account Exists With Different Credential',
          dialogText:
              'An account already exists with the same email address but different sign-in credentials.',
        );
}

@immutable
class AuthErrorInvalidVerificationCode extends AuthError {
  const AuthErrorInvalidVerificationCode()
      : super(
          dialogTitle: 'Invalid Verification Code',
          dialogText: 'The verification code is invalid or has expired.',
        );
}

@immutable
class AuthErrorInvalidVerificationId extends AuthError {
  const AuthErrorInvalidVerificationId()
      : super(
          dialogTitle: 'Invalid Verification ID',
          dialogText: 'The verification ID is invalid.',
        );
}

@immutable
class AuthErrorSessionExpired extends AuthError {
  const AuthErrorSessionExpired()
      : super(
          dialogTitle: 'Session Expired',
          dialogText: 'The session has expired. Please try again.',
        );
}

@immutable
class AuthErrorRequiresRecentLogin extends AuthError {
  const AuthErrorRequiresRecentLogin()
      : super(
          dialogTitle: 'Requires Recent Login',
          dialogText:
              'This operation is sensitive and requires recent authentication. Log in again before retrying this request.',
        );
}
