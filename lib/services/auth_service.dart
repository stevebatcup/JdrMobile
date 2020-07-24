import 'package:injectable/injectable.dart';
import 'package:jdr/datamodels/user.dart';
import 'jdr_networking_service.dart';

const loginEndPoint = '/users/login';

enum AuthResultStatus {
  success,
  error,
}

class AuthResult {
  final String message;
  final AuthResultStatus status;

  AuthResult({this.status, this.message});
}

@lazySingleton
class AuthService {
  JdrNetworkingService _networkService = JdrNetworkingService();

  User _currentUser;
  User get currentUser => _currentUser;

  String _sessionCookie;
  String get sessionCookie => _sessionCookie;

  Future<AuthResult> signInWithEmail({String email, String password}) async {
    Map<String, String> postData = {
      "user[email]": email,
      "user[password]": password,
    };
    JdrNetworkingResponse result =
        await _networkService.postData(loginEndPoint, postData: postData);
    if (result.jsonData.containsKey('error')) {
      return AuthResult(
          status: AuthResultStatus.error, message: result.jsonData['error']);
    } else if (result.jsonData.containsKey('user')) {
      updateSessionCookie(result);
      _currentUser = User.fromJson(result.jsonData['user']);
      return AuthResult(status: AuthResultStatus.success);
    }
    return null;
  }

  void updateSessionCookie(JdrNetworkingResponse result) {
    String rawCookie = result.cookie;
    if (rawCookie != null) {
      int index = rawCookie.indexOf(';');
      _sessionCookie =
          (index == -1) ? rawCookie : rawCookie.substring(0, index);
    }
  }

  Future<bool> signOut() async {
    bool result = await _networkService.delete(
      "/users/logout",
      sessionCookie: _sessionCookie,
    );
    _sessionCookie = null;
    _currentUser = null;
    return result;
  }
}
