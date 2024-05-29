import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math show Random;

const names = [
  'Foo',
  'Bar',
  'Baz',
];

extension RandomElement<T> on Iterable<T> {
  T getRandomElement() => elementAt(math.Random().nextInt(length));
}

class NamesCubits extends Cubit<String?> {
  NamesCubits() : super(null);

  void pickRandomName() {
    emit(names.getRandomElement());
  }
}

class CubitExampleScreen extends StatefulWidget {
  const CubitExampleScreen({super.key});

  @override
  State<CubitExampleScreen> createState() => _CubitExampleScreenState();
}

class _CubitExampleScreenState extends State<CubitExampleScreen> {
  late final NamesCubits cubit;

  @override
  void initState() {
    cubit = NamesCubits();
    super.initState();
  }

  @override
  void dispose() {
    cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hello"),
      ),
      body: StreamBuilder<String?>(
        stream: cubit.stream,
        builder: (context, snapshot) {
          final button = TextButton(
            onPressed: () {
              cubit.pickRandomName();
            },
            child: const Text("Pick Random Name"),
          );

          switch (snapshot.connectionState) {
            case ConnectionState.none:
             return const SizedBox();
            case ConnectionState.waiting:
              return button;
            case ConnectionState.active:
              return Column(children: [
                Text(snapshot.data??""),
                button
              ],);
            case ConnectionState.done:
             return const SizedBox();
          }
        },
      ),
    );
  }
}