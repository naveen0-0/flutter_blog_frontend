import 'package:http/http.dart' as http;

class NetWorkHandler{
  String baseUrl = "https://flutterrealblogserver.herokuapp.com/";

  Future<dynamic> get(String url) async {
    var response = await http.get(Uri.parse(baseUrl));
    print(response.body);
    print(response.statusCode);
  }


  String formatter(String url) => baseUrl+url;
}