// import 'package:bloc_state_flutter/apis/login_api.dart';
// import 'package:bloc_state_flutter/apis/notes_api.dart';
// import 'package:bloc_state_flutter/bloc/actions.dart';
// import 'package:bloc_state_flutter/bloc/app_bloc.dart';
// import 'package:bloc_state_flutter/bloc/app_state.dart';
// import 'package:bloc_state_flutter/models.dart';
// import 'package:bloc_test/bloc_test.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';

// const Iterable<Note> mockedNote = [
//   Note(title: 'note 1'),
//   Note(title: 'note 2'),
//   Note(title: 'note 3'),
//   Note(title: 'note 4'),
// ];

// @immutable
// class DummyNotesApi implements NotesApiProtocol {
//   final LoginHandle acceptedLoginHandle;
//   final Iterable<Note>? notesToReturnForAcceptedLoginHandle;

//   const DummyNotesApi({
//     required this.acceptedLoginHandle,
//     required this.notesToReturnForAcceptedLoginHandle,
//   });

//   const DummyNotesApi.empty()
//       : acceptedLoginHandle = const LoginHandle.foorBar(),
//         notesToReturnForAcceptedLoginHandle = null;

//   @override
//   Future<Iterable<Note>?> getNotes({
//     required LoginHandle loginHandle,
//   }) async {
//     if (loginHandle == acceptedLoginHandle) {
//       return notesToReturnForAcceptedLoginHandle;
//     } else {
//       return null;
//     }
//   }
// }

// @immutable
// class DummyLoginApi implements LoginApiProtocol {
//   final String acceptedEmail;
//   final String acceptedPassword;
//   final LoginHandle haddleToReturn;

//   const DummyLoginApi({
//     required this.acceptedEmail,
//     required this.acceptedPassword,
//     required this.haddleToReturn,
//   });

//   const DummyLoginApi.empty()
//       : acceptedEmail = '',
//         acceptedPassword = '',
//         haddleToReturn = const LoginHandle.foorBar();

//   @override
//   Future<LoginHandle?> login({
//     required String email,
//     required String password,
//   }) async {
//     if (email == acceptedEmail && password == acceptedPassword) {
//       return haddleToReturn;
//     } else {
//       return null;
//     }
//   }
// }

// void main() {
//   blocTest(
//     'Initial state of the bloc should be ',
//     build: () => AppBloc(
//       loginApi: const DummyLoginApi.empty(),
//       notesApi: const DummyNotesApi.empty(),
//     ),
//     verify: (appState) => expect(
//       appState.state,
//       const AppState.empty(),
//     ),
//   );

//   blocTest<AppBloc, AppState>(
//     'Can we Login with correct credentials',
//     build: () => AppBloc(
//       loginApi: const DummyLoginApi(
//         acceptedEmail: 'dinod',
//         acceptedPassword: '1234',
//         haddleToReturn: LoginHandle(token: 'ABC'),
//       ),
//       notesApi: const DummyNotesApi.empty(),
//     ),
//     act: (appBloc) => appBloc.add(
//       const LoginAction(
//         email: 'dinod',
//         password: '1234',
//       ),
//     ),
//     expect: () => [
//       const AppState(
//         isLoading: true,
//         loginError: null,
//         loginHandle: null,
//         fetchedNotes: null,
//       ),
//       const AppState(
//         isLoading: false,
//         loginError: null,
//         loginHandle: LoginHandle(token: 'ABC'),
//         fetchedNotes: null,
//       ),
//     ],
//   );

//   blocTest<AppBloc, AppState>(
//     'We should not be able to log in with invalid credentials...',
//     build: () => AppBloc(
//       loginApi: const DummyLoginApi(
//         acceptedEmail: 'dinods',
//         acceptedPassword: '1234s',
//         haddleToReturn: LoginHandle(token: 'ABC'),
//       ),
//       notesApi: const DummyNotesApi.empty(),
//     ),
//     act: (appBloc) => appBloc.add(
//       const LoginAction(
//         email: 'dinod',
//         password: '1234',
//       ),
//     ),
//     expect: () => [
//       const AppState(
//         isLoading: true,
//         loginError: null,
//         loginHandle: null,
//         fetchedNotes: null,
//       ),
//       const AppState(
//         isLoading: false,
//         loginError: LoginErrors.invalidHandle,
//         loginHandle: LoginHandle(token: 'ABC'),
//         fetchedNotes: null,
//       ),
//     ],
//   );

//   blocTest<AppBloc, AppState>(
//     'Load some notes with a valid login handle..;',
//     build: () => AppBloc(
//       loginApi: const DummyLoginApi(
//         acceptedEmail: 'dinod',
//         acceptedPassword: '1234',
//         haddleToReturn: LoginHandle(token: 'ABC'),
//       ),
//       notesApi: const DummyNotesApi(
//         acceptedLoginHandle: LoginHandle(token: 'ABC'),
//         notesToReturnForAcceptedLoginHandle: mockedNote,
//       ),
//     ),
//     act: (appBloc) => {
//       appBloc.add(
//         const LoginAction(
//           email: 'dinod',
//           password: '1234',
//         ),
//       ),
//       appBloc.add(
//         const LoadNotesAction(),
//       ),
//     },
//     expect: () => [
//       const AppState(
//         isLoading: true,
//         loginError: null,
//         loginHandle: null,
//         fetchedNotes: null,
//       ),
//       const AppState(
//         isLoading: false,
//         loginError: null,
//         loginHandle: LoginHandle(token: 'ABC'),
//         fetchedNotes: null,
//       ),
//     ],
//   );
// }
