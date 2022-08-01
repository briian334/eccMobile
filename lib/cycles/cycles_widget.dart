import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:workmanager/workmanager.dart';

import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../home_page/home_page_widget.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import 'showModal.dart';

TimeOfDay? currentTime;
TimeOfDay? selectTime;
TimeOfDay? horaActual;
TimeOfDay? horaCiclo;
//VARIABLES PARA LOS SWITCHES DE CICLOS *MOTOR*
bool valueAlta = false;
bool valueBaja = false;
bool valueOff = false;
bool valueAuto = false;
//VARIABLES PARA LOS SWITCHES DE CICLOS *BOMBA*
bool valueBOff = false;
bool valueBOn = false;
bool valueBAuto = false;

//LISTA DE CICLOS TRAIDOS DE LA BD
List cycleBuilder = [];

class CyclesWidget extends StatefulWidget {
  const CyclesWidget({Key? key}) : super(key: key);

  @override
  _CyclesWidgetState createState() => _CyclesWidgetState();
}

class _CyclesWidgetState extends State<CyclesWidget> {
  bool valueList = false; //VALOR PARA LOS SWITCH LIST TILES DE LOS CICLOS
  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentTime = TimeOfDay.fromDateTime(DateTime.now());

    getCycles();
  }

  void getCycles() async {
    List temp = []; //lista temporarl
    CollectionReference ciclos =
        FirebaseFirestore.instance.collection("Cycles");
    QuerySnapshot data = await ciclos.get();
    if (data.docs.length > 0) {
      for (var element in data.docs) {
        temp.add(element.data());
      }
    }
    if (cycleBuilder.isEmpty) {
      setState(() {
        cycleBuilder.addAll(temp);
      });
    } else {
      setState(() {
        cycleBuilder.clear();
        cycleBuilder.addAll(temp);
      });
    }
    // print("$temp");
  }

  dynamic ref = FirebaseFirestore.instance.collection('Cycles').snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                            padding:
                                EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        10, 10, 10, 10),
                                    child: Container(
                                      width: double.infinity,
                                      height: 230,
                                      decoration: BoxDecoration(
                                        color: Color(0xFFEEEEEE),
                                        borderRadius: BorderRadius.circular(30),
                                        shape: BoxShape.rectangle,
                                      ),
                                      child: StreamBuilder(
                                        stream: ref,
                                        builder: (context,
                                            AsyncSnapshot<QuerySnapshot>
                                                streamSnapshot) {
                                          List datos = [];
                                          if (streamSnapshot
                                                  .data?.docs.length !=
                                              null) {
                                            for (var element
                                                in streamSnapshot.data!.docs) {
                                              datos.add({
                                                'id': element.id,
                                                'data': element.data()
                                              });
                                            }
                                          }
                                          // print(datosID[1]['']['Motor']);
                                          String?
                                              subtittleM; //PARA SABER EL ESTADO DEL MOTOR
                                          String?
                                              subtittleB; //PARA SABER EL ESTADO DE LA BOMBA

                                          return datos.isEmpty
                                              ? Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Expanded(
                                                      flex: 1,
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.all(20),
                                                        child: Text(
                                                          "¡No existen ciclos! intenta agregar uno",
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                              fontSize: 20),
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 1,
                                                      child: Image.asset(
                                                          'assets/images/error404.png',
                                                          fit: BoxFit.cover),
                                                    ),
                                                  ],
                                                )
                                              : ListView.builder(
                                                  itemCount: streamSnapshot
                                                      .data?.docs.length,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          int index) {
                                                    if (datos[index]['data']
                                                            ['Motor'] ==
                                                        'ALTA') {
                                                      subtittleM = "V.Alta, ";
                                                    } else {
                                                      if (datos[index]['data']
                                                              ['Motor'] ==
                                                          'BAJA') {
                                                        subtittleM =
                                                            "V. Baja, ";
                                                      } else {
                                                        if (datos[index]['data']
                                                                ['Motor'] ==
                                                            'AUTO') {
                                                          subtittleM =
                                                              "Modo automático";
                                                          subtittleB = "";
                                                        } else {
                                                          if (datos[index]
                                                                      ['data']
                                                                  ['Motor'] ==
                                                              'APAGADO') {
                                                            subtittleM =
                                                                "M. Apagado, ";
                                                          }
                                                        }
                                                      }
                                                    }
                                                    //VERIFICACIÓN PARA LA BOMBA
                                                    if (datos[index]['data']
                                                            ['Bomba'] ==
                                                        'ON') {
                                                      subtittleB =
                                                          "B. Activada";
                                                    } else {
                                                      if (datos[index]['data']
                                                              ['Bomba'] ==
                                                          'OFF') {
                                                        subtittleB =
                                                            "B. Apagada";
                                                      }
                                                    }
                                                    bool valueList =
                                                        datos[index]['data']
                                                            ['Estado'];
                                                    dynamic tiempo1 = datos[
                                                                        index]
                                                                    ['data']
                                                                ['hourSelect'] *
                                                            60 +
                                                        datos[index]['data']
                                                            ['minuteSelect'];
                                                    dynamic tiempo2 =
                                                        TimeOfDay.now().hour *
                                                                60 +
                                                            TimeOfDay.now()
                                                                .minute;
                                                    dynamic total =
                                                        tiempo1 - tiempo2;
                                                    if (total <= 0) {
                                                      total = 720 +
                                                          (tiempo1 - tiempo2);
                                                    }
                                                    //print(total);
                                                    return ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              33),
                                                      child: SwitchListTile
                                                          .adaptive(
                                                        value: valueList,
                                                        onChanged: (newValue) {
                                                          setState(() {
                                                            valueList == false
                                                                ? db
                                                                    .collection(
                                                                        'Cycles')
                                                                    .doc(
                                                                        '${datos[index]['id']}')
                                                                    .update({
                                                                    'Estado':
                                                                        true
                                                                  })
                                                                : db
                                                                    .collection(
                                                                        'Cycles')
                                                                    .doc(
                                                                        '${datos[index]['id']}')
                                                                    .update({
                                                                    'Estado':
                                                                        false
                                                                  });
                                                          });
                                                          if (datos[index]
                                                                      ['data']
                                                                  ['Estado'] ==
                                                              false) {
                                                            if (datos[index]
                                                                        ['data']
                                                                    ['Motor'] !=
                                                                'AUTO') {
                                                              Workmanager().registerOneOffTask(
                                                                  '${datos[index]['id']}',
                                                                  'NuevoCiclo',
                                                                  inputData: {
                                                                    'Motor': datos[index]
                                                                            [
                                                                            'data']
                                                                        [
                                                                        'Motor'],
                                                                    'Bomba': datos[index]
                                                                            [
                                                                            'data']
                                                                        [
                                                                        'Bomba'],
                                                                    'id': datos[
                                                                            index]
                                                                        ['id']
                                                                  },
                                                                  initialDelay:
                                                                      (Duration(
                                                                          minutes:
                                                                              total)));
                                                            } else {
                                                              Workmanager().registerOneOffTask(
                                                                  '${datos[index]['id']}',
                                                                  'NuevoCiclo',
                                                                  inputData: {
                                                                    'Motor': datos[index]
                                                                            [
                                                                            'data']
                                                                        [
                                                                        'Motor'],
                                                                    'id': datos[
                                                                            index]
                                                                        ['id']
                                                                  },
                                                                  initialDelay:
                                                                      (Duration(
                                                                          minutes:
                                                                              total)));
                                                            }
                                                          } else {
                                                            Workmanager()
                                                                .cancelByUniqueName(
                                                                    '${datos[index]['id']}');
                                                          }
                                                        },
                                                        title: Text(
                                                          "${datos[index]['data']['Hora']}",
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .title3,
                                                        ),
                                                        subtitle: Text(
                                                          "$subtittleM$subtittleB",
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .subtitle2,
                                                        ),
                                                        secondary: IconButton(
                                                          onPressed: () {
                                                            Workmanager()
                                                                .cancelByUniqueName(
                                                                    '${datos[index]['id']}');
                                                            db
                                                                .collection(
                                                                    'Cycles')
                                                                .doc(
                                                                    '${datos[index]['id']}')
                                                                .delete();
                                                          },
                                                          icon: Icon(
                                                              Icons.delete,
                                                              color:
                                                                  Colors.red),
                                                        ),
                                                        activeColor:
                                                            Color(0xFF008A29),
                                                        activeTrackColor:
                                                            Color(0xFF828282),
                                                        dense: false,
                                                        controlAffinity:
                                                            ListTileControlAffinity
                                                                .trailing,
                                                        contentPadding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(15,
                                                                    15, 15, 15),
                                                      ),
                                                    );
                                                  },
                                                );
                                        },
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
                                    borderRadius: BorderRadius.circular(30),
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
                                        icon: FaIcon(
                                          FontAwesomeIcons.home,
                                          color: FlutterFlowTheme.of(context)
                                              .primaryBtnText,
                                          size: 30,
                                        ),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      ),
                                      FlutterFlowIconButton(
                                        borderColor: Colors.transparent,
                                        borderRadius: 30,
                                        borderWidth: 1,
                                        buttonSize: 60,
                                        fillColor: Color(0xAB0062FF),
                                        icon: Icon(
                                          Icons.add_outlined,
                                          color: FlutterFlowTheme.of(context)
                                              .primaryBtnText,
                                          size: 30,
                                        ),
                                        onPressed: () {
                                          showModalBottomSheet(
                                              isDismissible: false,
                                              context: context,
                                              builder: (context) => Modal());
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
}
