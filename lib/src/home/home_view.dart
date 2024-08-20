import 'package:flutter/material.dart';

import 'package:tamtam_view/src/home/home_controller.dart';
import 'package:tamtam_view/src/models/gallery_item.dart';
import 'package:tamtam_view/src/settings/settings_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key, required this.controller});

  static const routeName = '/';

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
          actions: [
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {
                Navigator.restorablePushNamed(context, SettingsView.routeName);
              },
            ),
          ],
        ),
        // render list gallery here
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                HorizontalGalleryListWidget(
                  title: "Choesin",
                  galleries: controller.choesin,
                ),
              ],
            ),
          ),
        ));
  }
}

class HorizontalGalleryListWidget extends StatelessWidget {
  const HorizontalGalleryListWidget({super.key, required this.title, required this.galleries});

  final String title;
  final List<GalleryItem> galleries;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          TitleWidget(title: title),
          SizedBox(
            height: 200,
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: galleries.length,
              itemBuilder: (BuildContext context, int index) {
                return SizedBox(
                  width: 150,
                  child: Column(
                    children: [
                      Image.network(galleries[index].thumbnailUrl, width: 150, height: 150, fit: BoxFit.cover),
                      Text(galleries[index].title),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class TitleWidget extends StatelessWidget {
  const TitleWidget({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    // align left
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }
}
