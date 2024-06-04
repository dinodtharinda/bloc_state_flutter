import 'package:bloc_state_flutter/apis/login_api.dart';
import 'package:bloc_state_flutter/apis/notes_api.dart';
import 'package:bloc_state_flutter/bloc/actions.dart';
import 'package:bloc_state_flutter/bloc/app_bloc.dart';
import 'package:bloc_state_flutter/dialogs/generic_dialog.dart';
import 'package:bloc_state_flutter/dialogs/loading_screen.dart';
import 'package:bloc_state_flutter/models.dart';
import 'package:bloc_state_flutter/strings.dart';
import 'package:bloc_state_flutter/view/iterable_list_view.dart';
import 'package:bloc_state_flutter/view/login_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/app_state.dart';

void main() {
  runApp(
    const MaterialApp(
      home: HomePage(),
    ),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppBloc(
        loginApi: LoginApi(),
        notesApi: NotesApi(),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(homePage),
        ),
        body: BlocConsumer<AppBloc, AppState>(
          listener: (context, appState) {
            //loading screen
            if (appState.isLoading) {
              LoadingScreen.instance().show(
                context: context,
                text: pleaseWait,
              );
            } else {
              LoadingScreen.instance().hide();
            }

            //display possible errors
            final loginError = appState.loginError;
            if (loginError != null) {
              showGenericDialog<bool>(
                context: context,
                title: loginErrorDialogTitle,
                content: loginErrorDialogContent,
                optionBulder: () => {ok: true},
              );
            }

            //if we are logged in, but we have no fetched notes

            if (appState.isLoading == false &&
                appState.loginError == null &&
                appState.loginHandle == const LoginHandle.foorBar() &&
                appState.fetchedNotes == null) {
              context.read<AppBloc>().add(
                    const LoadNotesAction(),
                  );
            }
          },
          builder: (context, appState) {
            final notes = appState.fetchedNotes;
            if (notes == null) {
              return LoginView(
                onLoginTapped: (email, password) {
                  context.read<AppBloc>().add(
                        LoginAction(email: email, password: password),
                      );
                },
              );
            } else {
              return notes.toListView();
            }
          },
        ),
      ),
    );
  }
}
