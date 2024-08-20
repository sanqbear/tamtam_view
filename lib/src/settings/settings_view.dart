import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'settings_controller.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key, required this.controller});

  static const routeName = '/settings';

  final SettingsController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: 100, child: Text(AppLocalizations.of(context)!.theme)),
                SizedBox(
                  width: 200,
                  child: DropdownButton<ThemeMode>(
                    value: controller.themeMode,
                    onChanged: controller.updateThemeMode,
                    items: [
                      DropdownMenuItem(
                        value: ThemeMode.system,
                        child: Text(AppLocalizations.of(context)!.themeSystem),
                      ),
                      DropdownMenuItem(
                        value: ThemeMode.light,
                        child: Text(AppLocalizations.of(context)!.themeLight),
                      ),
                      DropdownMenuItem(
                        value: ThemeMode.dark,
                        child: Text(AppLocalizations.of(context)!.themeDark),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: 100, child: Text(AppLocalizations.of(context)!.language)),
                SizedBox(
                  width: 200,
                  child: DropdownButton<String>(
                    value: controller.locale,
                    onChanged: controller.updateLocale,
                    items: [
                      DropdownMenuItem(
                        value: "en",
                        child: Text(AppLocalizations.of(context)!.en),
                      ),
                      DropdownMenuItem(
                        value: "ko",
                        child: Text(AppLocalizations.of(context)!.ko),
                      ),
                      DropdownMenuItem(
                        value: "ja",
                        child: Text(AppLocalizations.of(context)!.ja),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            // add refresh button widget here
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                BaseUrlTextField(baseUrl: controller.baseUrl),
                ElevatedButton(
                    onPressed: () => {},
                    child: Tooltip(
                      message:
                          controller.isUrlOk ? 
                          AppLocalizations.of(context)!.msg_ThisURLIsCurrentlyReachable : 
                          AppLocalizations.of(context)!.msg_ThisURLIsCurrentlyUnreachable,
                      child: controller.isUrlOk
                          ? const Icon(Icons.check_circle)
                          : const Icon(Icons.error),
                    )),
                ElevatedButton(
                  onPressed: controller.checkUrlStatus,
                  // use icon not text
                  child: Tooltip(
                    message: AppLocalizations.of(context)!.refresh,
                    child: const Icon(Icons.refresh),
                  )
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class BaseUrlTextField extends StatefulWidget {
  const BaseUrlTextField({super.key, this.baseUrl});

  final String? baseUrl;

  @override
  State<StatefulWidget> createState() => BaseUrlTextState();
}

class BaseUrlTextState extends State<BaseUrlTextField> {
  final textController = TextEditingController();

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    textController.text = widget.baseUrl ?? '';
    return Expanded(
      child: TextField(
        readOnly: true,
        controller: textController,
        decoration: InputDecoration(
          labelText: AppLocalizations.of(context)!.serviceUrl,
          hintText: 'https://example.com',
        ),
      ),
    );
  }
}
