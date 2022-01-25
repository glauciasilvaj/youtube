import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoView extends StatefulWidget {
  const VideoView(this.videoID, {Key? key}) : super(key: key);
  final String videoID;

  @override
  _VideoViewState createState() => _VideoViewState();
}

class _VideoViewState extends State<VideoView> {
  late final YoutubePlayerController _controller = YoutubePlayerController(
    initialVideoId: widget.videoID,
    flags: const YoutubePlayerFlags(
      autoPlay: true,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: YoutubePlayerBuilder(
          player: YoutubePlayer(
            controller: _controller,
          ),
          builder: (context, player) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // some widgets
                player,
                //some other widgets
              ],
            );
          }),
    );
  }
}