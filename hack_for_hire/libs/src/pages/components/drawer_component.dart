import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../settings_page.dart';
import '../transactions_page.dart';


class DrawerComponent extends StatelessWidget {
  const DrawerComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ListTile(
              title: Text("Dashboard"),
              leading: Icon(Icons.home),
              onTap: () {
                if(context.canPop()) {
                  context.pop();
                }
                context.go('/');
              },
            ),
            ListTile(
              title: Text("Transactions"),
              leading: Icon(Icons.currency_exchange),
              onTap: () {
                if(context.canPop()) {
                  context.pop();
                }
                context.go(TransactionsPage.path);
              },
            ),
            ListTile(
              title: Text("Settings"),
              leading: Icon(Icons.settings),
              onTap: () {
                if(context.canPop()) {
                  context.pop();
                }
                context.go(SettingsPage.path);
              },
            ),
          ],
        ),
      ),
    );
  }
}
