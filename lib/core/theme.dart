import 'package:flutter/material.dart';

class PreferencesTheme{
  static ValueNotifier<Brightness> theme = ValueNotifier(Brightness.light);

  static setTheme() {
    theme.value = WidgetsBinding.instance!.platformDispatcher.platformBrightness;
  }
}
