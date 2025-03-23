import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/transaction_model.dart';
import '../../providers/transaction_provider.dart';

class FilterButton extends ConsumerStatefulWidget {
  const FilterButton({super.key});

  @override
  _FilterButtonState createState() => _FilterButtonState();
}

class _FilterButtonState extends ConsumerState<FilterButton> {
  // Track selected filters
  Set<TransactionType> selectedFilters = {
    TransactionType.income,
    TransactionType.outcome
  };

  void toggleFilter(TransactionType type) {
    setState(() {
      if (selectedFilters.contains(type)) {
        selectedFilters.remove(type);
      } else {
        selectedFilters.add(type);
      }
    });

    // Apply the filter to the provider
    ref.read(transactionListProvider.notifier).filterBy(selectedFilters);
  }

  @override
  Widget build(BuildContext context) {
    return MenuAnchor(
      builder: (BuildContext context, MenuController controller, Widget? child) {
        return ElevatedButton(
          onPressed: () {
            controller.isOpen ? controller.close() : controller.open();
          },
          child: Text('Filter By'),
        );
      },

      menuChildren: [
        SizedBox(
          width: 180,
          child: CheckboxListTile(
            title: Text('Income'),
            value: selectedFilters.contains(TransactionType.income),
            onChanged: (_) => toggleFilter(TransactionType.income),
          ),
        ),
        SizedBox(
          width: 180,
          child: CheckboxListTile(
            title: Text('Outcome',),
            value: selectedFilters.contains(TransactionType.outcome),
            onChanged: (_) => toggleFilter(TransactionType.outcome),
          ),
        ),
      ],
    );
  }
}
