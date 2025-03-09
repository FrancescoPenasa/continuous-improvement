import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hack_for_hire/src/pages/components/drawer_component.dart';
import 'package:hack_for_hire/src/providers/theme_provider.dart';

class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  static final String path = '/';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      drawer: DrawerComponent(),
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
        centerTitle: true,
        actions: [
          Switch(value: ref.watch(isLightThemeProvider),
          onChanged:  (bool value) {
            ref.read(isLightThemeProvider.notifier).toggle();
          },)
        ],
      ),
      body: Column(
        children: [Text("ciao")],
      ),
    );
  }
}
