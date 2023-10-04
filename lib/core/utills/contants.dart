class AppConstants {
  static const String baseUrl = 'https://api.themoviedb.org/3';
  static const String apiKey = '82132bd0012c450df2739473cb720af4';
  static const String nowPlayingPath =
      '$baseUrl/movie/now_playing?api_key=$apiKey';
  static const String popularMoviesPath =
      'https://api.themoviedb.org/3/movie/popular?api_key=82132bd0012c450df2739473cb720af4';

  static const String topRatedMoviesPath =
      'https://api.themoviedb.org/3/movie/top_rated?api_key=82132bd0012c450df2739473cb720af4';

  static String movieDetailsPath(int movieId) =>
      'https://api.themoviedb.org/3/movie/$movieId?api_key=82132bd0012c450df2739473cb720af4';
  static String recommendationMoviesPath(int movieId) =>
      'https://api.themoviedb.org/3/movie/$movieId/recommendations?api_key=82132bd0012c450df2739473cb720af4';

  static const String baseImagePath = 'https://image.tmdb.org/t/p/w500';

  static String imageUrl(String path) => '$baseImagePath$path';
}
