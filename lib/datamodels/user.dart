class User {
  int id;
  String firstName;
  String lastName;
  String email;

  User({this.id, this.firstName, this.lastName, this.email});

  User.fromJson(userData) {
    id = userData['id'];
    firstName = userData['firstName'];
    lastName = userData['lastName'];
    email = userData['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['email'] = this.email;
    return data;
  }

  String get fullName => '$firstName $lastName';
}
