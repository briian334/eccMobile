import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:project_ecc/run.dart';

Color color = const Color.fromARGB(255, 0, 0, 0);

class BtnMode extends StatefulWidget {
  const BtnMode({Key? key}) : super(key: key);

  @override
  State<BtnMode> createState() => _BtnModeState();
}

class _BtnModeState extends State<BtnMode> {
  @override
  Widget build(BuildContext context) {
    if (prueba[0] == "APAGADO") {
      color = const Color.fromARGB(255, 204, 3, 3);
    } else if (prueba[0] == "ALTA") {
      color = const Color.fromARGB(255, 57, 177, 2);
    } else if (prueba[0] == "BAJA") {
      color = const Color.fromARGB(255, 3, 164, 204);
    } else if (prueba[0] == "AUTO") {
      color = const Color.fromARGB(255, 130, 3, 204);
    }
    return ElevatedButton.icon(
        onPressed: () async {
          if (k == 1) {
            setState(() {
              color = const Color.fromARGB(255, 204, 3, 3);
            });
            await ref.update({"Motor": "APAGADO"});
            k += 1;
          } else if (k == 2) {
            setState(() {
              color = const Color.fromARGB(255, 57, 177, 2);
            });
            await ref.update({"Motor": "ALTA"});
            k += 1;
          } else if (k == 3) {
            setState(() {
              color = const Color.fromARGB(255, 3, 164, 204);
            });
            await ref.update({"Motor": "BAJA"});
            k += 1;
          } else if (k == 4) {
            setState(() {
              color = const Color.fromARGB(255, 130, 3, 204);
            });
            await ref.update({"Motor": "AUTO"});
            k = 1;
          }
        },
        style: styleBtn(color),
        icon: const Icon(Ionicons.power_outline),
        label: Text(prueba[0]));
  }

  styleBtn(Color color) {
    return ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(color),
    );
  }
}
