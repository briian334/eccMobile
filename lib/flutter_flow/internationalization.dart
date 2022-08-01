import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class FFLocalizations {
  FFLocalizations(this.locale);

  final Locale locale;

  static FFLocalizations? of(BuildContext context) =>
      Localizations.of<FFLocalizations>(context, FFLocalizations);

  static List<String> languages() => ['en', 'es'];

  String get languageCode => locale.languageCode;
  int get languageIndex => languages().contains(languageCode)
      ? languages().indexOf(languageCode)
      : 0;

  String getText(String key) =>
      (kTranslationsMap[key] ?? {})[locale.languageCode] ?? '';

  String getVariableText({
    String enText = '',
    String esText = '',
  }) =>
      [enText, esText][languageIndex];
}

class FFLocalizationsDelegate extends LocalizationsDelegate<FFLocalizations> {
  const FFLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      FFLocalizations.languages().contains(locale.languageCode);

  @override
  Future<FFLocalizations> load(Locale locale) =>
      SynchronousFuture<FFLocalizations>(FFLocalizations(locale));

  @override
  bool shouldReload(FFLocalizationsDelegate old) => false;
}

final kTranslationsMap = <Map<String, Map<String, String>>>[
  // HomePage
  {
    '9tc8w57z': {
      'en': 'Temperatura',
      'es': 'Temperatura',
    },
    'of3ql7h5': {
      'en': '72 °C',
      'es': '72 ºC',
    },
    '1pk027xo': {
      'en': 'Humedad',
      'es': 'Humedad',
    },
    'qknkpbgg': {
      'en': '72 °C',
      'es': '72 ºC',
    },
    'hk3y6iyz': {
      'en': 'Motor',
      'es': 'Motor',
    },
    '3izvvu9c': {
      'en': 'OFF',
      'es': 'Apagar',
    },
    '05zqvxof': {
      'en': '',
      'es': '',
    },
    '2sjrs445': {
      'en': 'High',
      'es': 'Alta',
    },
    'b1pa2gwv': {
      'en': '',
      'es': '',
    },
    'l4a9m02a': {
      'en': 'Low',
      'es': 'Baja',
    },
    'qtt2avry': {
      'en': '',
      'es': '',
    },
    'xk26dvdl': {
      'en': 'Auto',
      'es': 'Auto',
    },
    'uba64852': {
      'en': '',
      'es': '',
    },
    'bc17vu8n': {
      'en': 'Bomba',
      'es': 'Bomba',
    },
    'wmt24s7r': {
      'en': 'Water level',
      'es': 'Nivel de agua: correcto',
    },
    'psp6jgk4': {
      'en': 'ON',
      'es': 'Activar',
    },
    '1vueff8o': {
      'en': '',
      'es': '',
    },
    'hcium869': {
      'en': 'OFF',
      'es': 'Apagar',
    },
    'er5ex1yu': {
      'en': '',
      'es': '',
    },
    'b77t5uvb': {
      'en': 'Lenguaje',
      'es': 'Lenguaje',
    },
    'cms6qdbm': {
      'en': 'Hogar',
      'es': 'Hogar',
    },
  },
  // Cycles
  {
    '2q22sbfg': {
      'en': '5:02 p. m.',
      'es': '5:02 p. m.',
    },
    'n09jmmir': {
      'en': 'V. Alta, B. Activada',
      'es': 'V. Alta, B. Activada',
    },
    'qw8lnxo4': {
      'en': '5:02 p. m.',
      'es': '5:02 p. m.',
    },
    'p7dc867o': {
      'en': 'V. Alta, B. Activada',
      'es': 'V. Alta, B. Activada',
    },
    'qqp5kimq': {
      'en': 'Language',
      'es': 'Lenguaje',
    },
    'jvuw91zq': {
      'en': 'Home',
      'es': 'Hogar',
    },
  },
].reduce((a, b) => a..addAll(b));
