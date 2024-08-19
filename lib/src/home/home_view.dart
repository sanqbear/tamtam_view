import 'package:flutter/material.dart';

import 'package:tamtam_view/src/home/home_controller.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key, required this.controller});

  static const routeName = '/';

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      // render list gallery here
      body: Column(
        children: [
          ListView.builder(
            restorationId: 'homeView.choesin',
            itemCount: controller.choesin.length,
            itemBuilder: (BuildContext context, int index) {
              final item = controller.choesin[index];
              return ListTile(
                title: Text(item.title),
                // thumbnail on box
                leading: Image.network(item.thumbnailUrl),
                onTap: () {
                  
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
