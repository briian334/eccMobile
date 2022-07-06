// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:project_ecc/widgets/botons/BtnMode.dart';
import 'package:project_ecc/widgets/botons/BtnPump.dart';
import 'package:project_ecc/widgets/bottom_navigation.dart';
import 'package:project_ecc/widgets/charts/chart_temperature.dart';
import 'package:project_ecc/widgets/charts/chart_humidity.dart';

var prueba = [];
var k = 1;
final ref = FirebaseDatabase.instance.ref();

class Run extends StatefulWidget {
  const Run({Key? key}) : super(key: key);

  @override
  State<Run> createState() => _RunState();
}

class _RunState extends State<Run> {
  StreamSubscription? _dataStream;
  String _displayData = "";
  @override
  void initState() {
    super.initState();
    _activaEco();
  }

  var documento = "";
  void _activaEco() {
    ref.onValue.listen((event) {
      final String data = event.snapshot.value.toString(); //JSON COMPLETO
      setState(() {
        _displayData = data;
        documento = _displayData.replaceAll(
            RegExp("{|}|Motor: |Humedad: |Temperatura: |Bomba: "),
            ""); //Separando el JSON (decodificando)
        documento.trim(); //Recortando espacios en blanco
      });
      if (prueba.isEmpty) {
        Future.delayed(const Duration(seconds: 5), () {
          setState(() {
            prueba.addAll(documento
                .split(',')); //Agregando los datos del Json en una lista
          });
        });
      } else {
        prueba.clear(); //Borramos los datos anteriores
        prueba.addAll(documento.split(',')); //traemos los nuevos datos
      }
    });
  } //end activaEco()

  @override
  Widget build(BuildContext context) {
    if (prueba.isEmpty) {
      return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text("Cargando, por favor espere...",
                  style: TextStyle(fontSize: 25)),
              SizedBox(
                height: 50,
              ),
              SizedBox(
                height: 100,
                width: 100,
                child: CircularProgressIndicator(
                  strokeWidth: 12,
                  backgroundColor: Color.fromARGB(255, 223, 220, 220),
                  color: Color.fromARGB(255, 206, 40, 28),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("PROJECT ECC")),
      ),
      body: ListView(
        padding: EdgeInsets.fromLTRB(2, 30, 2, 2),
        children: <Widget>[
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [BtnMode(), BtnPump()],
              )
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            // ignore: prefer_const_literals_to_create_immutables
            children: <Widget>[
              Flexible(flex: 2, child: chart_humidity()),
              Flexible(flex: 2, child: chart_temperature())
            ],
          ),
          Card(
            child: Image.asset('assets/images/evaporador.gif'),
          )
        ],
      ),
      bottomNavigationBar: const bottom_navigation(),
    );
  }

  @override
  void deactivate() {
    _dataStream!.cancel();
    super.deactivate();
  }
}

/* child: ListView(
          children: <Widget>[
            Column(
              //mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [progressbar_pump()],
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [chart_temperature()],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [chart_humidity()],
                    ),
                  ),
                ]),
          ],
          //end ListView
        ), */
