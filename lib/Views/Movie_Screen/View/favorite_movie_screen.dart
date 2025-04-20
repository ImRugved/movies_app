import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/Constants/colors.dart';
import 'package:movies_app/Views/Movie_Screen/widgets/movie_card.dart';
import '../Controllers/movie_controller.dart';

import '../../../Utils/routes.dart';

class FavoriteMovieScreen extends StatelessWidget {
  const FavoriteMovieScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.cardBackground,
        appBar: AppBar(
          title: Text('Favorite Movies'),
        ),
        body: GetBuilder<MovieController>(
          id: 'favorites_list',
          builder: (controller) {
            if (controller.favoriteMovies.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.favorite_border,
                      size: 80.sp,
                      color: Colors.grey,
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      'No favorite movies yet',
                      style: TextStyle(
                        fontSize: 18.sp,
                        color: Colors.grey[700],
                      ),
                    ),
                    SizedBox(height: 20.h),
                    ElevatedButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: Text('Go back to movies'),
                    ),
                  ],
                ),
              );
            }

            return ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 10.h),
              itemCount: controller.favoriteMovies.length,
              itemBuilder: (context, index) {
                final movie = controller.favoriteMovies[index];
                return MovieCard(
                  title: movie.originalTitle,
                  posterPath: movie.posterPath,
                  language: movie.originalLanguage,
                  overview: movie.overview,
                  releaseDate: movie.releaseDate,
                  isFavorite: true,
                  onTap: () {
                    Get.toNamed(
                      Routes.movieDetail,
                      arguments: movie,
                    );
                  },
                  onFavoriteTap: () {
                    controller.toggleFavorite(movie);
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
