import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:local_media_server/domain/entities/media.dart';
import 'package:video_player/video_player.dart';

class PlayPage extends StatelessWidget {
  const PlayPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Media media = GoRouterState.of(context).extra as Media;

    return Scaffold(body: SafeArea(child: _buildMediaPlayer(media)));
  }

  Widget _buildMediaPlayer(Media media) {
    String url = "http://192.168.0.118:8000/api/v1/medias/file/${media.id}";

    switch (media.type) {
      case MediaType.video:
        return VideoPlayer(url: url);
      case MediaType.audio:
        return Text('Audio Player for ${media.title}');
      case MediaType.photo:
        return Image.network(
          url,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) {
            return const Text('Error loading image');
          },
          width: double.infinity,
          height: double.infinity,
        );
      default:
        return const Text('Unsupported media type');
    }
  }
}

class VideoPlayer extends StatefulWidget {
  final String url;

  const VideoPlayer({required this.url, super.key});

  @override
  _VideoPlayerState createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  late VideoPlayerController videoPlayerController;

  ChewieController? chewieController;

  @override
  initState() {
    super.initState();
    videoPlayerController =
        VideoPlayerController.networkUrl(Uri.parse(widget.url))
          ..initialize().then((_) {
            setState(() {
              chewieController = ChewieController(
                videoPlayerController: videoPlayerController,
                autoPlay: true,
                looping: true,
                materialProgressColors: ChewieProgressColors(
                  playedColor: Colors.red,
                  handleColor: Colors.redAccent,
                  backgroundColor: Colors.grey,
                  bufferedColor: Colors.lightBlueAccent,
                ),
              );
            });
          });
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Placeholder for video player widget
    return Center(
      child: chewieController != null
          ? Chewie(controller: chewieController!)
          : const CircularProgressIndicator(),
    );
  }
}
