class FavouriteSongModel {
  FavouriteSongModel({required this.id, required this.songs});

  final int? id;
  final Songs? songs;

  factory FavouriteSongModel.fromJson(Map<String, dynamic> json) {
    return FavouriteSongModel(
      id: json["id"],
      songs: json["Songs"] == null ? null : Songs.fromJson(json["Songs"]),
    );
  }
}

class Songs {
  Songs({
    required this.id,
    required this.title,
    required this.duration,
    required this.releaseDate,
    required this.artist,
  });

  final int? id;
  final String? title;
  final double? duration;
  final DateTime? releaseDate;
  final String? artist;

  factory Songs.fromJson(Map<String, dynamic> json) {
    return Songs(
      id: json["id"],
      title: json["title"],
      duration: json["duration"],
      releaseDate: DateTime.tryParse(json["releaseDate"] ?? ""),
      artist: json["artist"],
    );
  }


 

  
}
