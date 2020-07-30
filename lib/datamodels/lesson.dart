import 'package:jdr/datamodels/downloadable.dart';
import 'package:jdr/datamodels/video.dart';

class Lesson {
  int id;
  String path;
  String title;
  String image;
  String authorName;
  String authorAvatar;

  String excerpt;
  String content;
  String publishedAt;
  String category;

  Video mainVideo;
  Future videoReady;

  List<dynamic> downloadables = [];

  Lesson.basicFromJson(jsonData) {
    id = jsonData['id'];
    title = jsonData['name'];
    path = jsonData['path'];
    image = jsonData['image'];
    authorName = jsonData['author']['name'];
    authorAvatar = jsonData['author']['avatar'];
  }

  factory Lesson.fullFromJson(jsonData) {
    Lesson lesson = Lesson.basicFromJson(jsonData);
    lesson.excerpt = jsonData['excerpt'];
    lesson.content = jsonData['content'];
    lesson.category = jsonData['category'];
    lesson.publishedAt = jsonData['published'];

    lesson.setupMainVideo(
        id: jsonData['video']['id'],
        url: jsonData['video']['url'],
        host: jsonData['video']['host']);

    if (jsonData['downloadables'].isNotEmpty)
      lesson.setupDownloadables(jsonData['downloadables']);

    return lesson;
  }

  void setupDownloadables(List<dynamic> data) {
    data.forEach((item) {
      Downloadable downloadable =
          Downloadable(name: item['name'], url: item['url']);
      downloadables.add(downloadable);
    });
  }

  void setupMainVideo({id, url, host}) {
    mainVideo = Video.fromJson(id: id, url: url, host: host);
    videoReady = Future(() async {
      await mainVideo.buildMp4File();
    });
  }
}
