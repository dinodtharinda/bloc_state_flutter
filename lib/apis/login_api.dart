import 'package:bloc_state_flutter/models.dart';
import 'package:flutter/material.dart';

@immutable
abstract class LoginApiProtocol {
  const LoginApiProtocol();
  Future<LoginHandle?> login({
    required String email,
    required String password,
  });
}

@immutable
class LoginApi implements LoginApiProtocol {
  // const LoginApi._sharedInstance();
  // static const LoginApi _shared = LoginApi._sharedInstance();
  // factory LoginApi.instance() => _shared;

  @override
  Future<LoginHandle?> login({
    required String email,
    required String password,
  }) =>
      Future.delayed(
        const Duration(seconds: 2),
        () => email == 'dinod' && password == '1234',
      ).then((isLoggedIn) => isLoggedIn ? const LoginHandle.foorBar() : null);
}
