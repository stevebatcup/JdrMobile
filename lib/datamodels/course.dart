import 'lesson.dart';

class Course {
  int id;
  String title;
  String path;
  String image;
  String publishedAt;
  String description;
  String authorName;
  String authorAvatar;
  List<dynamic> skillLevels;
  String lessonCount;
  List<Lesson> lessons;

  Course.fromJson(jsonData) {
    id = jsonData['id'];
    title = jsonData['name'];
    path = jsonData['path'];
    image = jsonData['image'];
    publishedAt = jsonData['published'];
    description = jsonData['description'];
    lessonCount = jsonData['lessonCount'];
    authorName = jsonData['author']['name'];
    authorAvatar = jsonData['author']['avatar'];

    if (jsonData.containsKey('skillLevels'))
      skillLevels =
          jsonData['skillLevels'].map((level) => level["name"]).toList();

    if (jsonData.containsKey('lessons'))
      lessons = jsonData['lessons']
          .map<Lesson>((lessonData) => Lesson.basicFromJson(lessonData))
          .toList();
  }

  String skillLevelList() {
    return skillLevels.join(", ");
  }
}
