import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/transaction_provider.dart';
import 'components/import_tile_component.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  static final String path = '/settings';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
        GlobalKey<ScaffoldMessengerState>();

    return Scaffold(
        key: scaffoldMessengerKey,
        body: CustomScrollView(slivers: [
          SliverAppBar(
            centerTitle: true,
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            expandedHeight: 100.0,
            pinned: true,
            // Keep app bar visible when scrolling
            leading: IconButton(
              icon: const Icon(Icons.arrow_back), // Back arrow icon
              onPressed: () {
                Navigator.of(context).pop(); // Navigate back
              },
            ),
            flexibleSpace: FlexibleSpaceBar(
              title: Text("Settings"),
            ),
          ),
          SliverList.list(children: [
            Divider(),
            Center(
                child: Text(
              "Data management",
              style: Theme.of(context).textTheme.titleSmall,
            )),
            DataImporterTile(),
            ListTile(
              title: Text("Export Transactions (json)"),
              leading: Icon(Icons.download),
              onTap: () async {
                await ref
                    .read(transactionListProvider.notifier)
                    .exportTransactions()
                    .then((value) => ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Export Saved in $value'),
                            duration: Duration(seconds: 4),
                          ),
                        ));
              },
            ),
            Divider(),
          ]),
        ]));
  }
}
