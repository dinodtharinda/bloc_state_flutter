import 'package:bloc_state_flutter/auth/auth_error.dart';
import 'package:bloc_state_flutter/dialogs/show_auth_error.dart';
import 'package:bloc_state_flutter/loading/loading_screen.dart';
import 'package:bloc_state_flutter/views/login_view.dart';
import 'package:bloc_state_flutter/views/photo_gallery_view.dart';
import 'package:bloc_state_flutter/views/register_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/app_bloc.dart';
import '../bloc/app_state.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppBloc, AppState>(
      listener: (context, appState) {
        if (appState.isLoading) {
          LoadingScreen.instance().show(
            context: context,
            text: 'Loading...',
          );
        } else {
          LoadingScreen.instance().hide();
        }
        final authError = appState.authError;
        if (authError != null) {
          showAuthError(
            authError: authError,
            context: context,
          );
        }
      },
      builder: (context, appState) {
        if (appState is AppStateLoggedOut) {
          return const LoginView();
        } else if (appState is AppStateLoggedIn) {
          return const PhotoGalleryView();
        } else if (appState is AppStateIsInRegistrationView) {
          return const RegisterView();
        } else {
          return Container();
        }
      },
    );
  }
}
