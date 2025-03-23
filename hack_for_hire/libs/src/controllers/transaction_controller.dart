import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

import '../models/transaction_model.dart';
import '../repositories/transaction_repository.dart';

class TransactionController {
  late final TransactionRepository _transactionRepository;

  TransactionController({required TransactionRepository transactionRepository})
      : _transactionRepository = transactionRepository;

  // Fetch all transactions
  Future<List<Transaction>> getTransactions() async {
    final transactions = await _transactionRepository.getTransactions();
    return transactions;
  }

  // Fetch one transaction
  Future<Transaction?> getTransactionById(String id) async {
    final transaction = await _transactionRepository.getTransactionById(id);
    return transaction;
  }

  // Save a transaction
  Future<void> saveTransaction(Transaction t) async {
    await _transactionRepository.saveTransaction(t);
  }

  // update a transaction
  Future<void> updateTransaction(Transaction t) async {
    await _transactionRepository.deleteTransaction(t.id);
    await _transactionRepository.saveTransaction(t);
  }


  Future<File> exportTransactions() async {
    final file = await _localFile;
    final transactions = await getTransactions();
    return file.writeAsString(jsonEncode(transactions));
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/transactions.txt');
  }

  Future<String> get _localPath async {
    Directory? directory = await getDownloadsDirectory();
    directory ??= await getApplicationDocumentsDirectory();
    return directory.path;
  }

}
