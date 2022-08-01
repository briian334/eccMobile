import 'package:flutter/material.dart';

class WaitingDisplay extends StatefulWidget {
  WaitingDisplay({Key? key}) : super(key: key);

  @override
  State<WaitingDisplay> createState() => _WaitingDisplayState();
}

class _WaitingDisplayState extends State<WaitingDisplay> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Expanded(child: Image.asset('assets/images/logo.png')),
          //LinearProgressIndicator(),
        ]),
      )),
    );
  }
}
