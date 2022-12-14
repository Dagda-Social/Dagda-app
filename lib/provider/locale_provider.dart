import 'package:universal_io/io.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../l10n/l10n.dart';

class LocaleProvider extends ChangeNotifier {
  Locale _locale = Locale.fromSubtags(languageCode: Platform.localeName);

  Locale get locale => _locale;

  void setLocale(Locale locale) {
    if (!L10n.all.contains(locale)) return;

    _locale = locale;
    notifyListeners();
    saveLanguage(locale);
  }

  void clearLocale() {
    _locale = Locale.fromSubtags(languageCode: Platform.localeName);
    notifyListeners();
  }

  void setLocaleInitial(Locale locale) {
    String _language = 'en';
    Locale _locale = Locale.fromSubtags(languageCode: _language);
    L10n.all.forEach((element) {
      if (locale.toString().contains(element.toString())) {
        _locale = element;
      }
    });

    setLocale(_locale);
    notifyListeners();
  }

  Future<void> saveLanguage(Locale locale) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('language', locale.toString());
    sharedPreferences.setBool('savedLanguage', true);
  }

  Future<String> getSavedLanguage() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String _language = sharedPreferences.getString('language') ?? '';
    return _language;
  }

  Future<bool> getIsLanguage() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool _language = sharedPreferences.getBool('savedLanguage') ?? false;
    return _language;
  }
}

Future<void> saveLanguage(Locale locale) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sharedPreferences.setString('language', locale.toString());
}

Future<String> getSavedLanguage() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  String _language = sharedPreferences.getString('language') ?? '';
  return _language;
}