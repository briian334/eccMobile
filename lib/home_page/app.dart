import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/internationalization.dart';
import 'home_page_widget.dart';

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  State<MyApp> createState() => _MyAppState();

  static _MyAppState? of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>();
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;

  void setLocale(Locale value) => setState(() => _locale = value);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'ECC MOBILE',
        localizationsDelegates: [
          FFLocalizationsDelegate(),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        locale: _locale,
        //theme: ThemeData(brightness: Brightness.light),
        //darkTheme: ThemeData(brightness: Brightness.dark),
        //themeMode: _themeMode,
        debugShowCheckedModeBanner: false,
        home: HomePageWidget());
  }
}
