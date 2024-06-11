import 'package:bloc_state_flutter/dialogs/generic_dialog.dart';
import 'package:flutter/material.dart';

Future<bool> showDeleteAccountDialog(BuildContext context) {
  return showGenericDialog<bool>(
    context: context,
    title: 'Delete Account!',
    content:
        'Are you sure you want to delete your account? You cannot undo this operation!',
    optionBulder: () => {
      'Cancel': false,
      'Delete account': true,
    },
  ).then(
    (value) => value ?? false,
  );
}
