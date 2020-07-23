class User {
  int id;
  String firstName;
  String lastName;
  String email;

  User.fromJson(userData) {
    id = userData['id'];
    firstName = userData['firstName'];
    lastName = userData['lastName'];
    email = userData['email'];
  }
}
