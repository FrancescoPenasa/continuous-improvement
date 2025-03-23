import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/transaction_provider.dart';

class PieChartSample1 extends ConsumerWidget {
  final double dotSize = 14.0;

  const PieChartSample1({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transactionState = ref.watch(transactionListProvider);


    return transactionState.when(
      data: (transactions) {
        final data = ref.read(transactionListProvider.notifier).getStatistics();

        return AspectRatio(
          aspectRatio: 1.3,
          child: Column(
            children: <Widget>[
              const SizedBox(height: 28),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  for (MapEntry<String, double> entry in data.entries)... [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: dotSize,
                          height: dotSize,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: entry.key == "Plus" ? Colors.green: Colors.red,
                          )),
                        SizedBox(width: 10.0,),
                        Text("${entry.key}: ${entry.value.toStringAsFixed(2)}")
                      ],
                    ),
                  ]
                ],
              ),
              const SizedBox(height: 18),
              Expanded(
                child: AspectRatio(
                  aspectRatio: 1,
                  child: PieChart(
                    PieChartData(
                      startDegreeOffset: 180,
                      sectionsSpace: 1,
                      centerSpaceRadius: 0,
                      sections: showingSections(data),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) => Center(child: Text('Error: $error')),
    );
  }

  List<PieChartSectionData> showingSections(Map<String, double> data) {
    // print(data);
    List<PieChartSectionData> chartData = [];
    for (MapEntry<String, double> entry in data.entries) {
      chartData.add(PieChartSectionData(
        color: entry.key == "Plus" ? Colors.green : Colors.red ,
        value: entry.value, // todo cambiare questo
        title: entry.key,
        radius: 80,
        titlePositionPercentageOffset: 0.55,
      ));
    }
    return chartData;
  }
}