import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:logging/logging.dart';

import '../providers/theme_provider.dart';
import 'components/drawer_component.dart';
import 'components/piechart_component.dart';
import 'transaction_form_page.dart';

final logger = Logger('myLogger');

class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key, required this.title});

  static final String path = '/';

  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      drawer: DrawerComponent(),
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
        centerTitle: true,
        actions: [
          Switch(
            value: ref.watch(isLightThemeProvider),
            onChanged: (bool value) {
              ref.read(isLightThemeProvider.notifier).toggle();
            },
          )
        ],
      ),
      body: Column(
        children: [

          PieChartSample1(),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          context.go(TransactionFormPage.path);
        },
        label: Text("Add Transactions"),
        icon: Icon(Icons.add),
      ),
    );
  }
}


