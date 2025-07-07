import 'package:equatable/equatable.dart';

enum MediaType { audio, video, photo }

class Media extends Equatable {
  const Media({
    required this.id,
    required this.title,
    required this.filepath,
    required this.type,
    required this.duration,
    required this.fileSize,
    required this.thumbnailUrl,
    required this.aspectRatio,
  });

  final String id;
  final String title;
  final String filepath;
  final MediaType type;
  final double duration;
  final int fileSize;
  final String? thumbnailUrl;
  final double aspectRatio;

  factory Media.fromJson(Map<String, dynamic> json) {
    return Media(
      id: json["id"],
      title: json["title"],
      filepath: json["filepath"],
      type: MediaType.values.firstWhere(
        (e) => e.toString() == 'MediaType.${json["type"]}',
        orElse: () => MediaType.photo,
      ),
      duration: json["duration"]?.toDouble() ?? 0.0,
      fileSize: json["file_size"],
      thumbnailUrl: json["thumbnail_url"],
      aspectRatio: json["aspect_ratio"]?.toDouble() ?? 1.0,
    );
  }

  @override
  List<Object?> get props => [
    id,
    title,
    filepath,
    type,
    duration,
    fileSize,
    thumbnailUrl,
  ];
}
