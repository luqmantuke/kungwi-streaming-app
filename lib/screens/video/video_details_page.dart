import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:kungwi/models/videos/videos_model.dart';

import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:video_player/video_player.dart';
import 'package:go_router/go_router.dart';

class VideoDetailsPage extends StatefulWidget {
  final VideosModelData videoData;
  const VideoDetailsPage({
    super.key,
    required this.videoData,
  });

  // final VideosModelData video;

  @override
  State<StatefulWidget> createState() {
    return _VideoDetailsPageState();
  }
}

class _VideoDetailsPageState extends State<VideoDetailsPage> {
  late VideoPlayerController _videoPlayerController1;

  ChewieController? _chewieController;
  int? bufferDelay;
  bool loaded = false;
  @override
  void initState() {
    super.initState();
    initializePlayer();
  }

  @override
  void dispose() {
    _videoPlayerController1.dispose();

    _chewieController?.dispose();
    super.dispose();
  }

  Future<void> initializePlayer() async {
    _videoPlayerController1 = VideoPlayerController.networkUrl(
        Uri.parse(widget.videoData.videoUrl.toString()));

    await Future.wait([
      _videoPlayerController1.initialize().then((value) => setState(() {
            loaded = true;
          })),
    ]);
    _createChewieController();
    setState(() {
      loaded = true;
    });
  }

  void _createChewieController() {
    _chewieController = ChewieController(
      materialProgressColors: ChewieProgressColors(
          // bufferedColor: kgrey04,
          // playedColor: kTextColor,
          ),
      cupertinoProgressColors: ChewieProgressColors(
          // bufferedColor: kgrey04,
          // playedColor: kTextColor,
          ),
      videoPlayerController: _videoPlayerController1,
      autoPlay: true,
      looping: true,
      progressIndicatorDelay:
          bufferDelay != null ? Duration(milliseconds: bufferDelay!) : null,
      subtitleBuilder: (context, dynamic subtitle) => Container(
        padding: const EdgeInsets.all(10.0),
        child: subtitle is InlineSpan
            ? RichText(
                text: subtitle,
              )
            : Text(
                subtitle.toString(),
                style: const TextStyle(color: Colors.black),
              ),
      ),
      hideControlsTimer: const Duration(seconds: 1),
    );
  }

  int currPlayIndex = 0;

  Future<void> toggleVideo() async {
    await _videoPlayerController1.pause();
    currPlayIndex += 1;

    await initializePlayer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(80.0),
            child: Container(
              padding: EdgeInsets.only(
                left: 0.h,
                right: 0.h,
              ),
              width: 86.w,
              child: AppBar(
                leading: InkWell(
                  onTap: () {
                    context.pop();
                  },
                  child: const Icon(
                    Icons.arrow_back_ios_new,
                    // color: kTextColor,
                  ),
                ),
                elevation: 0,
                backgroundColor: Colors.transparent,
              ),
            )),
        body: VideoPlayer(
          chewieController: _chewieController,
        ));
  }
}

class VideoPlayer extends StatelessWidget {
  const VideoPlayer({
    super.key,
    required ChewieController? chewieController,
  }) : _chewieController = chewieController;

  final ChewieController? _chewieController;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: _chewieController != null &&
              _chewieController!.videoPlayerController.value.isInitialized
          ? Padding(
              padding: const EdgeInsets.symmetric(vertical: 24.0),
              child: Chewie(
                controller: _chewieController!,
              ),
            )
          : const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(
                    // color: kTextColor,
                    ),
                SizedBox(height: 20),
                Text(
                  'Loading',
                  // style: TextStyle(color: kTextColor),
                ),
              ],
            ),
    );
  }
}
