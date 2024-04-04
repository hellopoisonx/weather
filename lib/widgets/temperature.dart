import 'package:flutter/material.dart';
import 'package:weather/components/qw_icons.dart';

enum TemperatureUnit { centigrade, fahrenheit }

class Temperature extends StatelessWidget {
  final String temp;
  final TextStyle? style;
  final TemperatureUnit unit;
  final Color? unitColor;
  final double? unitSize;

  const Temperature(this.temp,
      {super.key,
      this.style,
      this.unit = TemperatureUnit.centigrade,
      this.unitColor,
      this.unitSize});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Text(
        temp,
        style: style,
      ),
      Icon(
        unit == TemperatureUnit.centigrade
            ? QwIcons.centigrade
            : QwIcons.fahrenheit,
        size: unitSize ?? style?.fontSize,
        color: unitColor ?? style?.color,
      ),
    ]);
  }
}
