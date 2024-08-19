import 'package:flutter/material.dart';

import 'settings_service.dart';
import 'package:http/http.dart';

class SettingsController with ChangeNotifier {
  SettingsController(this._settingsService);

  final SettingsService _settingsService;
  final String _sourceUrl = "https://manatoki.net";

  late String _baseUrl;
  late ThemeMode _themeMode;
  late bool _isUrlOk;

  ThemeMode get themeMode => _themeMode;
  String get baseUrl => _baseUrl;
  bool get isUrlOk => _isUrlOk;

  Future<void> loadSettings() async {
    _themeMode = await _settingsService.themeMode();
    _baseUrl = await _settingsService.baseUrl();
    _isUrlOk = await checkUrlStatus();
    notifyListeners();
  }

  Future<bool> checkUrlStatus() async {
    bool isOk = false;
    if (baseUrl.isNotEmpty) {
      isOk = await isUrlResponseOk(baseUrl);
      if(isOk) return Future.value(isOk);
    }

    Request newReq = Request("GET", Uri.parse(_sourceUrl))..followRedirects = false;
    newReq.headers['user-agent'] = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/104.0.0.0 Safari/537.36";
    Client newClient = Client();
    var res = await newClient.send(newReq);
    if(res.statusCode == 302) {
      var location = res.headers['location'];
      if(location != null && location.isNotEmpty == true) {
        await updateBaseUrl(location);
        isOk = await isUrlResponseOk(location);
        return Future.value(isOk);
      }
    }
    return Future.value(false);
  }

  Future<bool> isUrlResponseOk(String? url) async {
    if (url == null) return false;
    if (url.isEmpty) return false;

    Request req = Request("GET", Uri.parse(url))..followRedirects = false;
    req.headers['user-agent'] = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/104.0.0.0 Safari/537.36";
    try {
      Client client = Client();
      var response = await client.send(req);
      return Future.value(response.statusCode == 200);
    } catch (e) {
      return Future.value(false);
    }
  }

  /// Update and persist the ThemeMode based on the user's selection.
  Future<void> updateThemeMode(ThemeMode? newThemeMode) async {
    if (newThemeMode == null) return;

    if (newThemeMode == _themeMode) return;

    _themeMode = newThemeMode;

    notifyListeners();

    await _settingsService.updateThemeMode(newThemeMode);
  }

  Future<void> updateBaseUrl(String? url) async {
    if (url == null) return;
    if (url.isEmpty) return;
    if (url == _baseUrl) return;

    _baseUrl = url;

    notifyListeners();

    await _settingsService.updateBaseUrl(url);
  }
}
