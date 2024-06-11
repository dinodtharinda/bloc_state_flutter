import 'package:bloc_state_flutter/bloc/app_bloc.dart';
import 'package:bloc_state_flutter/bloc/app_event.dart';
import 'package:bloc_state_flutter/dialogs/delete_accout_dialog.dart';
import 'package:bloc_state_flutter/dialogs/logout_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum MenuAction { logout, deleteAccount }

class MainPopupMenuButton extends StatelessWidget {
  const MainPopupMenuButton({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      onSelected: (value) async {
        switch (value) {
          case MenuAction.logout:
            final finalShouldLogout = await showLogoutDialog(context);

            if (finalShouldLogout) {
              context.read<AppBloc>().add(
                    const AppEventLogOut(),
                  );
            }

            break;
          case MenuAction.deleteAccount:
            final shouldDeleteAccount = await showDeleteAccountDialog(context);
            if (shouldDeleteAccount) {
              context.read<AppBloc>().add(
                    const AppEventDeleteAccount(),
                  );
            }
            break;
        }
      },
      itemBuilder: (context) {
        return [
          const PopupMenuItem<MenuAction>(
            value: MenuAction.logout,
            child: Text('Log out'),
          ),
          const PopupMenuItem<MenuAction>(
            value: MenuAction.deleteAccount,
            child: Text('Delete account'),
          ),
        ];
      },
    );
  }
}
