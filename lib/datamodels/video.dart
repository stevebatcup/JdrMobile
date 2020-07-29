import 'dart:collection';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Video {
  int id;
  String url;
  String host;

  Video.fromJson({this.id, this.url, this.host});

  String _mp4File;
  String get mp4File => _mp4File;

  Future<void> buildMp4File() async {
    SplayTreeMap<dynamic, dynamic> links =
        await VimeoFileLinks(id.toString()).getLinks();
    _mp4File = links[links.lastKey()];
  }
}

class VimeoFileLinks {
  String videoId;

  VimeoFileLinks(this.videoId);

  Future<SplayTreeMap> getLinks() async {
    try {
      var response = await http
          .get('https://player.vimeo.com/video/' + videoId + '/config');
      var jsonData =
          jsonDecode(response.body)['request']['files']['progressive'];
      SplayTreeMap videoList = SplayTreeMap.fromIterable(jsonData,
          key: (item) => "${item['quality']} ${item['fps']}",
          value: (item) => item['url']);
      return videoList;
    } catch (error) {
      print('=====> REQUEST ERROR: $error');
      return null;
    }
  }
}
