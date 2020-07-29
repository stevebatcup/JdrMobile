import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class JdrVideoPlayer extends StatefulWidget {
  final String fileUrl;
  final String placeholderImgUrl;
  JdrVideoPlayer({this.fileUrl, this.placeholderImgUrl});

  @override
  _JdrVideoPlayerState createState() => _JdrVideoPlayerState();
}

class _JdrVideoPlayerState extends State<JdrVideoPlayer> {
  ChewieController _chewieController;
  VideoPlayerController _videoController;
  Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();

    _videoController = VideoPlayerController.network(widget.fileUrl);
    _initializeVideoPlayerFuture =
        _videoController.initialize().then((_) => setState(() {}));
  }

  void setupChewieController() {
    _chewieController = ChewieController(
      allowFullScreen: false,
      showControlsOnInitialize: false,
      videoPlayerController: _videoController,
      aspectRatio: 16 / 9,
      autoInitialize: true,
      autoPlay: false,
      looping: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initializeVideoPlayerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          setupChewieController();
          return Chewie(
            key: PageStorageKey(widget.fileUrl),
            controller: _chewieController,
          );
        } else {
          return Center(
              child: Container(
            padding: EdgeInsets.symmetric(vertical: 100.0),
            child: CircularProgressIndicator(),
          ));
        }
      },
    );
  }

  @override
  void dispose() {
    _videoController.dispose();
    if (_chewieController != null) _chewieController.dispose();
    super.dispose();
  }
}
