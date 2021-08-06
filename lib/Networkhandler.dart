import 'dart:convert';
import 'package:http/http.dart' as http;

class NetWorkHandler{
  String baseUrl = "https://flutterrealblogserver.herokuapp.com";

  Future<dynamic> get(String url) async {
    var response = await http.get(Uri.parse(formatter(url)));
    if(response.statusCode == 200 || response.statusCode == 201){
      print(response.body);
      return json.decode(response.body);
    }
  }

  Future<http.Response> post(String url,Map<String,String> body) async {
    url = formatter(url);
    var response = await http.post(Uri.parse(url),
      body: json.encode(body),
      headers: { "Content-type":"application/json" }
    );
    return response;
  }


  String formatter(String url) => baseUrl+url;
}