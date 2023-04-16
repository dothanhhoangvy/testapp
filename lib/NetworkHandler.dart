import "dart:convert";

import "package:http/http.dart" as http;
import "package:logger/logger.dart";

var logger = Logger();

class NetworkHandler {
  String baseurl = "http://192.168.1.108:3001";

  Future get(String url) async {
    url = formater(url);
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200 || response.statusCode == 201) {
      logger.i(response.body);
      return json.decode(response.body);
    }
    logger.i(response.body);
    logger.i(response.statusCode);
  }

  Future<http.Response> post(String url, Map<String, String> body) async {
    url = formater(url);
    logger.d(body);
    var response = await http.post(
      Uri.parse(url),
      headers: {"Content-type": "application/json"},
      body: json.encode(body),
    );
    return response;
  }

  String formater(String url) {
    return baseurl + url;
  }
}
