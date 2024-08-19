import 'package:flutter/material.dart';

import 'package:tamtam_view/src/home/home_controller.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key, required this.controller});

  static const routeName = '/';

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    controller.init();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      // render list gallery here
      body: ListView.builder(
        restorationId: 'homeView',
        itemCount: controller.choesin.length,
        itemBuilder: (BuildContext context, int index) {
          final item = controller.choesin[index];

          return ListTile(
            title: Text(item.title),
            leading: CircleAvatar(
              foregroundImage: AssetImage(item.thumbnailUrl),
            ),
            onTap: () {
              
            },
          );
        },
      ),


    );
  }
}