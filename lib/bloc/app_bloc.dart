import 'dart:async';
import 'dart:math' as math;

import 'package:bloc/bloc.dart';
import 'package:bloc_state_flutter/bloc/app_state.dart';
import 'package:bloc_state_flutter/bloc/bloc_events.dart';
import 'package:flutter/services.dart';

typedef AppBlocRandomUrlPicker = String Function(Iterable<String> allUrl);

extension RandomElement<T> on Iterable<T> {
  T getRandomElement() => elementAt(
        math.Random().nextInt(length),
      );
}

class AppBloc extends Bloc<AppEvent, AppState> {
  String _pickRandomUrl(Iterable<String> allUrl) => allUrl.getRandomElement();
  final AppBlocRandomUrlPicker? urlPicker;
  final Iterable<String> urls;
  final Duration? waitBeforeLoading;
  AppBloc({
    required this.urls,
    this.waitBeforeLoading,
    this.urlPicker,
  }) : super(const AppState.empty()) {
    on<LoadNextUrlEvent>(loadNextUrlEvent);
  }

  FutureOr<void> loadNextUrlEvent(
    LoadNextUrlEvent event,
    Emitter<AppState> emit,
  ) async {
    //Start loading...
    emit(
      const AppState(
        isLoading: true,
        data: null,
        error: null,
      ),
    );

    final url = (urlPicker ?? _pickRandomUrl)(urls);
    try {
      if (waitBeforeLoading != null) {
        await Future.delayed(waitBeforeLoading!);
      }
      final bundle = NetworkAssetBundle(Uri.parse(url));
      final data = (await bundle.load(url)).buffer.asUint8List();
      emit(
        AppState(
          isLoading: false,
          data: data,
          error: null,
        ),
      );
    } catch (e) {
      emit(
        AppState(
          isLoading: false,
          data: null,
          error: e,
        ),
      );
    }
  }
}
