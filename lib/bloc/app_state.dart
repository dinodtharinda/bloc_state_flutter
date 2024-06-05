import 'package:bloc_state_flutter/models.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

@immutable
class AppState {
  final bool isLoading;
  final LoginErrors? loginError;
  final LoginHandle? loginHandle;
  final Iterable<Note>? fetchedNotes;

  const AppState({
    required this.isLoading,
    required this.loginError,
    required this.loginHandle,
    required this.fetchedNotes,
  });

  const AppState.empty()
      : isLoading = false,
        loginError = null,
        loginHandle = null,
        fetchedNotes = null;

  @override
  String toString() {
    return {
      'isLoading': isLoading,
      'loginErrors': loginError,
      'loginHandle': loginHandle,
      'fetchedNotes': fetchedNotes,
    }.toString();
  }

  @override
  bool operator ==(covariant AppState other) {
    final otherPropertiesAreEqual = isLoading == other.isLoading &&
        loginHandle == other.loginHandle &&
        loginError == other.loginError;

    if (fetchedNotes == null && other.fetchedNotes == null) {
      return otherPropertiesAreEqual;
    } else {
      return otherPropertiesAreEqual &&
          (fetchedNotes?.isEqualTo(other.fetchedNotes) ?? true);
    }
  }

  @override
  int get hashCode => Object.hash(
        isLoading,
        loginError,
        loginHandle,
        fetchedNotes,
      );
}

extension UnordredEquality on Object {
  bool isEqualTo(other) =>
      const DeepCollectionEquality.unordered().equals(this, other);
}