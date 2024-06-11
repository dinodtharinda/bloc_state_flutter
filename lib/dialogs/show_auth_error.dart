import 'package:bloc_state_flutter/auth/auth_error.dart';
import 'package:bloc_state_flutter/dialogs/generic_dialog.dart';
import 'package:flutter/material.dart';

Future<void> showAuthError(
  AuthError authError,
  BuildContext context,
) {
  return showGenericDialog<bool>(
    context: context,
    title: authError.dialogTitle,
    content: authError.dialogText,
    optionBulder: () => {
      'Ok': true,
    },
  );
}
