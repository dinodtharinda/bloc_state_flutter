import 'package:bloc_state_flutter/bloc/app_bloc.dart';
import 'package:bloc_state_flutter/bloc/app_event.dart';
import 'package:bloc_state_flutter/extensions/if_debugging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class LoginView extends HookWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController =
        useTextEditingController(text: 'dinodbat@gmail.com'.ifDebugging);
    final passwordController =
        useTextEditingController(text: '123456'.ifDebugging);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Log In',
        ),
      ),
      body: Column(
        children: [
          TextField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              hintText: 'Enter email here...',
            ),
          ),
          TextField(
            controller: passwordController,
            obscureText: true,
            obscuringCharacter: '⚫',
            decoration: const InputDecoration(
              hintText: 'Enter password here...',
            ),
          ),
          TextButton(
            onPressed: () {
              final email = emailController.text;
              final password = passwordController.text;
              context.read<AppBloc>().add(
                    AppEventLogin(
                      email: email,
                      password: password,
                    ),
                  );
            },
            child: const Text(
              'Login',
            ),
          ),
          TextButton(
            onPressed: () {
              context.read<AppBloc>().add(
                    const AppEventGoToRegistration(),
                  );
            },
            child: const Text(
              'Not registered yet? Register here',
            ),
          ),
        ],
      ),
    );
  }
}
