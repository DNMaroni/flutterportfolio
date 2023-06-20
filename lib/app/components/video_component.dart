import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:path_provider/path_provider.dart';

class VideoComponent extends StatefulWidget {
  final String encodedBytes;

  const VideoComponent(this.encodedBytes, {Key? key}) : super(key: key);

  @override
  _VideoComponentState createState() => _VideoComponentState();
}

class _VideoComponentState extends State<VideoComponent> {
  late Future<VideoPlayerController> _futureController;
  late VideoPlayerController _controller;

  Future<File> _createFileFromString() async {
    Uint8List bytes = base64.decode(widget.encodedBytes);

    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path;
    File file = File("$path/${DateTime.now().millisecondsSinceEpoch}.pdf");
    await file.writeAsBytes(bytes);
    return file;
  }

  Future<VideoPlayerController> createVideoPlayer() async {
    final File file = await _createFileFromString();

    final VideoPlayerController controller = VideoPlayerController.file(file);
    await controller.initialize();
    await controller.setLooping(true);
    return controller;
  }

  @override
  void initState() {
    _futureController = createVideoPlayer();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FutureBuilder(
        future: _futureController,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            _controller = snapshot.data as VideoPlayerController;
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                ),
                const SizedBox(
                  height: 30,
                ),
                FloatingActionButton(
                  onPressed: () {
                    setState(() {
                      if (_controller.value.isPlaying) {
                        _controller.pause();
                      } else {
                        // If the video is paused, play it.
                        _controller.play();
                      }
                    });
                  },
                  backgroundColor: Colors.green[700],
                  child: Icon(
                    _controller.value.isPlaying
                        ? Icons.pause
                        : Icons.play_arrow,
                  ),
                )
              ],
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
