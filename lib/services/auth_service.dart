import 'package:injectable/injectable.dart';
import 'package:jdr/models/user.dart';
import 'networking_service.dart';

const loginUrl = "http://localhost:3000/users/login";

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
        await _networkService.postData(url: loginUrl, postData: postData);
    if (result.containsKey('error')) {
      return AuthResult(
          status: AuthResultStatus.error, message: result['error']);
    } else if (result.containsKey('user')) {
      setCurrentUser(result['user']);
      return AuthResult(status: AuthResultStatus.success);
    }
    return null;
  }

  void setCurrentUser(dynamic userData) {
    _currentUser = User(
      id: userData['id'],
      firstName: userData['firstName'],
      lastName: userData['lastName'],
      email: userData['email'],
    );
  }

  User get currentUser => _currentUser;
}
