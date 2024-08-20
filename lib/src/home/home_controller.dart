import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;


import 'package:tamtam_view/src/models/gallery_item.dart';

class HomeController extends ChangeNotifier {
  HomeController(this.homeUri);

  final String homeUri;

  final List<GalleryItem> _choesin = [];
  final List<GalleryItem> _manhwa = [];
  final List<GalleryItem> _jugan = [];

  List<GalleryItem> get choesin => _choesin;
  List<GalleryItem> get manhwa => _manhwa;
  List<GalleryItem> get jugan => _jugan;

  Future<void> init() async {
    clear();
    await loadGalleries();
    notifyListeners();
  }


  Future<void> loadGalleries() async {
    clear();

    var responseBody = await fetchHomepage();
    if(responseBody.isNotEmpty) {
      var document = parse(responseBody);
      var el = document.getElementsByClassName("miso-post-gallery");
      if(el.isNotEmpty) {
        var rows = el.first.getElementsByClassName("post-row");
        if(rows.isNotEmpty) {
          for(var row in rows) {
            var rightEl = row.getElementsByClassName("pull-right");
            if(rightEl.isNotEmpty) rightEl.first.remove();
            String linkUrl = (row.getElementsByTagName("a").isNotEmpty) ? row.getElementsByTagName("a").first.attributes["href"]?.trim() ?? "" : "";
            String thumbUrl = (row.getElementsByTagName("img").isNotEmpty) ? row.getElementsByTagName("img").first.attributes["src"]?.trim() ?? "" : "";
            String title = (row.getElementsByClassName("in-subject").isNotEmpty) ? row.getElementsByClassName("in-subject").first.text.trim() : "";
            _choesin.add(GalleryItem(linkUrl: linkUrl, thumbnailUrl: thumbUrl, title: title));
          }
        }

        if(el.length > 1) {
          var rows = el[1].getElementsByClassName("post-row");
          if(rows.isNotEmpty) {
            for(var row in rows) {
              var rightEl = row.getElementsByClassName("pull-right");
            if(rightEl.isNotEmpty) rightEl.first.remove();
              String linkUrl = (row.getElementsByTagName("a").isNotEmpty) ? row.getElementsByTagName("a").first.attributes["href"]?.trim() ?? "" : "";
              String thumbUrl = (row.getElementsByTagName("img").isNotEmpty) ? row.getElementsByTagName("img").first.attributes["src"]?.trim() ?? "" : "";
              String title = (row.getElementsByClassName("in-subject").isNotEmpty) ? row.getElementsByClassName("in-subject").first.text.trim() : "";
              _manhwa.add(GalleryItem(linkUrl: linkUrl, thumbnailUrl: thumbUrl, title: title));
            }
          }
        }
      }

      var el2 = document.querySelector(".tab-content .miso-post-list");
      if(el2 != null) {
        var rows = el2.getElementsByClassName("post-row");
        if(rows.isNotEmpty) {
          for(var row in rows) {
            var rightEl = row.querySelector(".pull-right");
            var rankEl = row.querySelector(".rank-icon");
            if(rightEl != null) rightEl.remove();
            if(rankEl != null) rankEl.remove();
            String linkUrl = (row.getElementsByTagName("a").isNotEmpty) ? row.getElementsByTagName("a").first.attributes["href"]?.trim() ?? "" : "";
            String thumbUrl = (row.getElementsByTagName("img").isNotEmpty) ? row.getElementsByTagName("img").first.attributes["src"]?.trim() ?? "" : "";
            String title = (row.getElementsByTagName("a").isNotEmpty) ? row.getElementsByTagName("a").first.text.trim() : "";
            _jugan.add(GalleryItem(linkUrl: linkUrl, thumbnailUrl: thumbUrl, title: title));
          }
        }
      }
    }

    notifyListeners();
  }


  Future<String> fetchHomepage() async {
    if(homeUri.isEmpty) return "";

    http.Request req = http.Request("GET", Uri.parse(homeUri))..followRedirects = false;
    req.headers['user-agent'] = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/104.0.0.0 Safari/537.36";
    http.Client client = http.Client();
    var streamedResponse = await client.send(req);
    if (streamedResponse.statusCode == 200) {
      var response = await http.Response.fromStream(streamedResponse);
      return response.body;
    }
    else {
      return "";
    }
  }
  
  void clear() {
    _choesin.clear();
    _manhwa.clear();
    _jugan.clear();
  }

  void onItemTap(GalleryItem item) {}

}
