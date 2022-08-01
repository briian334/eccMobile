import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'cycles/showModal.dart';
import 'firebase_options.dart';
import 'flutter_flow/flutter_flow_theme.dart';
import 'home_page/app.dart';
import 'package:workmanager/workmanager.dart';

import 'home_page/home_page_widget.dart';

//FUNCIÓN CALLBACK PARA CICLOS
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    if (inputData!['Motor'] != 'AUTO') {
      infoBD.update({"Motor": inputData['Motor']});
      infoBD.update({"Bomba": inputData['Bomba']});
      db.collection('Cycles').doc('${inputData['id']}').delete();
    } else {
      infoBD.update({"Motor": inputData['Motor']});
      db.collection('Cycles').doc('${inputData['id']}').delete();
    }

    return Future.value(true);
  });
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterFlowTheme.initialize();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Workmanager().initialize(callbackDispatcher);
  runApp(MyApp());
}
