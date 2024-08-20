import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tamtam_view/src/settings/settings_service.dart';

class LocalStorageSettingsService extends SettingsService {
  LocalStorageSettingsService(SharedPreferences sharedPreferences) : _sharedPreferences = sharedPreferences;

  final SharedPreferences _sharedPreferences;
  final String _appStoragePrefix = "TAMTAM_";

  @override
  Future<ThemeMode> themeMode() {
    int? themeModeIndex = _sharedPreferences.getInt("$_appStoragePrefix" "THEME_MODE");
    return Future.value(themeModeIndex == null ? ThemeMode.system : ThemeMode.values[themeModeIndex]);
  }

  @override
  Future<String> baseUrl() {
    String? baseUrl = _sharedPreferences.getString("$_appStoragePrefix" "BASE_URL");
    return Future.value(baseUrl ?? "");
  }

  @override
  Future<String> locale() {
    String? locale = _sharedPreferences.getString("$_appStoragePrefix" "LOCALE");
    return Future.value(locale ?? "en");
  }

  @override
  Future<void> updateThemeMode(ThemeMode theme) {
    return _sharedPreferences.setInt("$_appStoragePrefix" "THEME_MODE", theme.index);
  }

  @override
  Future<void> updateBaseUrl(String url) {
    return _sharedPreferences.setString("$_appStoragePrefix" "BASE_URL", url);
  }

  @override
  Future<void> updateLocale(String locale) {
    return _sharedPreferences.setString("$_appStoragePrefix" "LOCALE", locale);
  }
}