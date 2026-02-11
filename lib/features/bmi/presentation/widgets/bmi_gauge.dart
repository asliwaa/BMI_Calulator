import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import '../../domain/entities/bmi.dart';

class BmiGauge extends StatelessWidget {
  final Bmi bmiResult;

  const BmiGauge({Key? key, required this.bmiResult}) : super(key: key);

  @override Widget build(BuildContext context) {
    return SfRadialGauge(
      axes: <RadialAxis>[
        RadialAxis(
          minimum: 10,
          maximum: 40,
          ranges: <GaugeRange> [
            GaugeRange(startValue: 10, endValue: 18.5, color: Colors.blue, label: "Underweight"),
            GaugeRange(startValue: 18.5, endValue: 25, color: Colors.green, label: "Normal"),
            GaugeRange(startValue: 25, endValue: 30, color: Colors.orange, label: "Overweight"),
            GaugeRange(startValue: 30, endValue: 40, color: Colors.red, label: "Obesity"),
          ],
          pointers: <GaugePointer>[
            NeedlePointer(value: bmiResult.bmiValue),
          ],
          annotations: <GaugeAnnotation>[
            GaugeAnnotation(
              widget: Column (
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text (
                    bmiResult.bmiValue.toStringAsFixed(1),
                    style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  Text (
                    bmiResult.category.toString().split('.').last.toUpperCase(),
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
              angle: 90,
              positionFactor: 0.5,
              ),
          ],
        )
      ]
    );
  }
}