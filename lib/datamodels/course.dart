class Course {
  int id;
  String title;
  String image;
  String description;
  String lessonCount;
  String authorName;
  String authorAvatar;

  Course.fromJson(jsonData) {
    id = jsonData['id'];
    title = jsonData['name'];
    image = jsonData['image'];
    description = jsonData['description'];
    lessonCount = jsonData['lessonCount'];
    authorName = jsonData['author']['name'];
    authorAvatar = jsonData['author']['avatar'];
  }
}
