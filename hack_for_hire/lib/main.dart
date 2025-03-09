import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:logging/logging.dart';

import 'src/pages/home_page.dart';
import 'src/providers/theme_provider.dart';

final log = Logger('ExampleLogger');

void main() {
  Logger.root.level = Level.ALL; // defaults to Level.INFO
  // Logger.root.onRecord.listen((record) {
  //   print('${record.level.name}: ${record.time}: ${record.message}');
  // });

  runApp(ProviderScope(child: MyApp()));
}

final GoRouter _router = GoRouter(
  initialLocation: '/',
  routes: <RouteBase>[
    GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return MyHomePage(title: 'template');
        },
        routes: <RouteBase>[
          GoRoute(
              path: 'detail',
              builder: (BuildContext context, GoRouterState state) {
                return MyHomePage(
                  title: 'details',
                );
              }),
        ]),
  ],
);

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLightTheme = ref.watch(isLightThemeProvider);

    return MaterialApp.router(
      routerConfig: _router,
      title: 'hack for hire 2025',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple, secondary:  Colors.deepPurpleAccent),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black, secondary: Colors.grey),
        useMaterial3: true,
      ),
      themeMode: isLightTheme ? ThemeMode.light : ThemeMode.dark,
    );
  }
}

