import 'package:injectable/injectable.dart';
import 'package:jdr/models/user.dart';
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

  Future<AuthResult> signInWithEmail({String email, String password}) async {
    Map<String, String> postData = {
      "user[email]": email,
      "user[password]": password,
    };
    var result =
        await _networkService.postData(path: loginEndPoint, postData: postData);
    if (result.containsKey('error')) {
      return AuthResult(
          status: AuthResultStatus.error, message: result['error']);
    } else if (result.containsKey('user')) {
      _currentUser = User.fromJson(result['user']);
      return AuthResult(status: AuthResultStatus.success);
    }
    return null;
  }

  User get currentUser => _currentUser;
}
