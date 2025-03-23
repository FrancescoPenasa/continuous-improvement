import 'package:shared_preferences/shared_preferences.dart';

import '../models/transaction_model.dart';

class TransactionRepository {
  // Get all transactions from SharedPreferences
  Future<List<Transaction>> getTransactions() async {
    final prefs = await SharedPreferences.getInstance();
    final transactionIds = prefs.getStringList('transaction_ids') ?? [];

    List<Transaction> transactions = [];
    for (String id in transactionIds) {
      final jsonString = prefs.getString('transaction_$id');
      if (jsonString != null) {
        transactions.add(Transaction.fromJsonString(jsonString));
      }
    }
    return transactions;
  }

  // Get a single transaction by ID
  Future<Transaction?> getTransactionById(String id) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('transaction_$id');
    if (jsonString != null) {
      return Transaction.fromJsonString(jsonString);
    }
    return null; // Return null if transaction doesn't exist
  }

  Future<void> saveTransaction(Transaction transaction) async {
    final prefs = await SharedPreferences.getInstance();
    // Save a single transaction
    await prefs.setString('transaction_${transaction.id}', transaction.toJsonString());

    // Add transaction ID to the list of IDs
    List<String> transactionIds = prefs.getStringList('transaction_ids') ?? [];
    transactionIds.add(transaction.id);
    await prefs.setStringList('transaction_ids', transactionIds);
  }


  // Delete a single transaction by ID
  Future<void> deleteTransaction(String id) async {
    final prefs = await SharedPreferences.getInstance();
    // Remove transaction from SharedPreferences
    await prefs.remove('transaction_$id');

    // Remove transaction ID from the list of IDs
    List<String> transactionIds = prefs.getStringList('transaction_ids') ?? [];
    transactionIds.remove(id);
    await prefs.setStringList('transaction_ids', transactionIds);
  }
}