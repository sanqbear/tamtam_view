// This is an example unit test.
//
// A unit test tests a single function, method, or class. To learn more about
// writing unit tests, visit
// https://flutter.dev/to/unit-testing

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart';

import 'package:flutter/foundation.dart';

void main() {
  test('http get request', () async {
    http.Request initReq = http.Request("GET", Uri.parse('https://manatoki.net'))..followRedirects = false;
    http.Client baseClient = http.Client();
    var initResponse = await baseClient.send(initReq);

    if(initResponse.statusCode == 302) {
      var location = initResponse.headers['location'];
      if(location != null && location.isNotEmpty == true) {
        debugPrintSynchronously(location);

        http.Request req = http.Request("GET", Uri.parse(location))..followRedirects = false;
        req.headers['user-agent'] = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/104.0.0.0 Safari/537.36";
        http.Client client = http.Client();
        var streamedResponse = await client.send(req);
        if(streamedResponse.statusCode == 200) {
          var response = await http.Response.fromStream(streamedResponse);

          var document = parse(response.body);

          var a = document.getElementsByClassName("miso-post-gallery");
          if(a.isNotEmpty) {
            var b = a[0].getElementsByClassName("post-row");
            for (var item in b) {
              debugPrintSynchronously(item.getElementsByClassName("in-subject").firstOrNull?.getElementsByTagName('b').firstOrNull?.text);
            }
            expect(b, isNotNull);
          }
        }
      }
    }
  });
}
