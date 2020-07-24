import 'package:injectable/injectable.dart';
import 'package:jdr/datamodels/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
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

@singleton
class AuthService {
  JdrNetworkingService _networkService = JdrNetworkingService();

  User _currentUser;
  User get currentUser => _currentUser;

  String _sessionCookie;
  String get sessionCookie => _sessionCookie;

  Future<bool> loadCurrentUserDetails() async {
    final prefs = await SharedPreferences.getInstance();

    if (prefs.getInt('userId') != null) {
      _currentUser = User(
        id: prefs.getInt('userId'),
        firstName: prefs.getString('userFirstName'),
        lastName: prefs.getString('userLastName'),
        email: prefs.getString('userEmail'),
      );
      _sessionCookie = prefs.getString('userSessionCookie');
      return true;
    } else {
      return false;
    }
  }

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
      await storeUserDetails();
      return AuthResult(status: AuthResultStatus.success);
    }
    return null;
  }

  Future<void> storeUserDetails() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('userId', _currentUser.id);
    print(prefs.getInt('userId'));
    prefs.setString('userFirstName', _currentUser.firstName);
    prefs.setString('userLastName', _currentUser.lastName);
    prefs.setString('userEmail', _currentUser.email);
    prefs.setString('userSessionCookie', _sessionCookie);
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

    final prefs = await SharedPreferences.getInstance();
    prefs.clear();

    return result;
  }
}
