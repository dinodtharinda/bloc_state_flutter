import 'package:bloc_state_flutter/bloc/bottom_bloc.dart';
import 'package:bloc_state_flutter/bloc/top_bloc.dart';
import 'package:bloc_state_flutter/models/constants.dart';
import 'package:bloc_state_flutter/views/app_bloc_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: MultiBlocProvider(
          providers: [
            BlocProvider<TopBloc>(
              create: (context) => TopBloc(
                waitBeforeLoading: const Duration(seconds: 3),
                urls: images,
              ),
            ),
            BlocProvider<BottomBloc>(
              create: (context) => BottomBloc(
                waitBeforeLoading: const Duration(seconds: 3),
                urls: images,
              ),
            ),
          ],
          child: const Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              AppBlocView<TopBloc>(),
              AppBlocView<BottomBloc>(),
            ],
          ),
        ),
      ),
    );
  }
}
