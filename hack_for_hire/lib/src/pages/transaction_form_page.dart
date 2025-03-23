import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/transaction_model.dart';
import '../providers/transaction_provider.dart';

class TransactionFormPage extends ConsumerStatefulWidget {
  static final String path = '/transactions/new';
  final String? transactionId;

  const TransactionFormPage({super.key, this.transactionId});

  @override
  ConsumerState createState() => _TransactionFormPageState();
}

class _TransactionFormPageState extends ConsumerState<TransactionFormPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  TransactionType _transactionType = TransactionType.outcome;

  @override
  void initState() {
    super.initState();
    if (widget.transactionId != null) {
      _loadTransactionData(widget.transactionId!);
    }
  }

  void _loadTransactionData(String id) async {
    ref.read(transactionListProvider.notifier).getTransaction(id);
    final prefs = await SharedPreferences.getInstance();
    // Load the transaction JSON string from SharedPreferences
    String? jsonString = prefs.getString('transaction_$id');

    if (jsonString != null) {
      // Convert the JSON string back into a Transaction object
      Transaction transaction = Transaction.fromJsonString(jsonString);

      // Update the form fields
      setState(() {
        _amountController.text = transaction.amount.toString();
        _descriptionController.text = transaction.description;
        _transactionType = transaction.type;
      });
    }
  }

  void _saveTransaction() async {
    if (_formKey.currentState!.validate()) {
      String message = widget.transactionId == null
          ? "New transaction created!"
          : "Transaction ${widget.transactionId} updated!";

      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(message)));
      }

      widget.transactionId == null
          ? ref
              .read(transactionListProvider.notifier)
              .saveTransaction(Transaction(
                id: DateTime.now().millisecondsSinceEpoch.toString(),
                amount: double.parse(_amountController.text),
                description: _descriptionController.text,
                timestamp: DateTime.now(),
                type: _transactionType,
              ))
          : ref
              .read(transactionListProvider.notifier)
              .updateTransaction(Transaction(
                id: widget.transactionId!,
                amount: double.parse(_amountController.text),
                description: _descriptionController.text,
                timestamp: DateTime.now(),
                type: _transactionType,
              ));

      if (mounted) {
        context.pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isEditing = widget.transactionId != null;

    return Scaffold(
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
          title: Text(isEditing ? "Edit Transaction" : "New Transaction"),
        ),
      ),
      SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SegmentedButton(
                  segments: const <ButtonSegment<TransactionType>>[
                    ButtonSegment<TransactionType>(
                      value: TransactionType.income,
                      label: Text('Income'),
                      icon: Icon(Icons.add),
                    ),
                    ButtonSegment<TransactionType>(
                      value: TransactionType.outcome,
                      label: Text('Outcome'),
                      icon: Icon(Icons.remove),
                    ),
                  ],
                  selected: <TransactionType>{_transactionType},
                  onSelectionChanged: (Set<TransactionType> newType) {
                    setState(() {
                      _transactionType = newType.first;
                    });
                  },
                ),
                TextFormField(
                    controller: _amountController,
                    decoration: InputDecoration(labelText: "Amount"),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      // substitute last comma with dot, remove all commas
                      int commaIndex = _amountController.text.lastIndexOf(",");
                      if(commaIndex != -1) {
                        _amountController.text =
                            "${_amountController.text.substring(
                                0, commaIndex)}.${_amountController.text
                                .substring(
                                commaIndex + 1, _amountController.text.length)}"
                                .replaceAll(",", "").replaceAll("'", "");
                      }

                      String? err;
                      if (value == null || value.isEmpty) {
                        err = "Enter an amount";
                      }
                      if (double.tryParse(_amountController.text) == null) {
                        err = "Enter a valid amount";
                      }
                      return err;
                    }),
                TextFormField(
                  controller: _descriptionController,
                  decoration: InputDecoration(labelText: "Description"),
                  validator: (value) =>
                      value!.isEmpty ? "Enter a description" : null,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _saveTransaction,
                  child: Text(
                      isEditing ? "Update Transaction" : "Create Transaction"),
                ),
              ],
            ),
          ),
        ),
      ),
    ]));
  }
}
