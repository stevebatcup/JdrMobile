import 'package:injectable/injectable.dart';
import 'package:jdr/app/locator.dart';
import 'package:jdr/datamodels/category.dart';
import 'package:jdr/datamodels/user.dart';
import 'jdr_networking_service.dart';
import 'local_storage_service.dart';

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
  final _storageService = locator<LocalStorageService>();

  User _currentUser;
  User get currentUser => _currentUser;

  String _sessionCookie;
  String get sessionCookie => _sessionCookie;

  Future<bool> loadCurrentUserDetails() async {
    if (_storageService.user != null) {
      _currentUser = _storageService.user;
      _sessionCookie = _storageService.sessionCookie;
      return true;
    } else {
      return false;
    }
  }

  void storeCurrentUserDetails() {
    _storageService.user = _currentUser;
    _storageService.sessionCookie = _sessionCookie;
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

      storeCurrentUserDetails();
      Category.storeCategories(
        rootCategories: result.jsonData['rootCategories'],
        categories: result.jsonData['categories'],
      );

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
    _storageService.clearUserData();

    return result;
  }
}
