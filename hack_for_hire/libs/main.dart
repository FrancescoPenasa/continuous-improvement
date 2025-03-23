import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hack_for_hire/src/pages/settings_page.dart';
import 'package:logging/logging.dart';

import 'src/pages/home_page.dart';
import 'src/pages/transaction_form_page.dart';
import 'src/pages/transactions_page.dart';
import 'src/providers/theme_provider.dart';


void main() {
  final log = Logger('myLogger');
  log.info('app started');

  runApp(ProviderScope(child: MyApp()));
}


final GoRouter _router = GoRouter(
  initialLocation: '/',
  routes: <RouteBase>[
    GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return MyHomePage(title: 'Expense Tracker');
        },
        routes: <RouteBase>[

          // general view
          GoRoute(
              path: 'transactions',
              builder: (BuildContext context, GoRouterState state) {
                return TransactionsPage();
              },
          ),

          // new transaction
          GoRoute(
              path: 'transactions/new',
              builder: (BuildContext context, GoRouterState state) {
                return TransactionFormPage();
              }),

          // edit transaction
          GoRoute(
              path: 'transactions/:id',
              builder: (BuildContext context, GoRouterState state) {
                final String id = state.pathParameters['id']!;
                return TransactionFormPage(transactionId: id);
              }),

          // settings
          GoRoute(
              path: 'settings',
              builder: (BuildContext context, GoRouterState state) {
                return SettingsPage();
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
        textTheme: TextTheme(
        titleSmall: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepPurple, secondary: Colors.deepPurpleAccent),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        textTheme: TextTheme(
          titleSmall: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.black, secondary: Colors.grey),
        useMaterial3: true,
      ),
      themeMode: isLightTheme ? ThemeMode.light : ThemeMode.dark,
    );
  }
}

