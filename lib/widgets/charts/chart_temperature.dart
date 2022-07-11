import 'package:flutter/material.dart';
import 'package:project_ecc/run.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

// ignore: camel_case_types
class chart_temperature extends StatefulWidget {
  const chart_temperature({Key? key}) : super(key: key);

  @override
  State<chart_temperature> createState() => _chart_temperatureState();
}

// ignore: camel_case_types
class _chart_temperatureState extends State<chart_temperature> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: SfRadialGauge(axes: <RadialAxis>[
        RadialAxis(
          startAngle: 85,
          endAngle: 275,
          interval: 10,
          ranges: <GaugeRange>[
            GaugeRange(
                color: const Color.fromARGB(255, 0, 60, 255),
                startValue: 0,
                endValue: 15),
            GaugeRange(
                color: const Color.fromARGB(255, 86, 145, 255),
                startValue: 15,
                endValue: 30),
            GaugeRange(
                color: const Color.fromARGB(255, 247, 159, 44),
                startValue: 30,
                endValue: 50)
          ],
          canScaleToFit: true,
          pointers: <GaugePointer>[
            NeedlePointer(
              enableDragging: true,
              needleLength: 0.60,
              enableAnimation: true,
              animationDuration: 2000,
              value: double.parse(prueba[2]),
            )
          ],
          minimum: 0,
          maximum: 50,
          //showLabels: true,
          showTicks: true,
        )
      ]),
    );
  }
}
