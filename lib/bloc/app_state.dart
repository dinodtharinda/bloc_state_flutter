import 'package:bloc_state_flutter/models.dart';
import 'package:flutter/material.dart';

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
}
