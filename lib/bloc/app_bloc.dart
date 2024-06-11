import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:bloc_state_flutter/auth/auth_error.dart';
import 'package:bloc_state_flutter/utils/upload_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:bloc_state_flutter/bloc/app_event.dart';
import 'package:bloc_state_flutter/bloc/app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc()
      : super(
          const AppStateLoggedOut(
            isLoading: false,
          ),
        ) {
    on<AppEventInitialize>(appEventInitialize);
    on<AppEventUploadImage>(appEventUploadImage);
    on<AppEventDeleteAccount>(appEventDeleteAccount);
    on<AppEventLogOut>(appEventLogOut);
    on<AppEventRegister>(appEventRegister);
    on<AppEventGoToLogin>(appEventGoToLogin);
    on<AppEventLogin>(appEventLogin);
    on<AppEventGoToRegistration>(appEventGoToRegistration);
  }

  Future<Iterable<Reference>> _getImages(String userId) {
    return FirebaseStorage.instance
        .ref(userId)
        .list()
        .then((listResult) => listResult.items);
  }

  FutureOr<void> appEventUploadImage(
    AppEventUploadImage event,
    Emitter<AppState> emit,
  ) async {
    final user = state.user;
    if (user == null) {
      emit(const AppStateLoggedOut(isLoading: false));
      return;
    }
    //start the loading process....
    emit(
      AppStateLoggedIn(
        isLoading: true,
        user: user,
        images: state.images ?? [],
      ),
    );
    //upload the file
    final file = File(event.filePathToUpload);
    await uploadImage(file: file, userId: user.uid);
    //after upload is complete, grab the latest file references
    final images = await _getImages(user.uid);
    //emit the new images and turn off loading
    emit(
      AppStateLoggedIn(
        isLoading: false,
        user: user,
        images: images,
      ),
    );
  }

  FutureOr<void> appEventDeleteAccount(
    AppEventDeleteAccount event,
    Emitter<AppState> emit,
  ) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      emit(
        const AppStateLoggedOut(
          isLoading: false,
        ),
      );
      return;
    }
    //start the loading process....
    emit(
      AppStateLoggedIn(
        isLoading: true,
        user: user,
        images: state.images ?? [],
      ),
    );
    //detele the user folder....
    try {
      //delete user folder
      //delete folder items
      final folderContents =
          await FirebaseStorage.instance.ref(user.uid).listAll();
      for (final item in folderContents.items) {
        await item.delete().catchError(onError);
      }
      //delete folder
      FirebaseStorage.instance.ref(user.uid).delete().catchError(
            onError,
          );

      //delete user
      await user.delete();
      //log the user out
      await FirebaseAuth.instance.signOut();
      emit(
        const AppStateLoggedOut(
          isLoading: false,
        ),
      );
    } on FirebaseAuthException catch (e) {
      emit(
        AppStateLoggedIn(
          isLoading: false,
          user: user,
          images: state.images ?? [],
          authError: AuthError.from(e),
        ),
      );
    } on FirebaseException {
      //we might not be able to delete the folder
      //log the user out
      emit(
        const AppStateLoggedOut(
          isLoading: false,
        ),
      );
    }
  }

  FutureOr<void> appEventLogOut(
    AppEventLogOut event,
    Emitter<AppState> emit,
  ) async {
    //start the loading process....
    emit(
      const AppStateLoggedOut(
        isLoading: true,
      ),
    );
    //log the user out
    await FirebaseAuth.instance.signOut();
    emit(
      const AppStateLoggedOut(
        isLoading: false,
      ),
    );
  }

  FutureOr<void> appEventInitialize(
    AppEventInitialize event,
    Emitter<AppState> emit,
  ) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      emit(
        const AppStateLoggedOut(
          isLoading: false,
        ),
      );
    } else {
      //go grab the user's uploaded images
      final image = await _getImages(user.uid);
      emit(
        AppStateLoggedIn(
          isLoading: false,
          user: user,
          images: image,
        ),
      );
    }
  }

  FutureOr<void> appEventRegister(
    AppEventRegister event,
    Emitter<AppState> emit,
  ) async {
    emit(
      const AppStateIsInRegistrationView(
        isLoading: true,
      ),
    );
    final email = event.email;
    final password = event.password;

    try {
      //create user
      final credentials =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      //get user images
      // final userId = credentials.user!.uid;
      emit(
        AppStateLoggedIn(
          isLoading: false,
          user: credentials.user!,
          images: const [],
        ),
      );
    } on FirebaseAuthException catch (e) {
      emit(
        AppStateIsInRegistrationView(
          isLoading: false,
          authError: AuthError.from(e),
        ),
      );
    }
  }

  FutureOr<void> appEventGoToLogin(
    AppEventGoToLogin event,
    Emitter<AppState> emit,
  ) {
    emit(
      const AppStateLoggedOut(
        isLoading: false,
      ),
    );
  }

  FutureOr<void> appEventLogin(
    AppEventLogin event,
    Emitter<AppState> emit,
  ) async {
    emit(
      const AppStateLoggedOut(isLoading: true),
    );
    //log the user in
    final email = event.email;
    final password = event.password;

    try {
      final userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = userCredential.user!;
      final images = await _getImages(user.uid);
      emit(
        AppStateLoggedIn(
          isLoading: false,
          user: user,
          images: images,
        ),
      );
    } on FirebaseAuthException catch (e) {
      emit(
        AppStateLoggedOut(
          isLoading: false,
          authError: AuthError.from(e),
        ),
      );
    }
  }

  FutureOr<void> appEventGoToRegistration(
    AppEventGoToRegistration event,
    Emitter<AppState> emit,
  ) {
    emit(
      const AppStateIsInRegistrationView(
        isLoading: false,
      ),
    );
  }
}
