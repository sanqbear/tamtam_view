import 'package:html/parser.dart';
import 'package:http/http.dart' as http;


import 'package:tamtam_view/src/models/gallery_item.dart';

class HomeController {
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

    var responseBody = await fetchHomepage();
    if(responseBody.isNotEmpty) {
      var document = parse(responseBody);
      var el = document.getElementsByClassName("miso-post-gallery");
      if(el.isNotEmpty) {
        var rows = el.first.getElementsByClassName("post-row");
        if(rows.isNotEmpty) {
          for(var row in rows) {
            var linkUrl = row.getElementsByTagName("a")[0].attributes["href"]?.trim() ?? "";
            var thumbUrl = row.getElementsByTagName("img")[0].attributes["src"]?.trim() ?? "";
            var title = row.getElementsByClassName("in-subject")[0].text.trim();
            _choesin.add(GalleryItem(linkUrl: linkUrl, thumbnailUrl: thumbUrl, title: title));
          }
        }

        if(el.length > 1) {
          var rows = el[1].getElementsByClassName("post-row");
          if(rows.isNotEmpty) {
            for(var row in rows) {
              var linkUrl = row.getElementsByTagName("a")[0].attributes["href"]?.trim() ?? "";
              var thumbUrl = row.getElementsByTagName("img")[0].attributes["src"]?.trim() ?? "";
              var title = row.getElementsByClassName("in-subject")[0].text.trim();
              _manhwa.add(GalleryItem(linkUrl: linkUrl, thumbnailUrl: thumbUrl, title: title));
            }
          }
        }
      }

      var el2 = document.getElementsByClassName("miso-post-list");
      if(el2.isNotEmpty) {
        var rows = el2.first.getElementsByClassName("post-row");
        if(rows.isNotEmpty) {
          for(var row in rows) {
            row.getElementsByClassName("pull-right")[0].remove();
            var linkUrl = row.getElementsByTagName("a")[0].attributes["href"]?.trim() ?? "";
            var thumbUrl = row.getElementsByTagName("img")[0].attributes["src"]?.trim() ?? "";
            var title = row.getElementsByTagName("a")[0].text.trim();
            _jugan.add(GalleryItem(linkUrl: linkUrl, thumbnailUrl: thumbUrl, title: title));
          }
        }
      }
    }
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
