// ignore_for_file: avoid_print

import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:prueba_firebase/index.dart';
import 'package:workmanager/workmanager.dart';

import '../home_page/home_page_widget.dart';
import 'cycles_widget.dart';
import 'timePickerW.dart';

ScrollController? scrollController;
String? motor;
String? bomba;

final db = FirebaseFirestore.instance;

class Modal extends StatefulWidget {
  Modal({Key? key}) : super(key: key);

  @override
  State<Modal> createState() => _ModalState();
}

class _ModalState extends State<Modal> {
  @override
  Widget build(BuildContext context) {
    return Material(
        child: Container(
      child: ListView(
        controller: scrollController,
        padding: EdgeInsets.all(50),
        children: [
          Container(
            height: 45,
            width: 50,
            decoration: BoxDecoration(
                color: Colors.blue, borderRadius: BorderRadius.circular(20)),
            child: const Text(
              "Motor",
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  height: 1.8,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          CheckboxListTile(
            secondary: Icon(Icons.wind_power_rounded),
            value: valueAlta,
            title: const Text("Velocidad alta"),
            subtitle: const Text("V. alta"),
            onChanged: (value) {
              setState(() {
                valueAlta = value!;
                if (valueAlta == true) {
                  motor = "valueAlta";
                  valueBaja = false;
                  valueAuto = false;
                  valueOff = false;
                } else {
                  motor = null;
                }
              });
            },
          ),
          CheckboxListTile(
            secondary: Icon(Icons.wind_power_outlined),
            value: valueBaja,
            title: const Text("Velocidad baja"),
            subtitle: const Text("V. baja"),
            onChanged: (value) {
              setState(() {
                valueBaja = value!;
                if (valueBaja == true) {
                  motor = "valueBaja";
                  valueAlta = false;
                  valueAuto = false;
                  valueOff = false;
                } else {
                  motor = null;
                }
              });
            },
          ),
          CheckboxListTile(
            secondary: Icon(Icons.power_off),
            value: valueOff,
            title: const Text("Motor apagado"),
            subtitle: const Text("M. off"),
            onChanged: (value) {
              setState(() {
                valueOff = value!;
                if (valueOff == true) {
                  motor = "valueOff";
                  valueBaja = false;
                  valueAuto = false;
                  valueAlta = false;
                  valueBOn = false;
                  valueBOff = true;
                } else {
                  motor = null;
                }
              });
            },
          ),
          CheckboxListTile(
            secondary: Icon(Icons.motion_photos_auto),
            value: valueAuto,
            title: const Text("Modo automático"),
            subtitle: const Text("M. auto."),
            onChanged: (value) {
              setState(() {
                valueAuto = value!;
                if (valueAuto == true) {
                  motor = "valueAuto";
                  valueBaja = false;
                  valueAlta = false;
                  valueOff = false;
                  valueBOn = false;
                  valueBOff = false;
                } else {
                  motor = null;
                }
              });
            },
          ),
          Container(
            height: 45,
            width: 50,
            decoration: BoxDecoration(
                color: Colors.blue, borderRadius: BorderRadius.circular(20)),
            child: const Text(
              "Bomba",
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  height: 1.8,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          CheckboxListTile(
            secondary: Icon(Icons.power_outlined),
            value: valueBOn,
            title: const Text("Bomba activada"),
            subtitle: const Text("B. on"),
            onChanged: (value) {
              setState(() {
                valueBOn = value!;
                valueOff = false;
                valueAuto = false;
                if (valueBOn == true) {
                  valueBOff = false;
                  if (valueAlta == true ||
                      valueBaja == true ||
                      valueAuto == true) {
                  } else {
                    valueBaja = true;
                  }
                }
              });
            },
          ),
          CheckboxListTile(
            secondary: Icon(Icons.power_off),
            value: valueBOff,
            title: const Text("Bomba apagada"),
            subtitle: const Text("B. off"),
            onChanged: (value) {
              setState(() {
                valueBOff = value!;
                if (valueBOff == true) {
                  valueAuto = false;
                  valueBOn = false;
                }
              });
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () async {
                  await showDialog(
                      useSafeArea: true,
                      barrierDismissible: false,
                      context: context,
                      builder: (context) => AlertDialog(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            title: const Text("¿Seguro que deseas salir?"),
                            content: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  ElevatedButton(
                                      style: ButtonStyle(
                                        shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15))),
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Colors.green),
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          selectTime = null;
                                          currentTime = null;
                                          valueAlta = false;
                                          valueBaja = false;
                                          valueOff = false;
                                          valueAuto = false;
                                          valueBOff = false;
                                          valueBOn = false;
                                          valueBAuto = false;
                                        });

                                        //Navigator.pop(context);
                                        Navigator.pop(context);
                                        Navigator.pop(context);
                                      },
                                      child: const Text("Sí")),
                                  ElevatedButton(
                                      style: ButtonStyle(
                                        shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15))),
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Colors.red),
                                      ),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text("No"))
                                ]),
                          ));
                },
                icon: const Icon(Icons.cancel, color: Colors.redAccent),
              ),
              TimePick(),
              IconButton(
                onPressed: () async {
                  //VALIDACIÓN PARA MOTOR
                  if (valueAlta == true) {
                    motor = "ALTA";
                    if (valueBOn == true) {
                      bomba = "ON";
                      if (selectTime != null) {
                        final dato = <String, dynamic>{
                          "Motor": motor,
                          "Bomba": bomba,
                          "Hora": selectTime!,
                          "Estado": false,
                          "hourSelect": selectTime!.hour,
                          "minuteSelect": selectTime!.minute
                        };
                        db.collection("Cycles").add(dato);

                        setState(() {
                          Navigator.pop(context);
                          selectTime = null;
                          currentTime = null;
                          valueAlta = false;
                          valueBaja = false;
                          valueOff = false;
                          valueAuto = false;
                          valueBOff = false;
                          valueBOn = false;
                          valueBAuto = false;
                          motor = null;
                        });
                      } else {
                        await showDialog(
                            useSafeArea: true,
                            barrierDismissible: false,
                            context: context,
                            builder: (context) => AlertDialog(
                                  backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15)),
                                  title: const Text(
                                    "Por favor selecciona una hora correcta",
                                    textAlign: TextAlign.center,
                                  ),
                                  content: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        ElevatedButton(
                                            style: ButtonStyle(
                                              shape: MaterialStateProperty.all<
                                                      RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15))),
                                              backgroundColor:
                                                  MaterialStateProperty.all<
                                                          Color>(
                                                      Color.fromARGB(
                                                          255, 76, 127, 175)),
                                            ),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text("Ok")),
                                      ]),
                                ));
                      }
                    } else {
                      if (valueBOff == true) {
                        bomba = "OFF";
                        if (selectTime != null) {
                          final dato = <String, dynamic>{
                            "Motor": motor,
                            "Bomba": bomba,
                            "Hora": selectTime!.format(context),
                            "Estado": false,
                            "hourSelect": selectTime!.hour,
                            "minuteSelect": selectTime!.minute
                          };
                          db.collection("Cycles").add(dato);
                          setState(() {
                            Navigator.pop(context);
                            selectTime = null;
                            currentTime = null;
                            valueAlta = false;
                            valueBaja = false;
                            valueOff = false;
                            valueAuto = false;
                            valueBOff = false;
                            valueBOn = false;
                            valueBAuto = false;
                            motor = null;
                          });
                        } else {
                          await showDialog(
                              useSafeArea: true,
                              barrierDismissible: false,
                              context: context,
                              builder: (context) => AlertDialog(
                                    backgroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    title: const Text(
                                      "Por favor selecciona una hora correcta",
                                      textAlign: TextAlign.center,
                                    ),
                                    content: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          ElevatedButton(
                                              style: ButtonStyle(
                                                shape: MaterialStateProperty.all<
                                                        RoundedRectangleBorder>(
                                                    RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15))),
                                                backgroundColor:
                                                    MaterialStateProperty.all<
                                                            Color>(
                                                        Color.fromARGB(
                                                            255, 76, 127, 175)),
                                              ),
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Text("Ok")),
                                        ]),
                                  ));
                        }
                      } else {
                        await showDialog(
                            useSafeArea: true,
                            barrierDismissible: false,
                            context: context,
                            builder: (context) => AlertDialog(
                                  backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15)),
                                  title: const Text(
                                    "Por favor selecciona un estado para la bomba de agua",
                                    textAlign: TextAlign.center,
                                  ),
                                  content: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        ElevatedButton(
                                            style: ButtonStyle(
                                              shape: MaterialStateProperty.all<
                                                      RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15))),
                                              backgroundColor:
                                                  MaterialStateProperty.all<
                                                          Color>(
                                                      Color.fromARGB(
                                                          255, 76, 127, 175)),
                                            ),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text("Ok")),
                                      ]),
                                ));
                      }
                    }
                  } else {
                    if (valueBaja == true) {
                      motor = "BAJA";
                      if (valueBOn == true) {
                        bomba = "ON";
                        if (selectTime != null) {
                          final dato = <String, dynamic>{
                            "Motor": motor,
                            "Bomba": bomba,
                            "Hora": selectTime!.format(context),
                            "Estado": false,
                            "hourSelect": selectTime!.hour,
                            "minuteSelect": selectTime!.minute
                          };
                          db.collection("Cycles").add(dato);
                          setState(() {
                            Navigator.pop(context);
                            selectTime = null;
                            currentTime = null;
                            valueAlta = false;
                            valueBaja = false;
                            valueOff = false;
                            valueAuto = false;
                            valueBOff = false;
                            valueBOn = false;
                            valueBAuto = false;
                            motor = null;
                          });
                        } else {
                          await showDialog(
                              useSafeArea: true,
                              barrierDismissible: false,
                              context: context,
                              builder: (context) => AlertDialog(
                                    backgroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    title: const Text(
                                      "Por favor selecciona una hora correcta",
                                      textAlign: TextAlign.center,
                                    ),
                                    content: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          ElevatedButton(
                                              style: ButtonStyle(
                                                shape: MaterialStateProperty.all<
                                                        RoundedRectangleBorder>(
                                                    RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15))),
                                                backgroundColor:
                                                    MaterialStateProperty.all<
                                                            Color>(
                                                        Color.fromARGB(
                                                            255, 76, 127, 175)),
                                              ),
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Text("Ok")),
                                        ]),
                                  ));
                        }
                      } else {
                        if (valueBOff == true) {
                          bomba = "OFF";
                          if (selectTime != null) {
                            final dato = <String, dynamic>{
                              "Motor": motor,
                              "Bomba": bomba,
                              "Hora": selectTime!.format(context),
                              "Estado": false,
                              "hourSelect": selectTime!.hour,
                              "minuteSelect": selectTime!.minute
                            };
                            db.collection("Cycles").add(dato);
                            setState(() {
                              Navigator.pop(context);
                              selectTime = null;
                              currentTime = null;
                              valueAlta = false;
                              valueBaja = false;
                              valueOff = false;
                              valueAuto = false;
                              valueBOff = false;
                              valueBOn = false;
                              valueBAuto = false;
                              motor = null;
                            });
                          } else {
                            await showDialog(
                                useSafeArea: true,
                                barrierDismissible: false,
                                context: context,
                                builder: (context) => AlertDialog(
                                      backgroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      title: const Text(
                                        "Por favor selecciona una hora correcta",
                                        textAlign: TextAlign.center,
                                      ),
                                      content: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            ElevatedButton(
                                                style: ButtonStyle(
                                                  shape: MaterialStateProperty
                                                      .all<RoundedRectangleBorder>(
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          15))),
                                                  backgroundColor:
                                                      MaterialStateProperty.all<
                                                              Color>(
                                                          Color.fromARGB(255,
                                                              76, 127, 175)),
                                                ),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: const Text("Ok")),
                                          ]),
                                    ));
                          }
                        } else {
                          await showDialog(
                              useSafeArea: true,
                              barrierDismissible: false,
                              context: context,
                              builder: (context) => AlertDialog(
                                    backgroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    title: const Text(
                                      "Por favor selecciona un estado para la bomba de agua",
                                      textAlign: TextAlign.center,
                                    ),
                                    content: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          ElevatedButton(
                                              style: ButtonStyle(
                                                shape: MaterialStateProperty.all<
                                                        RoundedRectangleBorder>(
                                                    RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15))),
                                                backgroundColor:
                                                    MaterialStateProperty.all<
                                                            Color>(
                                                        Color.fromARGB(
                                                            255, 76, 127, 175)),
                                              ),
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Text("Ok")),
                                        ]),
                                  ));
                        }
                      }
                    } else {
                      if (valueAuto == true) {
                        motor = "AUTO";
                        if (selectTime != null) {
                          final dato = <String, dynamic>{
                            "Motor": motor,
                            "Hora": selectTime!.format(context),
                            "Estado": false,
                            "hourSelect": selectTime!.hour,
                            "minuteSelect": selectTime!.minute
                          };
                          db.collection("Cycles").add(dato);
                          setState(() {
                            Navigator.pop(context);
                            selectTime = null;
                            currentTime = null;
                            valueAlta = false;
                            valueBaja = false;
                            valueOff = false;
                            valueAuto = false;
                            valueBOff = false;
                            valueBOn = false;
                            valueBAuto = false;
                            motor = null;
                          });
                        } else {
                          await showDialog(
                              useSafeArea: true,
                              barrierDismissible: false,
                              context: context,
                              builder: (context) => AlertDialog(
                                    backgroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    title: const Text(
                                      "Por favor selecciona una hora correcta",
                                      textAlign: TextAlign.center,
                                    ),
                                    content: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          ElevatedButton(
                                              style: ButtonStyle(
                                                shape: MaterialStateProperty.all<
                                                        RoundedRectangleBorder>(
                                                    RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15))),
                                                backgroundColor:
                                                    MaterialStateProperty.all<
                                                            Color>(
                                                        Color.fromARGB(
                                                            255, 76, 127, 175)),
                                              ),
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Text("Ok")),
                                        ]),
                                  ));
                        }
                      } else {
                        if (valueOff == true) {
                          motor = 'APAGADO';
                          if (valueBOff == true) {
                            bomba = 'OFF';
                            if (selectTime != null) {
                              final dato = <String, dynamic>{
                                "Motor": motor,
                                "Bomba": bomba,
                                "Hora": selectTime!.format(context),
                                "Estado": false,
                                "hourSelect": selectTime!.hour,
                                "minuteSelect": selectTime!.minute
                              };
                              db.collection("Cycles").add(dato);
                              setState(() {
                                Navigator.pop(context);
                                selectTime = null;
                                currentTime = null;
                                valueAlta = false;
                                valueBaja = false;
                                valueOff = false;
                                valueAuto = false;
                                valueBOff = false;
                                valueBOn = false;
                                valueBAuto = false;
                                motor = null;
                              });
                            } else {
                              await showDialog(
                                  useSafeArea: true,
                                  barrierDismissible: false,
                                  context: context,
                                  builder: (context) => AlertDialog(
                                        backgroundColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        title: const Text(
                                          "Por favor selecciona una hora correcta",
                                          textAlign: TextAlign.center,
                                        ),
                                        content: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              ElevatedButton(
                                                  style: ButtonStyle(
                                                    shape: MaterialStateProperty.all<
                                                            RoundedRectangleBorder>(
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15))),
                                                    backgroundColor:
                                                        MaterialStateProperty
                                                            .all<Color>(
                                                                Color.fromARGB(
                                                                    255,
                                                                    76,
                                                                    127,
                                                                    175)),
                                                  ),
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: const Text("Ok")),
                                            ]),
                                      ));
                            }
                          } else {
                            await showDialog(
                                useSafeArea: true,
                                barrierDismissible: false,
                                context: context,
                                builder: (context) => AlertDialog(
                                      backgroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      title: const Text(
                                        "¡Cuida tu bomba de agua! Selecciona una velocidad para evitar dañarla",
                                        textAlign: TextAlign.center,
                                      ),
                                      content: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            ElevatedButton(
                                                style: ButtonStyle(
                                                  shape: MaterialStateProperty
                                                      .all<RoundedRectangleBorder>(
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          15))),
                                                  backgroundColor:
                                                      MaterialStateProperty.all<
                                                              Color>(
                                                          Color.fromARGB(255,
                                                              76, 127, 175)),
                                                ),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: const Text("Ok")),
                                          ]),
                                    ));
                          }
                        } else {
                          await showDialog(
                              useSafeArea: true,
                              barrierDismissible: false,
                              context: context,
                              builder: (context) => AlertDialog(
                                    backgroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    title: const Text(
                                      "Por favor selecciona una velocidad para el motor",
                                      textAlign: TextAlign.center,
                                    ),
                                    content: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          ElevatedButton(
                                              style: ButtonStyle(
                                                shape: MaterialStateProperty.all<
                                                        RoundedRectangleBorder>(
                                                    RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15))),
                                                backgroundColor:
                                                    MaterialStateProperty.all<
                                                            Color>(
                                                        Color.fromARGB(
                                                            255, 76, 127, 175)),
                                              ),
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Text("Ok")),
                                        ]),
                                  ));
                        }
                      }
                    }
                  }
                  //VALIDACIÓN PARA BOMBA
                },
                icon: const Icon(
                  Icons.save_as_rounded,
                  color: Colors.green,
                ),
              )
            ],
          )
        ],
      ),
    ));
  }
}
