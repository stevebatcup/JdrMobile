class Lesson {
  int id;
  String title;
  String image;
  String authorName;
  String authorAvatar;

  Lesson.fromJson(jsonData) {
    id = jsonData['id'];
    title = jsonData['name'];
    image = jsonData['image'];
    authorName = jsonData['author']['name'];
    authorAvatar = jsonData['author']['avatar'];
  }
}
