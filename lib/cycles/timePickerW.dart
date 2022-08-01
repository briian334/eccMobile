import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'cycles_widget.dart';

class TimePick extends StatefulWidget {
  TimePick({Key? key}) : super(key: key);

  @override
  State<TimePick> createState() => _TimePickState();
}

class _TimePickState extends State<TimePick> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        selectTime = await showTimePicker(
            helpText: "Selecciona la hora",
            confirmText: "ACEPTAR",
            cancelText: "CANCELAR",
            hourLabelText: "Hora",
            minuteLabelText: "Minuto",
            initialEntryMode: TimePickerEntryMode.input,
            context: context,
            initialTime: TimeOfDay.now());

        if (selectTime != null) {
          setState(() {
            currentTime = selectTime;
          });
        }
      },
      icon: const Icon(Icons.more_time),
    );
  }
}
