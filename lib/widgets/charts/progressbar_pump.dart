import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'config.dart';

class progressbar_pump extends StatefulWidget {
  const progressbar_pump({Key? key}) : super(key: key);

  @override
  State<progressbar_pump> createState() => _progressbar_pumpState();
}

class _progressbar_pumpState extends State<progressbar_pump> {
  @override
  Widget build(BuildContext context) {
    final Size displaySize = MediaQuery.of(context).size;
    final Orientation displayOrientation = MediaQuery.of(context).orientation;

    return SizedBox(
      height: displaySize.height - 415,
      child: LinearPercentIndicator(
        width: MediaQuery.of(context).size.width - 150,
        lineHeight: 30.0,
        percent: 0.8,
        backgroundColor: Color.fromARGB(176, 91, 187, 134),
        progressColor: Color.fromARGB(255, 29, 177, 0),
      ),
    );
  }
}
