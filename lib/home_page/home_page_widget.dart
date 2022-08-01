import 'dart:async';
import 'dart:math';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/services.dart';
import 'package:ionicons/ionicons.dart';
import 'package:workmanager/workmanager.dart';

import '../cycles/cycles_widget.dart';
import '../cycles/showModal.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'waitingDisplay.dart';

//FIREBASE COMPONENTES
int _randomNum = Random().nextInt(999);
DatabaseReference ciclosRef =
    FirebaseDatabase.instance.ref("cycles/$_randomNum");
DatabaseReference infoBD = FirebaseDatabase.instance.ref();
//JSONS PARA LEER DATOS DE LA BD *MOTOR = [0], HUMEDAD [1], TEMP [2], BOMBA [3]
var cyclesDB = []; //Lista dónde se almacenan los ciclos programados
var dataDB = []; //lista dónde se almacena motor,bomba,temp y humedad.
var k = 1;
//SELECTORES MOTOR
bool? selectAlta;
bool? selectBaja;
bool? selectOff;
bool? selectAuto;
//SELECTORES BOMBA
bool? selectBOn;
bool? selectBOff;
//BD ESTADOS MOTOR
bool motorAlta() {
  if (dataDB[0] == "ALTA") {
    return true;
  }
  return false;
}

bool motorBaja() {
  if (dataDB[0] == "BAJA") {
    return true;
  }
  return false;
}

bool motorOff() {
  if (dataDB[0] == "APAGADO") {
    return true;
  }
  return false;
}

bool motorAuto() {
  if (dataDB[0] == "AUTO") {
    return true;
  }
  return false;
}

//BD BOMBA ESTADOS
bool bombaOn() {
  if (motorAuto()) {
    return false;
  } else {
    if (dataDB[3] == " ON") {
      return true;
    }
    return false;
  }
}

bool bombaOff() {
  if (motorAuto()) {
    return false;
  } else {
    if (dataDB[3] == " OFF") {
      return true;
    }
    return false;
  }
}

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({Key? key}) : super(key: key);

  @override
  _HomePageWidgetState createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  StreamSubscription? _dataStream;
  String _displayData = "";

  PageController? pageViewController;
  bool? switchListTileValue1;
  bool? switchListTileValue2;
  bool? switchListTileValue3;
  bool? switchListTileValue4;
  bool? switchListTileValue5;
  bool? switchListTileValue6;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  var documento = "";
  void _activaEco() {
    infoBD.onValue.listen((event) {
      final String data = event.snapshot.value.toString(); //JSON COMPLETO
      setState(() {
        _displayData = data;
        documento = _displayData.replaceAll(
            RegExp("{|}|Motor: |Humedad: |Temperatura: |Bomba: |NivelAgua: "),
            ""); //Separando el JSON (decodificando)
        documento.trim(); //Recortando espacios en blanco
      });
      if (dataDB.isEmpty) {
        Future.delayed(const Duration(seconds: 3), () {
          setState(() {
            dataDB.addAll(documento
                .split(',')); //Agregando los datos del Json en una lista
          });
        });
      } else {
        dataDB.clear(); //Borramos los datos anteriores
        dataDB.addAll(documento.split(',')); //traemos los nuevos datos
      }
    });
  } //end activaEco()

  @override
  void initState() {
    super.initState();
    _activaEco();
  }

  @override
  Widget build(BuildContext context) {
    return dataDB.isEmpty
        ? WaitingDisplay()
        : Scaffold(
            key: scaffoldKey,
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            body: SafeArea(
              child: GestureDetector(
                onTap: () => FocusScope.of(context).unfocus(),
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF8766D9), Color(0xAB0062FF)],
                      stops: [0, 1],
                      begin: AlignmentDirectional(0, -1),
                      end: AlignmentDirectional(0, 1),
                    ),
                    shape: BoxShape.rectangle,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(),
                          child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                            child: Container(
                              width: double.infinity,
                              height: double.infinity,
                              child: Stack(
                                children: [
                                  PageView(
                                    controller: pageViewController ??=
                                        PageController(initialPage: 0),
                                    scrollDirection: Axis.horizontal,
                                    children: [
                                      Align(
                                        alignment:
                                            AlignmentDirectional(-0.74, -0.91),
                                        child: Container(
                                          width: double.infinity,
                                          height: double.infinity,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryBtnText!,
                                            ),
                                          ),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Expanded(
                                                flex: 1,
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(0, 25, 0, 0),
                                                  child: Text(
                                                    FFLocalizations.of(context)!
                                                        .getText(
                                                      '9tc8w57z' /* Temperatura */,
                                                    ),
                                                    textAlign: TextAlign.center,
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyText1
                                                        .override(
                                                          fontFamily: 'Poppins',
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryBtnText,
                                                          fontSize: 21,
                                                          fontWeight:
                                                              FontWeight.w300,
                                                        ),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: FaIcon(
                                                  FontAwesomeIcons
                                                      .thermometerHalf,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primaryBtnText,
                                                  size: 70,
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Align(
                                                  alignment:
                                                      AlignmentDirectional(
                                                          0, 0),
                                                  child: dataDB.isEmpty
                                                      ? CircularProgressIndicator(
                                                          color: Colors.white,
                                                        )
                                                      : Text(
                                                          "${dataDB[2]}°C",
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .title1
                                                              .override(
                                                                fontFamily:
                                                                    'Poppins',
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryBtnText,
                                                                fontSize: 35,
                                                              ),
                                                        ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment:
                                            AlignmentDirectional(-0.74, -0.91),
                                        child: Container(
                                          width: double.infinity,
                                          height: double.infinity,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryBtnText!,
                                            ),
                                          ),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Expanded(
                                                flex: 1,
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(0, 25, 0, 0),
                                                  child: Text(
                                                    FFLocalizations.of(context)!
                                                        .getText(
                                                      '1pk027xo' /* Temperatura */,
                                                    ),
                                                    textAlign: TextAlign.center,
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyText1
                                                        .override(
                                                          fontFamily: 'Poppins',
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryBtnText,
                                                          fontSize: 23,
                                                          fontWeight:
                                                              FontWeight.w300,
                                                        ),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                  flex: 1,
                                                  child: Icon(
                                                    Icons.cloud,
                                                    color: Colors.white,
                                                    size: 70,
                                                  )),
                                              Expanded(
                                                flex: 1,
                                                child: Align(
                                                  alignment:
                                                      AlignmentDirectional(
                                                          0, 0),
                                                  child: dataDB.isEmpty
                                                      ? CircularProgressIndicator(
                                                          color: Colors.white,
                                                        )
                                                      : Text(
                                                          "${dataDB[1]}%",
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .title1
                                                              .override(
                                                                fontFamily:
                                                                    'Poppins',
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryBtnText,
                                                                fontSize: 35,
                                                              ),
                                                        ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Align(
                                    alignment: AlignmentDirectional(1, 1),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          10, 10, 10, 10),
                                      child: SmoothPageIndicator(
                                        controller: pageViewController ??=
                                            PageController(initialPage: 0),
                                        count: 2,
                                        axisDirection: Axis.horizontal,
                                        onDotClicked: (i) {
                                          pageViewController!.animateToPage(
                                            i,
                                            duration:
                                                Duration(milliseconds: 500),
                                            curve: Curves.ease,
                                          );
                                        },
                                        effect: ExpandingDotsEffect(
                                          expansionFactor: 2,
                                          spacing: 8,
                                          radius: 16,
                                          dotWidth: 16,
                                          dotHeight: 16,
                                          dotColor: Color(0xE1DADADA),
                                          activeDotColor: Colors.white,
                                          paintStyle: PaintingStyle.fill,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      10, 0, 10, 0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  10, 10, 10, 10),
                                          child: Container(
                                            width: double.infinity,
                                            height: 230,
                                            decoration: BoxDecoration(
                                              color: Color(0xFFEEEEEE),
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              shape: BoxShape.rectangle,
                                            ),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0, 0, 10, 0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.stretch,
                                                children: [
                                                  Expanded(
                                                    flex: 1,
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  10, 0, 0, 0),
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: [
                                                          Align(
                                                            alignment:
                                                                AlignmentDirectional(
                                                                    0, 0),
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          5,
                                                                          8,
                                                                          20,
                                                                          10),
                                                              child: Container(
                                                                width: 150,
                                                                height: 50,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  gradient:
                                                                      LinearGradient(
                                                                    colors: [
                                                                      Color(
                                                                          0xFF8766D9),
                                                                      Color(
                                                                          0xAB0062FF)
                                                                    ],
                                                                    stops: [
                                                                      0,
                                                                      1
                                                                    ],
                                                                    begin:
                                                                        AlignmentDirectional(
                                                                            0,
                                                                            -1),
                                                                    end:
                                                                        AlignmentDirectional(
                                                                            0,
                                                                            1),
                                                                  ),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              30),
                                                                ),
                                                                alignment:
                                                                    AlignmentDirectional(
                                                                        0, 0),
                                                                child: Align(
                                                                  alignment:
                                                                      AlignmentDirectional(
                                                                          0, 0),
                                                                  child:
                                                                      AutoSizeText(
                                                                    FFLocalizations.of(
                                                                            context)!
                                                                        .getText(
                                                                      'hk3y6iyz' /* Motor */,
                                                                    ),
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .title1
                                                                        .override(
                                                                          fontFamily:
                                                                              'Poppins',
                                                                          color:
                                                                              FlutterFlowTheme.of(context).primaryBtnText,
                                                                          fontSize:
                                                                              23,
                                                                        ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Expanded(
                                                              flex: 1,
                                                              child: Padding(
                                                                  padding: EdgeInsets
                                                                      .fromLTRB(
                                                                          5,
                                                                          10,
                                                                          5,
                                                                          10),
                                                                  child:
                                                                      Tooltip(
                                                                    // verticalOffset: 0,
                                                                    height: 25,
                                                                    message:
                                                                        "Enciende el motor en la velocidad alta",
                                                                    child:
                                                                        ListTile(
                                                                      style: ListTileStyle
                                                                          .list,
                                                                      hoverColor:
                                                                          Colors
                                                                              .red,
                                                                      title: Text(
                                                                          "Alta"),
                                                                      subtitle:
                                                                          Text(
                                                                              "Velocidad"),
                                                                      leading: Icon(
                                                                          Icons
                                                                              .wind_power),
                                                                      selected: selectAlta ==
                                                                              null
                                                                          ? motorAlta()
                                                                          : selectAlta!,
                                                                      onTap:
                                                                          () {
                                                                        setState(
                                                                            () {
                                                                          if (selectAlta == null &&
                                                                              motorAlta() == true) {
                                                                            selectAlta =
                                                                                false;
                                                                            selectOff =
                                                                                true;
                                                                            selectBOff =
                                                                                false;
                                                                            infoBD.update({
                                                                              "Motor": "APAGADO",
                                                                              "Bomba": "OFF"
                                                                            });
                                                                          } else {
                                                                            if (selectAlta == null &&
                                                                                motorAlta() == false) {
                                                                              selectAlta = true;
                                                                              infoBD.update({
                                                                                "Motor": "ALTA",
                                                                              });
                                                                              selectBaja = false;
                                                                              selectOff = false;
                                                                              selectAuto = false;
                                                                            } else {
                                                                              selectAlta == false ? selectAlta = true : selectAlta = false;
                                                                              if (selectAlta == true) {
                                                                                infoBD.update({
                                                                                  "Motor": "ALTA"
                                                                                });
                                                                                selectBaja = false;
                                                                                selectOff = false;
                                                                                selectAuto = false;
                                                                                if (selectBOn != true && selectBOff != true) {
                                                                                  infoBD.update({
                                                                                    "Bomba": "OFF"
                                                                                  });
                                                                                  selectBOff = true;
                                                                                }
                                                                              } else {
                                                                                infoBD.update({
                                                                                  "Motor": "APAGADO",
                                                                                });
                                                                                selectOff = true;
                                                                                infoBD.update({
                                                                                  "Bomba": "OFF"
                                                                                });
                                                                              }
                                                                            }
                                                                          }
                                                                        });
                                                                      },
                                                                    ),
                                                                  ))),
                                                          Expanded(
                                                              flex: 1,
                                                              child: Padding(
                                                                  padding: EdgeInsets
                                                                      .fromLTRB(
                                                                          5,
                                                                          10,
                                                                          5,
                                                                          10),
                                                                  child:
                                                                      Tooltip(
                                                                    // verticalOffset:  -80,
                                                                    height: 25,
                                                                    message:
                                                                        "Enciende el motor en la velocidad baja",
                                                                    child:
                                                                        ListTile(
                                                                      style: ListTileStyle
                                                                          .list,
                                                                      hoverColor:
                                                                          Colors
                                                                              .red,
                                                                      title: Text(
                                                                          "Baja"),
                                                                      subtitle:
                                                                          Text(
                                                                              "Velocidad"),
                                                                      leading: Icon(
                                                                          Icons
                                                                              .wind_power_outlined),
                                                                      selected: selectBaja ==
                                                                              null
                                                                          ? motorBaja()
                                                                          : selectBaja!,
                                                                      onTap:
                                                                          () {
                                                                        setState(
                                                                            () {
                                                                          if (selectBaja == null &&
                                                                              motorBaja() == true) {
                                                                            selectBaja =
                                                                                false;
                                                                            selectBOff =
                                                                                false;
                                                                            selectOff =
                                                                                true;
                                                                            infoBD.update({
                                                                              "Motor": "APAGADO",
                                                                              "Bomba": "OFF"
                                                                            });
                                                                          } else {
                                                                            if (selectBaja == null &&
                                                                                motorBaja() == false) {
                                                                              selectBaja = true;
                                                                              selectOff = false;
                                                                              selectAuto = false;
                                                                              infoBD.update({
                                                                                "Motor": "BAJA",
                                                                              });
                                                                            } else {
                                                                              selectBaja == false ? selectBaja = true : selectBaja = false;
                                                                              if (selectBaja == true) {
                                                                                infoBD.update({
                                                                                  "Motor": "BAJA"
                                                                                });
                                                                                selectAlta = false;
                                                                                selectOff = false;
                                                                                selectAuto = false;
                                                                                if (selectBOn != true && selectBOff != true) {
                                                                                  infoBD.update({
                                                                                    "Bomba": "OFF"
                                                                                  });
                                                                                  selectBOff = true;
                                                                                }
                                                                              } else {
                                                                                infoBD.update({
                                                                                  "Motor": "APAGADO",
                                                                                });
                                                                                infoBD.update({
                                                                                  "Bomba": "OFF"
                                                                                });
                                                                                selectOff = true;
                                                                              }
                                                                            }
                                                                          }
                                                                        });
                                                                      },
                                                                    ),
                                                                  ))),
                                                          Expanded(
                                                              flex: 1,
                                                              child: Padding(
                                                                  padding: EdgeInsets
                                                                      .fromLTRB(
                                                                          5,
                                                                          10,
                                                                          5,
                                                                          10),
                                                                  child:
                                                                      Tooltip(
                                                                    //verticalOffset: -80,
                                                                    height: 25,
                                                                    message:
                                                                        "Apaga el motor y bomba al mismo tiempo",
                                                                    child:
                                                                        ListTile(
                                                                      style: ListTileStyle
                                                                          .list,
                                                                      hoverColor:
                                                                          Colors
                                                                              .red,
                                                                      title: Text(
                                                                          "Apagar"),
                                                                      subtitle:
                                                                          Text(
                                                                              "M. & B."),
                                                                      leading: Icon(
                                                                          Icons
                                                                              .power_settings_new_sharp),
                                                                      selected: selectOff ==
                                                                              null
                                                                          ? motorOff()
                                                                          : selectOff!,
                                                                      onTap:
                                                                          () {
                                                                        setState(
                                                                            () {
                                                                          if (selectOff == null &&
                                                                              motorOff() == true) {
                                                                            selectOff =
                                                                                false;
                                                                            selectBaja =
                                                                                true;
                                                                            infoBD.update({
                                                                              "Motor": "BAJA",
                                                                            });
                                                                          } else {
                                                                            if (selectOff == null &&
                                                                                motorOff() == false) {
                                                                              selectOff = true;
                                                                              selectBOff = true;
                                                                              infoBD.update({
                                                                                "Motor": "APAGADO",
                                                                                "Bomba": "OFF"
                                                                              });
                                                                            } else {
                                                                              selectOff == false ? selectOff = true : selectOff = false;
                                                                              if (selectOff == true) {
                                                                                infoBD.update({
                                                                                  "Motor": "APAGADO",
                                                                                  "Bomba": "OFF"
                                                                                });
                                                                                selectAlta = false;
                                                                                selectBaja = false;
                                                                                selectBOn = false;
                                                                                selectAuto = false;
                                                                                selectBOff = true;
                                                                              } else {
                                                                                infoBD.update({
                                                                                  "Motor": "BAJA",
                                                                                  "Bomba": "OFF"
                                                                                });
                                                                                selectBaja = true;
                                                                                selectBOff = true;
                                                                              }
                                                                            }
                                                                          }
                                                                        });
                                                                      },
                                                                    ),
                                                                  ))),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 1,
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Align(
                                                          alignment:
                                                              AlignmentDirectional(
                                                                  0, 0),
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        5,
                                                                        8,
                                                                        20,
                                                                        10),
                                                            child: Container(
                                                              width: 150,
                                                              height: 50,
                                                              decoration:
                                                                  BoxDecoration(
                                                                gradient:
                                                                    LinearGradient(
                                                                  colors: [
                                                                    Color(
                                                                        0xFF8766D9),
                                                                    Color(
                                                                        0xAB0062FF)
                                                                  ],
                                                                  stops: [0, 1],
                                                                  begin:
                                                                      AlignmentDirectional(
                                                                          0,
                                                                          -1),
                                                                  end:
                                                                      AlignmentDirectional(
                                                                          0, 1),
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            30),
                                                              ),
                                                              alignment:
                                                                  AlignmentDirectional(
                                                                      0, 0),
                                                              child: Align(
                                                                alignment:
                                                                    AlignmentDirectional(
                                                                        0, 0),
                                                                child:
                                                                    AutoSizeText(
                                                                  FFLocalizations.of(
                                                                          context)!
                                                                      .getText(
                                                                    'bc17vu8n' /* Pump */,
                                                                  ),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .title1
                                                                      .override(
                                                                        fontFamily:
                                                                            'Poppins',
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .primaryBtnText,
                                                                        fontSize:
                                                                            23,
                                                                      ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          children: [
                                                            Expanded(
                                                                flex: 1,
                                                                child: dataDB
                                                                        .isNotEmpty
                                                                    ? AutoSizeText(
                                                                        "Nivel de agua${dataDB[4]}",
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyText1
                                                                            .override(
                                                                              fontFamily: 'Poppins',
                                                                              color: Colors.green.shade300,
                                                                              fontSize: 12,
                                                                              fontWeight: FontWeight.w500,
                                                                            ),
                                                                      )
                                                                    : LinearProgressIndicator(
                                                                        color: Colors
                                                                            .grey,
                                                                      )),
                                                          ],
                                                        ),
                                                        Expanded(
                                                            flex: 1,
                                                            child: Padding(
                                                                padding:
                                                                    EdgeInsets
                                                                        .fromLTRB(
                                                                            5,
                                                                            10,
                                                                            5,
                                                                            10),
                                                                child: Tooltip(
                                                                  //verticalOffset: -80,
                                                                  height: 25,
                                                                  message:
                                                                      "Enciende la bomba de agua",
                                                                  child:
                                                                      ListTile(
                                                                    style:
                                                                        ListTileStyle
                                                                            .list,
                                                                    hoverColor:
                                                                        Colors
                                                                            .red,
                                                                    title: Text(
                                                                        "Activar"),
                                                                    subtitle:
                                                                        Text(
                                                                      "Bomba de agua",
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              12.5),
                                                                    ),
                                                                    trailing: Icon(
                                                                        Ionicons
                                                                            .cloud_outline),
                                                                    selected: selectBOn ==
                                                                            null
                                                                        ? bombaOn()
                                                                        : selectBOn!,
                                                                    onTap: () {
                                                                      setState(
                                                                          () {
                                                                        if (selectBOn ==
                                                                                null &&
                                                                            bombaOn() ==
                                                                                true) {
                                                                          selectBOn =
                                                                              false;
                                                                          selectBOff =
                                                                              true;
                                                                          infoBD
                                                                              .update({
                                                                            "Bomba":
                                                                                "OFF"
                                                                          });
                                                                        } else {
                                                                          if (selectBOn == null &&
                                                                              bombaOn() == false) {
                                                                            selectBOn =
                                                                                true;
                                                                            selectBOff =
                                                                                false;
                                                                            infoBD.update({
                                                                              "Bomba": "ON"
                                                                            });
                                                                          } else {
                                                                            selectBOn == false
                                                                                ? selectBOn = true
                                                                                : selectBOn = false;
                                                                            if (selectBOn ==
                                                                                true) {
                                                                              infoBD.update({
                                                                                "Bomba": "ON"
                                                                              });
                                                                              selectBOff = false;
                                                                              selectOff = false;
                                                                              selectAuto = false;
                                                                              if (selectAlta == false && selectBaja == false) {
                                                                                selectBaja = true;
                                                                                infoBD.update({
                                                                                  "Motor": "BAJA"
                                                                                });
                                                                              }
                                                                            } else {
                                                                              infoBD.update({
                                                                                "Bomba": "OFF"
                                                                              });
                                                                              selectBOff = true;
                                                                            }
                                                                          }
                                                                        }
                                                                      });
                                                                    },
                                                                  ),
                                                                ))),
                                                        Expanded(
                                                            flex: 1,
                                                            child: Padding(
                                                                padding:
                                                                    EdgeInsets
                                                                        .fromLTRB(
                                                                            5,
                                                                            10,
                                                                            5,
                                                                            10),
                                                                child: Tooltip(
                                                                  // verticalOffset: -80,
                                                                  height: 25,
                                                                  message:
                                                                      "Apaga la bomba de agua",
                                                                  child:
                                                                      ListTile(
                                                                    style:
                                                                        ListTileStyle
                                                                            .list,
                                                                    hoverColor:
                                                                        Colors
                                                                            .red,
                                                                    title: Text(
                                                                        "Desactivar"),
                                                                    subtitle:
                                                                        Text(
                                                                      "Bomba de agua",
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              12.5),
                                                                    ),
                                                                    trailing: Icon(
                                                                        Ionicons
                                                                            .cloud_offline_outline),
                                                                    selected: selectBOff ==
                                                                            null
                                                                        ? bombaOff()
                                                                        : selectBOff!,
                                                                    onTap: () {
                                                                      setState(
                                                                          () {
                                                                        if (selectBOff ==
                                                                                null &&
                                                                            bombaOff() ==
                                                                                true) {
                                                                          selectBOff =
                                                                              false;
                                                                          selectBOn =
                                                                              true;
                                                                          infoBD
                                                                              .update({
                                                                            "Bomba":
                                                                                "ON"
                                                                          });
                                                                        } else {
                                                                          if (selectBOff == null &&
                                                                              bombaOff() == false) {
                                                                            selectBOff =
                                                                                true;
                                                                            selectBOn =
                                                                                false;
                                                                            infoBD.update({
                                                                              "Bomba": "OFF"
                                                                            });
                                                                          } else {
                                                                            selectBOff == false
                                                                                ? selectBOff = true
                                                                                : selectBOff = false;
                                                                            if (selectBOff ==
                                                                                true) {
                                                                              infoBD.update({
                                                                                "Bomba": "OFF"
                                                                              });
                                                                              selectBOn = false;
                                                                              selectAuto = false;
                                                                              if (selectAlta == false && selectBaja == false) {
                                                                                selectOff = true;
                                                                                infoBD.update({
                                                                                  "Motor": "APAGADO"
                                                                                });
                                                                              }
                                                                            } else {
                                                                              infoBD.update({
                                                                                "Bomba": "ON"
                                                                              });
                                                                              selectBOn = true;
                                                                            }
                                                                          }
                                                                        }
                                                                      });
                                                                    },
                                                                  ),
                                                                ))),
                                                        Expanded(
                                                            flex: 1,
                                                            child: Padding(
                                                                padding:
                                                                    EdgeInsets
                                                                        .fromLTRB(
                                                                            5,
                                                                            10,
                                                                            5,
                                                                            10),
                                                                child: Tooltip(
                                                                  // verticalOffset: -80,
                                                                  height: 25,
                                                                  message:
                                                                      "Control automático de motor y bomba",
                                                                  child:
                                                                      ListTile(
                                                                    style:
                                                                        ListTileStyle
                                                                            .list,
                                                                    hoverColor:
                                                                        Colors
                                                                            .red,
                                                                    title: Text(
                                                                        "Modo"),
                                                                    subtitle:
                                                                        Text(
                                                                      "Automático",
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              12.5),
                                                                    ),
                                                                    trailing:
                                                                        Icon(
                                                                      Icons
                                                                          .motion_photos_auto_outlined,
                                                                      size: 30,
                                                                    ),
                                                                    selected: selectAuto ==
                                                                            null
                                                                        ? motorAuto()
                                                                        : selectAuto!,
                                                                    onTap: () {
                                                                      setState(
                                                                          () {
                                                                        if (selectAuto ==
                                                                                null &&
                                                                            motorAuto() ==
                                                                                true) {
                                                                          selectAuto =
                                                                              false;
                                                                          selectOff =
                                                                              true;
                                                                          selectBOff =
                                                                              true;
                                                                          infoBD
                                                                              .update({
                                                                            "Motor":
                                                                                "APAGADO",
                                                                            "Bomba":
                                                                                "OFF"
                                                                          });
                                                                        } else {
                                                                          if (selectAuto == null &&
                                                                              motorAuto() == false) {
                                                                            selectAuto =
                                                                                true;
                                                                            selectBOff =
                                                                                false;
                                                                            selectBOn =
                                                                                false;
                                                                            selectAlta =
                                                                                false;
                                                                            selectBaja =
                                                                                false;
                                                                            selectOff =
                                                                                false;
                                                                            infoBD.update({
                                                                              "Motor": "AUTO"
                                                                            });
                                                                          } else {
                                                                            selectAuto == false
                                                                                ? selectAuto = true
                                                                                : selectAuto = false;
                                                                            if (selectAuto ==
                                                                                true) {
                                                                              infoBD.update({
                                                                                "Motor": "AUTO"
                                                                              });
                                                                              selectBOff = false;
                                                                              selectBOn = false;
                                                                              selectAlta = false;
                                                                              selectBaja = false;
                                                                              selectOff = false;
                                                                            } else {
                                                                              infoBD.update({
                                                                                "Motor": "APAGADO",
                                                                                "Bomba": "OFF"
                                                                              });
                                                                              selectOff = true;
                                                                              selectBOff = true;
                                                                            }
                                                                          }
                                                                        }
                                                                      });
                                                                    },
                                                                  ),
                                                                ))),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          10, 10, 10, 10),
                                      child: Container(
                                        width: 100,
                                        height: 80,
                                        decoration: BoxDecoration(
                                          color: Color(0xFFEEEEEE),
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          shape: BoxShape.rectangle,
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            FlutterFlowIconButton(
                                              borderColor: Colors.transparent,
                                              borderRadius: 30,
                                              borderWidth: 1,
                                              buttonSize: 60,
                                              fillColor: Color(0xAB0062FF),
                                              icon: Icon(
                                                Icons.access_time_outlined,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryBtnText,
                                                size: 30,
                                              ),
                                              onPressed: () async {
                                                await Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        CyclesWidget(),
                                                  ),
                                                );
                                              },
                                            ),
                                            FlutterFlowIconButton(
                                              borderColor: Colors.transparent,
                                              borderRadius: 30,
                                              borderWidth: 1,
                                              buttonSize: 60,
                                              fillColor: Color(0xAB0062FF),
                                              icon: Icon(
                                                Icons.exit_to_app_outlined,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryBtnText,
                                                size: 30,
                                              ),
                                              onPressed: () async {
                                                await showDialog(
                                                    useSafeArea: true,
                                                    barrierDismissible: false,
                                                    context: context,
                                                    builder:
                                                        (context) =>
                                                            AlertDialog(
                                                              backgroundColor:
                                                                  Colors.white,
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              15)),
                                                              title: const Text(
                                                                  "¿Seguro que deseas cerrar la aplicación?"),
                                                              content: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceAround,
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  children: [
                                                                    ElevatedButton(
                                                                        style:
                                                                            ButtonStyle(
                                                                          shape:
                                                                              MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
                                                                          backgroundColor:
                                                                              MaterialStateProperty.all<Color>(Colors.green),
                                                                        ),
                                                                        onPressed:
                                                                            () {
                                                                          SystemNavigator
                                                                              .pop();
                                                                        },
                                                                        child: const Text(
                                                                            "Sí")),
                                                                    ElevatedButton(
                                                                        style:
                                                                            ButtonStyle(
                                                                          shape:
                                                                              MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
                                                                          backgroundColor:
                                                                              MaterialStateProperty.all<Color>(Colors.red),
                                                                        ),
                                                                        onPressed:
                                                                            () {
                                                                          Navigator.pop(
                                                                              context);
                                                                        },
                                                                        child: const Text(
                                                                            "No"))
                                                                  ]),
                                                            ));
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }

  @override
  void deactivate() {
    _dataStream != null ? _dataStream!.cancel() : print("error");
    super.deactivate();
  }
}
