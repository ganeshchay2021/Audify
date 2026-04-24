class SongsModel {
  final int? id;
  final String? title;
  final String? artist;
  final num? duration;
  final DateTime? releaseDate;

  SongsModel({
    required this.id,
    required this.title,
    required this.artist,
    required this.duration,
    required this.releaseDate,
  });

  factory SongsModel.fromMap(Map<String, dynamic> map) {
    return SongsModel(
      id: map['id'],
      title: map['title'],
      artist: map['artist'],
      duration: map['duration'],
      releaseDate: map['releaseDate'] != null
          ? DateTime.parse(map['releaseDate'])
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'artist': artist,
      'duration': duration,
      'releaseDate': releaseDate?.toIso8601String(),
    };
  }

  @override
  String toString() {
    return 'SongsModel(id: $id, title: $title, artist: $artist)';
  }
}
