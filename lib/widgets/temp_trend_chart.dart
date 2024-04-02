import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class TempTrendChart extends StatelessWidget {
  const TempTrendChart(
      {super.key,
      required this.items,
      required this.tempsMax,
      required this.colorMax,
      this.tempsMin,
      this.colorMin});
  final List<Widget> items;
  final List<int> tempsMax;
  final Color colorMax;
  final Color? colorMin;
  final List<int>? tempsMin;
  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print("111 len: ${tempsMax.length}");
    }
    return LineChart(sampleData);
  }

  LineChartData get sampleData => LineChartData(
        titlesData: titlesData,
        lineBarsData: tempsMin != null
            ? [lineChartBarDataMax, lineChartBarDataMin]
            : [lineChartBarDataMax],
        gridData: const FlGridData(show: false),
        minY: min(
            tempsMax
                .reduce((curr, next) => curr < next ? curr : next)
                .toDouble(),
            tempsMin
                    ?.reduce((curr, next) => curr < next ? curr : next)
                    .toDouble() ??
                19999),
        maxY: max(
                tempsMax
                    .reduce((curr, next) => curr > next ? curr : next)
                    .toDouble(),
                tempsMin
                        ?.reduce((curr, next) => curr > next ? curr : next)
                        .toDouble() ??
                    0) +
            1,
      );
  FlTitlesData get titlesData => FlTitlesData(
        topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        rightTitles:
            const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1.1,
            reservedSize: 75,
            getTitlesWidget: (v, meta) {
              if (kDebugMode) {
                print("index: ${v.floor()}");
              }
              return Center(
                child: items[v.floor()],
              );
            },
          ),
        ),
      );
  LineChartBarData get lineChartBarDataMax => LineChartBarData(
      spots: () {
        List<FlSpot> spots = [];
        for (var i = 0; i < tempsMax.length; i++) {
          spots.add(FlSpot(i.toDouble(), tempsMax[i].toDouble()));
        }
        return spots;
      }(),
      isCurved: true,
      color: colorMax,
      dotData: const FlDotData(show: true),
      belowBarData: BarAreaData(
          show: true,
          gradient: LinearGradient(
              colors: const [Colors.white, Colors.blue]
                  .map((e) => e.withOpacity(0.3))
                  .toList())));

  LineChartBarData get lineChartBarDataMin => LineChartBarData(
      spots: () {
        List<FlSpot> spots = [];
        for (var i = 0; i < tempsMin!.length; i++) {
          spots.add(FlSpot(i.toDouble(), tempsMin![i].toDouble()));
        }
        return spots;
      }(),
      isCurved: true,
      color: colorMin,
      dotData: const FlDotData(show: true));
}
