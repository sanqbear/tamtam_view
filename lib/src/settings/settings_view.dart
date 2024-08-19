import 'package:flutter/material.dart';

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
                DropdownButton<ThemeMode>(
                  value: controller.themeMode,
                  onChanged: controller.updateThemeMode,
                  items: const [
                    DropdownMenuItem(
                      value: ThemeMode.system,
                      child: Text('System Theme'),
                    ),
                    DropdownMenuItem(
                      value: ThemeMode.light,
                      child: Text('Light Theme'),
                    ),
                    DropdownMenuItem(
                      value: ThemeMode.dark,
                      child: Text('Dark Theme'),
                    )
                  ],
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
                          controller.isUrlOk ? 'URL is OK' : 'URL is not OK',
                      child: controller.isUrlOk
                          ? const Icon(Icons.check_circle)
                          : const Icon(Icons.error),
                    )),
                ElevatedButton(
                  onPressed: controller.checkUrlStatus,
                  // use icon not text
                  child: const Icon(Icons.refresh),
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
        decoration: const InputDecoration(
          labelText: 'Base URL',
          hintText: 'https://manatoki.net',
        ),
      ),
    );
  }
}
