import 'dart:io';

import 'package:tamtam_view/src/home/home_controller.dart';
import 'package:tamtam_view/src/utils/http_overrides_ext.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tamtam_view/src/settings/local_storage_settings_service.dart';
import 'package:window_size/window_size.dart';

import 'src/app.dart';
import 'src/settings/settings_controller.dart';

void bootstrap() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = HttpOverridesExt();

  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    setWindowMinSize(const Size(800, 600));
  }

  final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  final settingsController = SettingsController(LocalStorageSettingsService(sharedPreferences));
  await settingsController.loadSettings();
  final homeController = HomeController(settingsController.baseUrl);
  await homeController.init();
  

  runApp(MyApp(settingsController: settingsController, homeController: homeController,));
}
