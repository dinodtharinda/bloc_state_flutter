import 'package:bloc_state_flutter/dialogs/generic_dialog.dart';
import 'package:flutter/material.dart';

Future<bool> showLogoutDialog(BuildContext context) {
  return showGenericDialog<bool>(
    context: context,
    title: 'Log Out',
    content:
        'Are you sure you want to logout now?',
    optionBulder: () => {
      'Cancel': false,
      'Log out': true,
    },
  ).then(
    (value) => value ?? false,
  );
}
