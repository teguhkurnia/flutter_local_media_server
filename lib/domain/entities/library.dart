import 'package:equatable/equatable.dart';
import 'package:local_media_server/domain/entities/media.dart';

class Library extends Equatable {
  const Library({required this.id, required this.name, required this.medias});

  final String id;
  final String name;
  final List<Media> medias;

  factory Library.fromJson(Map<String, dynamic> json) {
    return Library(
      id: json["id"],
      name: json["name"],
      medias:
          json["medias"] == null
              ? []
              : List<Media>.from(json["medias"]!.map((x) => Media.fromJson(x))),
    );
  }

  @override
  List<Object?> get props => [id, name, medias];
}
