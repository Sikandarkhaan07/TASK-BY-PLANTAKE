// ignore_for_file: unnecessary_getters_setters

class MovieListModel {
  List<Movies>? _movies;

  MovieListModel({List<Movies>? movies}) {
    if (movies != null) {
      _movies = movies;
    }
  }

  List<Movies>? get movies => _movies;
  set movies(List<Movies>? movies) => _movies = movies;

  MovieListModel.fromJson(Map<String, dynamic> json) {
    if (json['movies'] != null) {
      _movies = <Movies>[];
      json['movies'].forEach((v) {
        _movies!.add(Movies.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (_movies != null) {
      data['movies'] = _movies!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Movies {
  String? _id;
  String? _title;
  String? _year;
  List<String>? _genres;
  List<int>? _ratings;
  String? _poster;
  dynamic _contentRating;
  String? _duration;
  String? _releaseDate;
  int? _averageRating;
  String? _originalTitle;
  String? _storyline;
  List<String>? _actors;
  dynamic _imdbRating;
  String? _posterurl;

  Movies(
      {String? id,
      String? title,
      String? year,
      List<String>? genres,
      List<int>? ratings,
      String? poster,
      dynamic contentRating,
      String? duration,
      String? releaseDate,
      int? averageRating,
      String? originalTitle,
      String? storyline,
      List<String>? actors,
      dynamic imdbRating,
      String? posterurl}) {
    if (id != null) {
      _id = id;
    }
    if (title != null) {
      _title = title;
    }
    if (year != null) {
      _year = year;
    }
    if (genres != null) {
      _genres = genres;
    }
    if (ratings != null) {
      _ratings = ratings;
    }
    if (poster != null) {
      _poster = poster;
    }
    if (contentRating != null) {
      _contentRating = contentRating;
    }
    if (duration != null) {
      _duration = duration;
    }
    if (releaseDate != null) {
      _releaseDate = releaseDate;
    }
    if (averageRating != null) {
      _averageRating = averageRating;
    }
    if (originalTitle != null) {
      _originalTitle = originalTitle;
    }
    if (storyline != null) {
      _storyline = storyline;
    }
    if (actors != null) {
      _actors = actors;
    }
    if (imdbRating != null) {
      _imdbRating = imdbRating;
    }
    if (posterurl != null) {
      _posterurl = posterurl;
    }
  }

  String? get id => _id;
  set id(String? id) => _id = id;
  String? get title => _title;
  set title(String? title) => _title = title;
  String? get year => _year;
  set year(String? year) => _year = year;
  List<String>? get genres => _genres;
  set genres(List<String>? genres) => _genres = genres;
  List<int>? get ratings => _ratings;
  set ratings(List<int>? ratings) => _ratings = ratings;
  String? get poster => _poster;
  set poster(String? poster) => _poster = poster;
  String? get contentRating => _contentRating;
  set contentRating(String? contentRating) => _contentRating = contentRating;
  String? get duration => _duration;
  set duration(String? duration) => _duration = duration;
  String? get releaseDate => _releaseDate;
  set releaseDate(String? releaseDate) => _releaseDate = releaseDate;
  int? get averageRating => _averageRating;
  set averageRating(int? averageRating) => _averageRating = averageRating;
  String? get originalTitle => _originalTitle;
  set originalTitle(String? originalTitle) => _originalTitle = originalTitle;
  String? get storyline => _storyline;
  set storyline(String? storyline) => _storyline = storyline;
  List<String>? get actors => _actors;
  set actors(List<String>? actors) => _actors = actors;
  String? get imdbRating => _imdbRating;
  set imdbRating(String? imdbRating) => _imdbRating = imdbRating;
  String? get posterurl => _posterurl;
  set posterurl(String? posterurl) => _posterurl = posterurl;

  Movies.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _title = json['title'];
    _year = json['year'];
    _genres = json['genres'].cast<String>();
    _ratings = json['ratings'].cast<int>();
    _poster = json['poster'];
    _contentRating = json['contentRating'];
    _duration = json['duration'];
    _releaseDate = json['releaseDate'];
    _averageRating = json['averageRating'];
    _originalTitle = json['originalTitle'];
    _storyline = json['storyline'];
    _actors = json['actors'].cast<String>();
    _imdbRating = json['imdbRating'];
    _posterurl = json['posterurl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = _id;
    data['title'] = _title;
    data['year'] = _year;
    data['genres'] = _genres;
    data['ratings'] = _ratings;
    data['poster'] = _poster;
    data['contentRating'] = _contentRating;
    data['duration'] = _duration;
    data['releaseDate'] = _releaseDate;
    data['averageRating'] = _averageRating;
    data['originalTitle'] = _originalTitle;
    data['storyline'] = _storyline;
    data['actors'] = _actors;
    data['imdbRating'] = _imdbRating;
    data['posterurl'] = _posterurl;
    return data;
  }
}
