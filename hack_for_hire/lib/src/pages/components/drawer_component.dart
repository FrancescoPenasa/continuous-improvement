import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hack_for_hire/src/pages/home_page.dart';

import '../user_page.dart';

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
              title: Text("HomePage"),
              leading: Icon(Icons.message),
              onTap: () {
                context.go(MyHomePage.path);
              },
            ),
            ListTile(
              title: Text("UserPage"),
              leading: Icon(Icons.image),
              onTap: () {
                context.go(UserPage.path);
              },
            ),
          ],
        ),
      ),
    );
  }
}
