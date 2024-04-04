import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class TempTrendChart extends StatefulWidget {
  const TempTrendChart(
      {super.key,
      this.itemMax,
      this.tempsMin,
      this.colorMin,
      this.itemMin,
      required this.tempsMax,
      required this.colorMax,
      this.itemMaxSize,
      this.itemMinSize,
      required this.getDotDataWidget});
  final List<Widget>? itemMax;
  final Widget Function(double value) getDotDataWidget;
  final List<Widget>? itemMin;
  final List<int> tempsMax;
  final Color colorMax;
  final Color? colorMin;
  final List<int>? tempsMin;
  final double? itemMaxSize;
  final double? itemMinSize;
  @override
  State<TempTrendChart> createState() => _TempTrendChartState();
}

class _TempTrendChartState extends State<TempTrendChart> {
  late final List<Widget>? itemMax;
  late final List<Widget>? itemMin;
  late final List<FlSpot> tempsMax;
  late final Color colorMax;
  late final Color? colorMin;
  late final List<FlSpot>? tempsMin;
  late final double? itemMaxSize;
  late final double? itemMinSize;
  late final double minY, maxY, maxX, minX;
  @override
  void initState() {
    super.initState();
    itemMax = widget.itemMax;
    itemMin = widget.itemMin;
    tempsMax = _toFlSpot(widget.tempsMax);
    colorMax = widget.colorMax;
    colorMin = widget.colorMin;
    tempsMin = widget.tempsMin != null ? _toFlSpot(widget.tempsMin!) : null;
    itemMaxSize = widget.itemMaxSize;
    itemMinSize = widget.itemMinSize;
    maxX = widget.tempsMax.length.toDouble();
    minX = 0;
    minY = 0;
    maxY = max(
            widget.tempsMax
                .reduce((curr, next) => curr > next ? curr : next)
                .toDouble(),
            widget.tempsMin
                    ?.reduce((curr, next) => curr > next ? curr : next)
                    .toDouble() ??
                0) +
        0.5;
  }

  List<FlSpot> _toFlSpot(List<int> nums) {
    List<FlSpot> spots = [];
    for (var i = 0; i < nums.length; i++) {
      spots.add(FlSpot(i.toDouble(), nums[i].toDouble()));
    }
    return spots;
  }

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print("111 len: ${tempsMax.length}");
    }
    return LayoutBuilder(builder: (ctx, cons) {
      final double horInterval = (cons.maxWidth) / (maxX - minX);
      final double verInterval =
          (cons.maxHeight - (itemMaxSize ?? 44) - (itemMinSize ?? 44)) /
              (maxY - minY);
      if (kDebugMode) {
        print("verInterval: $verInterval");
        print("horInterval: $horInterval");
      }
      int count = 0;
      return Stack(
        children: <Widget>[
              LineChart(sampleData),
            ] +
            (tempsMin ?? []).map((e) {
              count++;
              final w = widget.getDotDataWidget(e.y);
              final top = (maxY - e.y) * verInterval + (itemMaxSize ?? 44) - 10;
              // final bottom = (e.y - minY) * verInterval + (itemMinSize ?? 0);
              final left = 15 + (e.x) * horInterval - 2;
              final right = 2 + (maxX - e.x) * horInterval;
              if (kDebugMode) {
                // print("bottom: $bottom}");
                print("top: $top");
                print("left: $left");
              }
              return (count <= tempsMax.length / 2)
                  ? Positioned(
                      left: left,
                      top: top,
                      // bottom: bottom,
                      child: w,
                    )
                  : Positioned(
                      // left: left,
                      right: right,
                      top: top,
                      // bottom: bottom,
                      child: w,
                    );
            }).toList() +
            (tempsMax).map((e) {
              if (count >= tempsMax.length) count = 0;
              count++;
              final w = widget.getDotDataWidget(e.y);
              final top = (maxY - e.y) * verInterval + (itemMaxSize ?? 44) - 10;
              // final bottom = (e.y - minY) * verInterval + (itemMinSize ?? 0);
              final left = 15 + (e.x) * horInterval - 2;
              final right = 2 + (maxX - e.x) * horInterval;
              if (kDebugMode) {
                // print("bottom: $bottom}");
                print("top: $top");
                print("left: $left");
              }
              return (count <= tempsMax.length / 2)
                  ? Positioned(
                      left: left,
                      top: top,
                      // bottom: bottom,
                      child: w,
                    )
                  : Positioned(
                      // left: left,
                      right: right,
                      top: top,
                      // bottom: bottom,
                      child: w,
                    );
            }).toList(),
      );
    });
  }

  LineChartData get sampleData => LineChartData(
      borderData: FlBorderData(show: false),
      titlesData: titlesData,
      lineBarsData: tempsMin != null
          ? [lineChartBarDataMax, lineChartBarDataMin]
          : [lineChartBarDataMax],
      lineTouchData: LineTouchData(
        handleBuiltInTouches: true,
        touchTooltipData: LineTouchTooltipData(
          getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
            return touchedBarSpots.map((barSpot) {
              return LineTooltipItem(
                '${barSpot.y}',
                const TextStyle(color: Colors.white),
              );
            }).toList();
          },
        ),
      ),
      gridData: const FlGridData(
        drawVerticalLine: true,
        drawHorizontalLine: true,
        show: true,
      ),
      minY: minY,
      maxY: maxY,
      maxX: maxX,
      minX: minX);
  FlTitlesData get titlesData => FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
              showTitles: itemMin != null,
              interval: 1,
              reservedSize: itemMinSize ?? 22,
              getTitlesWidget: (v, meta) {
                if (v == maxX) {
                  return const SizedBox(
                    height: 0,
                  );
                }
                return Center(
                  child: itemMin?[v.floor()],
                );
              }),
        ),
        rightTitles:
            const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        leftTitles: AxisTitles(
            sideTitles: SideTitles(
          showTitles: true,
          getTitlesWidget: (value, meta) => Text(
              (tempsMin ?? [] + tempsMax).contains(value.toInt())
                  ? value.toInt().toString()
                  : ""),
        )),
        topTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            reservedSize: itemMaxSize ?? 22,
            getTitlesWidget: (v, meta) {
              if (v == maxX) {
                return const SizedBox(
                  height: 0,
                );
              }
              return Center(
                child: itemMax?[v.floor()],
              );
            },
          ),
        ),
      );
  LineChartBarData get lineChartBarDataMax => LineChartBarData(
      spots: tempsMax,
      isCurved: true,
      barWidth: 3,
      color: colorMax,
      shadow: const Shadow(blurRadius: 8),
      dotData: const FlDotData(show: true),
      belowBarData: BarAreaData(
          show: true,
          gradient: LinearGradient(
              colors: const [Colors.white, Colors.blue]
                  .map((e) => e.withOpacity(0.3))
                  .toList())));

  LineChartBarData get lineChartBarDataMin => LineChartBarData(
        spots: tempsMin ?? [],
        isCurved: true,
        color: colorMin,
        barWidth: 3,
        shadow: const Shadow(blurRadius: 8),
        dotData: const FlDotData(show: true),
      );
}
