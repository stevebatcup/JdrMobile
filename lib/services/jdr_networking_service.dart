import 'package:http/http.dart' as http;
import 'dart:convert';

const String host = 'https://www.jazzdrummersresource.com';
// const String host = 'http://localhost:3000';
// const String host = 'http://10.0.2.2:3000';

class JdrNetworkingService {
  final Map<String, String> headers = {
    'X-MobileApp': '1',
    'Accept': 'application/json',
  };

  Future<JdrNetworkingResponse> getData(String path,
      {String sessionCookie}) async {
    if (sessionCookie != null) {
      headers['Cookie'] = sessionCookie;
    }
    http.Response response = await http.get('$host$path', headers: headers);

    if ([200, 422, 401].contains(response.statusCode)) {
      var jsonData = jsonDecode(response.body);

      return JdrNetworkingResponse(
        jsonData: jsonData,
        cookie: response.headers['set-cookie'],
      );
    } else {
      print(response.statusCode);
      return null;
    }
  }

  Future<bool> delete(String path, {String sessionCookie}) async {
    if (sessionCookie != null) {
      headers['Cookie'] = sessionCookie;
    }
    http.Response response = await http.delete('$host$path', headers: headers);
    print(response.statusCode);
    if ([200, 204].contains(response.statusCode)) {
      return true;
    } else {
      print(response.statusCode);
      return false;
    }
  }

  Future<JdrNetworkingResponse> postData(String path,
      {Map postData, String sessionCookie}) async {
    if (sessionCookie != null) {
      headers['Cookie'] = sessionCookie;
    }
    http.Response response =
        await http.post('$host$path', body: postData, headers: headers);

    if ([200, 422, 401].contains(response.statusCode)) {
      var jsonData = jsonDecode(response.body);

      return JdrNetworkingResponse(
        jsonData: jsonData,
        cookie: response.headers['set-cookie'],
      );
    } else {
      print(response.statusCode);
      return null;
    }
  }
}

class JdrNetworkingResponse {
  final dynamic jsonData;
  final String cookie;

  JdrNetworkingResponse({this.jsonData, this.cookie});
}
