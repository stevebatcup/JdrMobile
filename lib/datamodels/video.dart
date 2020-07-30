import 'dart:collection';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Video {
  int id;
  String url;
  String host;

  Video.fromJson({this.id, this.url, this.host});

  String _fileUrl;
  String get fileUrl => _fileUrl;

  Future<void> buildMp4File() async {
    if (host == 'vimeo') {
      SplayTreeMap<dynamic, dynamic> links =
          await VimeoFileLinks(id.toString()).getLinks();
      _fileUrl = links[links.lastKey()];
    } else if (host == 'youtube') {
      _fileUrl = url;
    } else if (host == 's3') {
      _fileUrl = url;
    }
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
