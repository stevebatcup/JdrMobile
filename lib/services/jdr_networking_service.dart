import 'package:http/http.dart' as http;
import 'dart:convert';

// const String host = 'https://www.jazzdrummersresource.com';
const String host = 'http://localhost:3000';

class JdrNetworkingService {
  final Map<String, String> headers = {
    'X-MobileApp': '1',
    'Accept': 'application/json',
  };

  Future getData(path) async {
    http.Response response = await http.get('$host$path');

    if (response.statusCode == 200) {
      String data = response.body;

      return jsonDecode(data);
    } else {
      print(response.statusCode);
    }
  }

  Future postData({String path, Map postData}) async {
    http.Response response =
        await http.post('$host$path', body: postData, headers: headers);

    if ([200, 422, 401].contains(response.statusCode)) {
      String data = response.body;

      return jsonDecode(data);
    } else {
      print(response.statusCode);
    }
  }
}
