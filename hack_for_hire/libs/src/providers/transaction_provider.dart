import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../controllers/transaction_controller.dart';
import '../models/transaction_model.dart';
import '../repositories/transaction_repository.dart';

part 'transaction_provider.g.dart';

@riverpod
class TransactionList extends _$TransactionList {
  final TransactionController transactionController = TransactionController(
      transactionRepository: TransactionRepository());

  @override
  Future<List<Transaction>> build() async {
    try {
      final transactions = await transactionController.getTransactions();
      return transactions;
    } catch (error) {
      return [];
    }
  }

  Map<String, double> getStatistics() {
    Map<String, double> result = {};
    if (state.value == null) {
      return result;
    }

    double plus = 0.0;
    double minus = 0.0;

    for (Transaction t in state.value!) {
      if (t.type == TransactionType.income) {
        plus += t.amount;
      } else if (t.type == TransactionType.outcome) {
        minus += t.amount;
      }
    }
    return {"Plus": plus, "Minus": minus};
  }

  Future<void> sortBy(String sortType) async {
    if (state.value == null) return;

    // Create a new list to avoid mutating state directly
    List<Transaction> sortedTransactions = List.from(state.value!);

    // Sort based on the sortType
    sortedTransactions.sort((a, b) {
      return sortType == "time"
          ? a.timestamp.compareTo(b.timestamp)
          : a.type.index.compareTo(b.type.index);
    });

    // Update state with a new AsyncValue
    state = AsyncValue.data(sortedTransactions);
  }

  Future<void> filterBy(Set<TransactionType> filters) async {
    if (state.value == null) return;

    final transactions = await transactionController.getTransactions();

    // Apply filtering
    List<Transaction> filteredTransactions = transactions
        .where((t) => filters.contains(t.type))
        .toList();

    state = AsyncValue.data(filteredTransactions);
  }




  Future<Transaction?> getTransaction(String id) async {
    return await transactionController.getTransactionById(id);
  }

  Future<void> saveTransaction(Transaction transaction) async {
    await transactionController.saveTransaction(transaction);
    state = AsyncValue.data(await transactionController.getTransactions());
    // This will notify all listeners.
    // throw an error if the state is in error state.
    // final previousState = await future;
    // state = AsyncData([...previousState, transaction]);
  }

  Future<void> updateTransaction(Transaction t) async {
    await transactionController.updateTransaction(t);
    //     // and will notify listeners when doing so.
    //     ref.invalidateSelf();
    state = AsyncValue.data(await transactionController.getTransactions());
  }

  // export in json format
  Future<String> exportTransactions() async {
    final result = await transactionController.exportTransactions();
    return result.absolute.path;
  }

}