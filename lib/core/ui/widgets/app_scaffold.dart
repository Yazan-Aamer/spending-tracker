import 'package:flutter/material.dart';

import '../../constants.dart';
import 'app_drawer.dart';

class AppScaffold extends StatelessWidget {
  const AppScaffold({
    super.key,
    required this.title,
    required this.body,
    this.button,
  });
  final String title;
  final Widget body;
  final FloatingActionButton? button;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: button,
      appBar: AppBar(
        title: Text(title),
      ),
      body: body,
      drawer: AppDrawer(
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
      ),
    );
  }
}
