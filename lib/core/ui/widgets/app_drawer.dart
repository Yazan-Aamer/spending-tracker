import 'package:flutter/material.dart';

class DrawerItem {
  final String text;
  final IconData? icon;

  DrawerItem({required this.text, this.icon});
}

class AppDrawer extends StatelessWidget {
  const AppDrawer({
    super.key,
    required this.items,
    required this.onItemSelected,
  });

  final List<DrawerItem> items;

  final Function(String) onItemSelected;

  @override
  Widget build(BuildContext context) {
    final drawerItems = ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(items[index].text),
          leading: Icon(items[index].icon),
          onTap: () => onItemSelected(items[index].text),
        );
      },
    );

    return Drawer(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration:
                BoxDecoration(color: Theme.of(context).colorScheme.primary),
            child: SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Menu',
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                ),
              ),
            ),
          ),
          Expanded(
            child: drawerItems,
          ),
        ],
      ),
    );
  }
}
