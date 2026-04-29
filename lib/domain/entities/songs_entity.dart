class SongsEntity {
  final String id;
  final String title;
  final String artist;
  final num duration;
  final DateTime releaseDate;

  SongsEntity({
    required this.title,
    required this.id,
    required this.artist,
    required this.duration,
    required this.releaseDate,
  });
}
