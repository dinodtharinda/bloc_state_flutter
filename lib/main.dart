import 'package:bloc_state_flutter/bloc/app_bloc.dart';
import 'package:bloc_state_flutter/views/app.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider<AppBloc>(
        create: (_) => AppBloc(),
        child:const App(),
      ),
      theme: ThemeData(
       
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          color: Colors.blue,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 19,
          ),
        ),
      ),
    ),
  );
}

