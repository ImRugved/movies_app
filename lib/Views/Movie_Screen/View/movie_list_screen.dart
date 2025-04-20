import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/Constants/colors.dart';
import 'package:movies_app/Views/Movie_Screen/widgets/custom_error_widget.dart';
import 'package:movies_app/Views/Movie_Screen/widgets/loading_widget.dart';
import 'package:movies_app/Views/Movie_Screen/widgets/movie_card.dart';
import '../Controllers/movie_controller.dart';

import '../../../Utils/routes.dart';

class MovieListScreen extends StatefulWidget {
  const MovieListScreen({Key? key}) : super(key: key);

  @override
  State<MovieListScreen> createState() => _MovieListScreenState();
}

class _MovieListScreenState extends State<MovieListScreen>
    with WidgetsBindingObserver {
  late MovieController _controller;

  @override
  void initState() {
    super.initState();
    _controller = Get.find<MovieController>();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _controller.fetchMovies();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.cardBackground,
        appBar: AppBar(
          title: Text('Movies'),
          actions: [
            IconButton(
              icon: Icon(Icons.favorite),
              onPressed: () {
                Get.toNamed(Routes.favoriteMovies);
              },
            ),
          ],
        ),
        body: GetBuilder<MovieController>(
          id: 'movies_list',
          builder: (controller) {
            if (controller.isLoading && controller.moviesList.isEmpty) {
              return const LoadingWidget();
            }

            if (controller.hasError && controller.moviesList.isEmpty) {
              return CustomErrorWidget(
                errorMessage: controller.errorMessage,
                onRetry: () => controller.fetchMovies(),
              );
            }
            log("mobie list length: ${controller.moviesList.length}");
            return RefreshIndicator(
              onRefresh: controller.fetchMovies,
              child: controller.moviesList.isEmpty
                  ? Center(
                      child: Text(
                        'No movies found',
                        style: TextStyle(
                          fontSize: 18.sp,
                          color: Colors.grey[700],
                        ),
                      ),
                    )
                  : ListView.builder(
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: controller.moviesList.length,
                      itemBuilder: (context, index) {
                        final movie = controller.moviesList[index];
                        return MovieCard(
                          title: movie.originalTitle,
                          posterPath: movie.posterPath,
                          language: movie.originalLanguage,
                          overview: movie.overview,
                          releaseDate: movie.releaseDate,
                          isFavorite: controller.isFavorite(movie.id),
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
                    ),
            );
          },
        ),
      ),
    );
  }
}
