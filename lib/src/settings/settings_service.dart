import 'package:flutter/material.dart';

abstract class SettingsService {
  Future<ThemeMode> themeMode() async => ThemeMode.system;

  Future<String> baseUrl() async => "";

  Future<String> locale() async => "en";

  Future<void> updateThemeMode(ThemeMode theme) async {
    // No implementation
  }

  Future<void> updateBaseUrl(String url) async {
    // No implementation
  }

  Future<void> updateLocale(String locale) async {
    // No implementation
  }
}
