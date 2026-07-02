import 'package:flutter/material.dart';
import '../l10n/l10n.dart';
// Make sure the L10n class is defined and exported in l10n.dart

class LocaleProvider extends ChangeNotifier {
  Locale _locale = const Locale('ar');

  Locale get locale => _locale;

  void setLocale(Locale locale) {
    if (!L10n.all.contains(locale)) return;
    _locale = locale;
    notifyListeners();
  }

  void clearLocale() {
    _locale = const Locale('ar');
    notifyListeners();
  }

  void toggleLocale() {
    if (_locale.languageCode == 'ar') {
      _locale = const Locale('fr');
    } else {
      _locale = const Locale('ar');
    }
    notifyListeners();
  }
}