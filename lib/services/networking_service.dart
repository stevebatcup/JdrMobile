import 'package:http/http.dart' as http;
import 'dart:convert';

class JdrNetworkingService {
  final Map<String, String> headers = {
    'X-MobileApp': '1',
    'Accept': 'application/json',
  };

  Future getData(url) async {
    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      String data = response.body;

      return jsonDecode(data);
    } else {
      print(response.statusCode);
    }
  }

  Future postData({String url, Map postData}) async {
    http.Response response =
        await http.post(url, body: postData, headers: headers);

    if ([200, 422, 401].contains(response.statusCode)) {
      String data = response.body;

      return jsonDecode(data);
    } else {
      print(response.statusCode);
    }
  }
}
