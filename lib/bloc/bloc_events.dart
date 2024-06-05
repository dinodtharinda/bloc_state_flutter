import 'package:flutter/material.dart';

@immutable
abstract class AppEvent {
  const AppEvent();
}

@immutable
class LoadNextUrlEvent implements AppEvent {
  const LoadNextUrlEvent();
}
