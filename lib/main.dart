import 'package:bloc_state_flutter/cubits_app/cubits_test_screen.dart';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:math' as math;

void main() {
  runApp(
    const MaterialApp(
      home: CubitsCounterScreen(),
    ),
  );
}

