import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:project_ecc/run.dart';

Color colorP = const Color.fromARGB(255, 0, 0, 0);
var k = 1;

class BtnPump extends StatefulWidget {
  const BtnPump({Key? key}) : super(key: key);

  @override
  State<BtnPump> createState() => _BtnPumpState();
}

class _BtnPumpState extends State<BtnPump> {
  @override
  Widget build(BuildContext context) {
    if (prueba[3] == "OFF") {
      colorP = const Color.fromARGB(255, 204, 3, 3);
    } else if (prueba[3] == "ON") {
      colorP = const Color.fromARGB(255, 57, 177, 2);
    }
    return ElevatedButton.icon(
        onPressed: () async {
          if (k == 1) {
            setState(() {
              colorP = const Color.fromARGB(255, 204, 3, 3);
            });
            await ref.update({"Bomba": "OFF"});
            k += 1;
          } else if (k == 2) {
            setState(() {
              colorP = const Color.fromARGB(255, 57, 177, 2);
            });
            await ref.update({"Bomba": "ON"});
            k = 1;
          }
        },
        style: styleBtn2(colorP),
        icon: const Icon(Ionicons.rainy_sharp),
        label: Text(prueba[3]));
  }

  styleBtn2(Color colorP) {
    return ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(colorP),
    );
  }
}
