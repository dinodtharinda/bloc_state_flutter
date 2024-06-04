import 'package:bloc_state_flutter/strings.dart';
import 'package:flutter/material.dart';

class PasswordTextField extends StatelessWidget {
  final TextEditingController passwordController;

  const PasswordTextField({required this.passwordController, super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: passwordController,
      obscureText: true,
      obscuringCharacter: '😑',
      decoration: const InputDecoration(
        hintText: enterYourPasswordHere,
      ),

    );
  }
}
