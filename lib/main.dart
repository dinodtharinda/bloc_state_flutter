import 'package:bloc_state_flutter/features/home/ui/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const MyApp(),
      theme: ThemeData(
        primaryColor: Colors.teal,
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: Colors.teal,
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
          centerTitle: true,
          titleTextStyle: const TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
      ),
    ),
  );
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Home(),
    );
  }
}