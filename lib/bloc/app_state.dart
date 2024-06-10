import 'package:bloc_state_flutter/auth/auth_error.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

@immutable
abstract class AppState {
  final bool isLoading;
  final AuthError? authError;
  const AppState({
    required this.isLoading,
    required this.authError,
  });
}

@immutable
class AppStateLoggedIn extends AppState {
  final User user;
  final Iterable<Reference> images;
  const AppStateLoggedIn({
    required super.isLoading,
    required this.user,
    required this.images,
    required super.authError,
  });
  @override
  bool operator ==(other) {
    final otherClass = other;
    if (otherClass is AppStateLoggedIn) {
      return isLoading == otherClass.isLoading &&
          user.uid == otherClass.user.uid &&
          images.length == otherClass.images.length;
    } else {
      return false;
    }
  }

  @override
  int get hashCode => Object.hash(
        user.uid,
        images,
      );

  @override
  String toString() {
    return 'AppStateLoggedIn, image.length = ${images.length}';
  }
}

@immutable
class AppStateLogOut extends AppState {
  const AppStateLogOut({
    required super.isLoading,
    required super.authError,
  });

  @override
  String toString() {
    return 'AppStateLoggedOut, isLoading = $isLoading, authError = $authError';
  }
}

@immutable
class AppStateIsInRegistrationView extends AppState {
  const AppStateIsInRegistrationView({
    required super.isLoading,
    required super.authError,
  });
}

extension GetUser on AppState {
  User? get user {
    final cls = this;
    if (cls is AppStateLoggedIn) {
      return cls.user;
    } else {
      return null;
    }
  }
}

extension GetImages on AppState {
  Iterable<Reference>? get images {
    final cls = this;
    if (cls is AppStateLoggedIn) {
      return cls.images;
    } else {
      return null;
    }
  }
}
