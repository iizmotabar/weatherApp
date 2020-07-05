import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  final String url;
  NetworkHelper({this.url});

  Future<dynamic> getData() async {
    http.Response response = await http.get(url);
    if (response.statusCode > 299) {
      print('This is the error status code ${response.statusCode}');
    } else {
      String responseBody = response.body;
      print(responseBody);
      return jsonDecode(responseBody);
    }
  }
}
