class Course {
  int id;
  String title;
  String image;
  String authorName;
  String authorAvatar;

  Course.fromJson(jsonData) {
    id = jsonData['id'];
    title = jsonData['name'];
    image = jsonData['image'];
    authorName = jsonData['author']['name'];
    authorAvatar = jsonData['author']['avatar'];
  }
}
