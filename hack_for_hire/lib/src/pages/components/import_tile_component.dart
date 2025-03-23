
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../controllers/transaction_import_controller.dart';
import '../../models/transaction_model.dart';

class DataImporterTile extends ConsumerStatefulWidget {
  const DataImporterTile({super.key});

  @override
  ConsumerState createState() => _DataImporterTileState();
}

class _DataImporterTileState extends ConsumerState<DataImporterTile> {
  List<Transaction> transactions = [];

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text("Import Transactions (json)"),
      leading: Icon(Icons.upload),
      onTap: () async {
        final scaffoldMessenger = ScaffoldMessenger.of(context); // sto
        final importer = TransactionImporterController();
        final importedTransactions = await importer.importTransactions();
        setState(() {
          transactions = importedTransactions;
        });

        // Optionally, show a success message
        scaffoldMessenger.showSnackBar(
          SnackBar(
              content: Text('${transactions.length} transactions imported!')),
        );

        // if (transactions.isNotEmpty) ...[
        // SizedBox(height: 20),
        // Text('Imported Transactions:'),
        // for (var transaction in transactions)
        // Text('ID: ${transaction.id}, Amount: ${transaction.amount}'),
        // ],
      },
    );
  }
}