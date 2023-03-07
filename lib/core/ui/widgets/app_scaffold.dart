import 'package:flutter/material.dart';

import '../../constants.dart';
import 'app_drawer.dart';

class AppScaffold extends StatelessWidget {
  AppScaffold(
      {super.key,
      required this.title,
      required this.body,
      this.button,
      this.actions,
      required this.withDrawer});
  final String title;
  final Widget body;
  final FloatingActionButton? button;
  final List<Widget>? actions;
  bool withDrawer = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: button,
      appBar: AppBar(
        iconTheme:
            IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
        backgroundColor: Theme.of(context).primaryColor,
        actions: actions,
        title: Text(
          title,
          style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
        ),
      ),
      body: body,
      drawer: withDrawer!
          ? AppDrawer(
              items: [
                DrawerItem(text: 'Dashboard', icon: Icons.home),
                DrawerItem(text: 'Transactions', icon: Icons.attach_money)
              ],
              onItemSelected: (item) {
                switch (item) {
                  case Routes.Home:
                    Navigator.pushNamed(context, Routes.Home);
                    break;

                  case Routes.Transactions:
                    Navigator.pushNamed(context, Routes.Transactions);
                    break;
                }
              },
            )
          : null,
    );
  }
}
