import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../models/transaction_model.dart';
import '../providers/transaction_provider.dart';
import 'components/filterbutton_component.dart';

class TransactionsPage extends ConsumerWidget {
  const TransactionsPage({super.key});

  static final String path = '/transactions';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transactionList = ref.watch(transactionListProvider);

    if (transactionList.isLoading ||
        transactionList.isRefreshing ||
        transactionList.isReloading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    if (transactionList.hasError || transactionList.value == null) {
      return Center(
        child: Text("An error has occurred."),
      );
    }

    final List<Transaction> transactions = transactionList.value!;


    return Scaffold(
      body: CustomScrollView(slivers: [
        SliverAppBar(
          centerTitle: true,
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          expandedHeight: 120.0,
          pinned: true,
          // Keep app bar visible when scrolling
          leading: IconButton(
            icon: const Icon(Icons.arrow_back), // Back arrow icon
            onPressed: () {
              Navigator.of(context).pop(); // Navigate back
            },
          ),

          flexibleSpace: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              // Calculate how much the AppBar has collapsed
              double percent = (constraints.maxHeight - kToolbarHeight) / (120.0 - kToolbarHeight);
              percent = percent.clamp(0.0, 1.0);
              if (percent <= 0.4) {
              percent = 0.4;
              }
              return FlexibleSpaceBar(
                titlePadding: EdgeInsets.only(bottom: 16), // Adjust title position
                title: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('Transactions', style: TextStyle(fontSize: 18)), // Title
                    SizedBox(height: 2),

                    // Hide buttons when collapsed
                    Opacity(
                      opacity: percent, // 1 when expanded, 0 when collapsed
                      child: percent > 0.1 // Only show if not fully collapsed
                          ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          // Sort By Button
                          SizedBox(
                            height: 30,
                            child: MenuAnchor(
                              builder: (BuildContext context, MenuController controller, Widget? child) {
                                return ElevatedButton(
                                  onPressed: () {
                                    controller.isOpen ? controller.close() : controller.open();
                                  },
                                  child: Text('Sort By'),
                                );
                              },
                              menuChildren: [
                                MenuItemButton(
                                  onPressed: () {
                                    ref.read(transactionListProvider.notifier).sortBy("type");
                                  },
                                  child: Text('Sort by Type'),
                                ),
                                MenuItemButton(
                                  onPressed: () {
                                    ref.read(transactionListProvider.notifier).sortBy("time");
                                  },
                                  child: Text('Sort by Time'),
                                ),
                              ],
                            ),
                          ),

                          // Filter Button
                          SizedBox(
                              height: 30,
                              child: FilterButton()),
                        ],
                      )
                          : SizedBox.shrink(),
                    ),
                  ],
                ),
              );
            },
          ),),
        SliverList.builder(
          itemCount: transactions.length,
          itemBuilder: (context, index) {
            final Transaction t = transactions[index];
            return ListTile(
                title: Text(t.description),
                tileColor: t.type == TransactionType.outcome
                    ? Color(0xffedb6b9)
                    : Color(0xffaad3c1),
                subtitle: Text('Amount: €${t.amount.toStringAsFixed(2)}'),
                trailing: IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () => context.push('/transactions/${t.id}'),
                ));
          },
        ),
        SliverToBoxAdapter(child: SizedBox(height: 110,),)
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/transactions/new'),
        child: Icon(Icons.add),
      ),
    );
  }
}

