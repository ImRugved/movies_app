import 'package:get/get.dart';
import '../Views/Splash_Screen/splash_screen.dart';
import '../Views/Movie_Screen/View/movie_list_screen.dart';
import '../Views/Movie_Screen/View/movie_detail_screen.dart';
import '../Views/Movie_Screen/View/favorite_movie_screen.dart';
import '../Views/Movie_Screen/Bindings/bindings.dart';

class Routes {
  static const String splash = '/';
  static const String movieList = '/movie-list';
  static const String movieDetail = '/movie-detail';
  static const String favoriteMovies = '/favorite-movies';

  static final List<GetPage> pages = [
    GetPage(
      name: splash,
      page: () => const SplashScreen(),
      binding: MovieBinding(),
    ),
    GetPage(
      name: movieList,
      page: () => const MovieListScreen(),
      binding: MovieBinding(),
    ),
    GetPage(
      name: movieDetail,
      page: () => const MovieDetailScreen(),
      binding: MovieBinding(),
    ),
    GetPage(
      name: favoriteMovies,
      page: () => const FavoriteMovieScreen(),
      binding: MovieBinding(),
    ),
  ];
}
