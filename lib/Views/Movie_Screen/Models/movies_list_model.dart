import 'dart:convert';

MoviesListModel moviesListModelFromJson(String str) =>
    MoviesListModel.fromJson(json.decode(str));

String moviesListModelToJson(MoviesListModel data) =>
    json.encode(data.toJson());

class MoviesListModel {
  String? id;
  int? movieId;
  String? originalTitle;
  String? originalLanguage;
  String? overview;
  double? popularity;
  String? posterPath;
  String? backdropPath;
  String? releaseDate;
  double? voteAverage;
  int? voteCount;
  int? adult;
  dynamic createdAt;
  dynamic updatedAt;
  List<Cast>? casts;

  MoviesListModel({
    this.id,
    this.movieId,
    this.originalTitle,
    this.originalLanguage,
    this.overview,
    this.popularity,
    this.posterPath,
    this.backdropPath,
    this.releaseDate,
    this.voteAverage,
    this.voteCount,
    this.adult,
    this.createdAt,
    this.updatedAt,
    this.casts,
  });

  factory MoviesListModel.fromJson(Map<String, dynamic> json) =>
      MoviesListModel(
        id: json["id"],
        movieId: json["movie_id"],
        originalTitle: json["original_title"],
        originalLanguage: json["original_language"],
        overview: json["overview"],
        popularity: json["popularity"]?.toDouble(),
        posterPath: json["poster_path"],
        backdropPath: json["backdrop_path"],
        releaseDate: json["release_date"],
        voteAverage: json["vote_average"]?.toDouble(),
        voteCount: json["vote_count"],
        adult: json["adult"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        casts: json["casts"] == null
            ? []
            : List<Cast>.from(json["casts"]!.map((x) => Cast.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "movie_id": movieId,
        "original_title": originalTitle,
        "original_language": originalLanguage,
        "overview": overview,
        "popularity": popularity,
        "poster_path": posterPath,
        "backdrop_path": backdropPath,
        "release_date": releaseDate,
        "vote_average": voteAverage,
        "vote_count": voteCount,
        "adult": adult,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "casts": casts == null
            ? []
            : List<dynamic>.from(casts!.map((x) => x.toJson())),
      };
}

class Cast {
  String? id;
  int? movieId;
  String? name;
  String? originalName;
  String? popularity;
  String? profilePath;
  String? character;
  dynamic createdAt;
  dynamic updatedAt;

  Cast({
    this.id,
    this.movieId,
    this.name,
    this.originalName,
    this.popularity,
    this.profilePath,
    this.character,
    this.createdAt,
    this.updatedAt,
  });

  factory Cast.fromJson(Map<String, dynamic> json) => Cast(
        id: json["id"],
        movieId: json["movie_id"],
        name: json["name"],
        originalName: json["original_name"],
        popularity: json["popularity"],
        profilePath: json["profile_path"],
        character: json["character"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "movie_id": movieId,
        "name": name,
        "original_name": originalName,
        "popularity": popularity,
        "profile_path": profilePath,
        "character": character,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
