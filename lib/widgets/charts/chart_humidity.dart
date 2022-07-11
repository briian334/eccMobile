import 'package:flutter/material.dart';
import 'package:project_ecc/run.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'dart:async';

// ignore: camel_case_types
class chart_humidity extends StatefulWidget {
  const chart_humidity({Key? key}) : super(key: key);

  @override
  State<chart_humidity> createState() => _chart_humidityState();
}

// ignore: camel_case_types
class _chart_humidityState extends State<chart_humidity> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: SfRadialGauge(axes: <RadialAxis>[
        RadialAxis(
          startAngle: 275,
          endAngle: 85,
          interval: 20,
          ranges: <GaugeRange>[
            GaugeRange(
                color: const Color.fromARGB(255, 36, 192, 15),
                startValue: 0,
                endValue: 40),
            GaugeRange(
                color: Color.fromARGB(255, 255, 218, 6),
                startValue: 40,
                endValue: 80),
            GaugeRange(color: Colors.red, startValue: 80, endValue: 100)
          ],
          pointers: <GaugePointer>[
            NeedlePointer(
              enableDragging: true,
              needleLength: 0.60,
              enableAnimation: true,
              animationDuration: 2000,
              value: double.parse(prueba[1]),
            )
          ],
          isInversed: true,
          canScaleToFit: true,
          minimum: 0,
          maximum: 100,
          showTicks: false,
        )
      ]),
    );
  }
}
