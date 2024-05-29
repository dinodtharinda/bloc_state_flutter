import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CubitsCounterScreen extends StatefulWidget {
  const CubitsCounterScreen({super.key});

  @override
  State<CubitsCounterScreen> createState() => _CubitsCounterScreenState();
}

class _CubitsCounterScreenState extends State<CubitsCounterScreen> {
  late CounterCubit counterCubit;
  @override
  void initState() {
    counterCubit = CounterCubit();
    super.initState();
  }

  @override
  void dispose() {
    counterCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cubits Counter"),
      ),
      body: StreamBuilder(
        stream: counterCubit.stream,
        builder: (context, snapshot) {
          return Center(
            child: Text(
              snapshot.data.toString(),
              style: const TextStyle(
                fontSize: 20,
                color: Colors.blue,
              ),
            ),
          );
        },
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FloatingActionButton(
            onPressed: () {      
              counterCubit.increament();
            },
            child: const Icon(Icons.add),
          ),
          FloatingActionButton(
            onPressed: () {
              counterCubit.decremenet();
            },
            child: const Icon(Icons.remove),
          ),
        ],
      ),
    );
  }
}

class CounterCubit extends Cubit<int> {
  CounterCubit() : super(0);
  int _count = 0;
  void increament() {
    emit( _count++);
  }
  void decremenet() {
    _count--;
    emit( _count--);
  }
}
