import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
import '../Models/movies_list_model.dart';
import '../Controllers/movie_controller.dart';

import '../../../Constants/colors.dart';

class MovieDetailScreen extends StatelessWidget {
  const MovieDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MoviesListModel movie = Get.arguments;
    final controller = Get.find<MovieController>();

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.cardBackground,
        appBar: AppBar(
          backgroundColor: AppColors.primaryDark,
          foregroundColor: AppColors.textLight,
          title: Text(
            movie.originalTitle ?? 'Movie Details',
            style: TextStyle(color: AppColors.textLight),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Get.back(),
          ),
          actions: [
            GetBuilder<MovieController>(
              id: 'movies_list',
              builder: (_) {
                return IconButton(
                  icon: Icon(
                    controller.isFavorite(movie.id)
                        ? Icons.favorite
                        : Icons.favorite_border,
                    color: controller.isFavorite(movie.id)
                        ? AppColors.accentRed
                        : AppColors.textLight,
                  ),
                  onPressed: () {
                    controller.toggleFavorite(movie);
                  },
                );
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Hero image with gradient overlay
              Stack(
                children: [
                  Hero(
                    tag: 'movie-${movie.originalTitle ?? ""}',
                    child: CachedNetworkImage(
                      imageUrl: movie.posterPath ??
                          'https://via.placeholder.com/500x750?text=No+Image',
                      height: 350.h,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      placeholder: (context, url) =>
                          _buildShimmerEffect(height: 350.h),
                      errorWidget: (context, url, error) => Container(
                        height: 350.h,
                        color: Colors.grey[300],
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.broken_image,
                                  size: 50.sp, color: Colors.grey[700]),
                              SizedBox(height: 8.h),
                              Text(
                                'Image not available',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Colors.grey[700],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Gradient overlay for better visibility
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.8),
                          ],
                          stops: const [0.6, 1.0],
                        ),
                      ),
                    ),
                  ),

                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Padding(
                      padding: EdgeInsets.all(16.r),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            movie.originalTitle ?? 'No Title',
                            style: TextStyle(
                              color: AppColors.textLight,
                              fontSize: 24.sp,
                              fontWeight: FontWeight.bold,
                              shadows: [
                                Shadow(
                                  blurRadius: 2.0,
                                  color: Colors.black,
                                  offset: Offset(0, 1),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Row(
                            children: [
                              Icon(
                                Icons.language,
                                size: 16.sp,
                                color: AppColors.textLight,
                              ),
                              SizedBox(width: 4.w),
                              Text(
                                movie.originalLanguage?.toUpperCase() ??
                                    'UNKNOWN',
                                style: TextStyle(
                                  color: AppColors.textLight,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(width: 16.w),
                              Icon(
                                Icons.star,
                                size: 16.sp,
                                color: AppColors.ratingAmber,
                              ),
                              SizedBox(width: 4.w),
                              Text(
                                '${movie.voteAverage ?? 0.0}',
                                style: TextStyle(
                                  color: AppColors.textLight,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              Padding(
                padding: EdgeInsets.all(16.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Info cards
                    Container(
                      margin: EdgeInsets.only(bottom: 24.h),
                      padding: EdgeInsets.all(16.r),
                      decoration: BoxDecoration(
                        color: AppColors.cardBackground,
                        borderRadius: BorderRadius.circular(12.r),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.shadowColorLight,
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              _buildInfoItem(
                                icon: Icons.calendar_today,
                                label: 'Release',
                                value: movie.releaseDate ?? 'Unknown',
                              ),
                              _buildInfoItem(
                                icon: Icons.thumb_up_alt,
                                label: 'Votes',
                                value: '${movie.voteCount ?? 0}',
                              ),
                              _buildInfoItem(
                                icon: Icons.trending_up,
                                label: 'Popularity',
                                value:
                                    '${movie.popularity?.toStringAsFixed(1) ?? 0.0}',
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // Overview section
                    Text(
                      'Overview',
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Container(
                      padding: EdgeInsets.all(16.r),
                      decoration: BoxDecoration(
                        color: AppColors.cardBackground,
                        borderRadius: BorderRadius.circular(12.r),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.shadowColorLight,
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Text(
                        movie.overview ?? 'No overview available',
                        style: TextStyle(
                          fontSize: 16.sp,
                          height: 1.5,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                    SizedBox(height: 24.h),

                    // Cast section
                    if (movie.casts != null && movie.casts!.isNotEmpty) ...[
                      Text(
                        'Cast',
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textDark,
                        ),
                      ),
                      SizedBox(height: 16.h),
                      SizedBox(
                        height: 180.h,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: movie.casts!.length,
                          itemBuilder: (context, index) {
                            final cast = movie.casts![index];
                            return _buildCastItem(cast);
                          },
                        ),
                      ),
                      SizedBox(height: 16.h),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoItem({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Column(
      children: [
        Icon(
          icon,
          color: AppColors.primaryBlue,
          size: 24.sp,
        ),
        SizedBox(height: 8.h),
        Text(
          label,
          style: TextStyle(
            fontSize: 12.sp,
            color: AppColors.textSecondary,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          value,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.textDark,
          ),
        ),
      ],
    );
  }

  Widget _buildCastItem(Cast cast) {
    return Container(
      width: 120.w,
      margin: EdgeInsets.only(right: 16.w),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowColorLight,
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12.r),
              topRight: Radius.circular(12.r),
            ),
            child: CachedNetworkImage(
              imageUrl: cast.profilePath ??
                  'https://via.placeholder.com/200x300?text=No+Image',
              height: 120.h,
              width: 120.w,
              fit: BoxFit.cover,
              placeholder: (context, url) =>
                  _buildShimmerEffect(height: 120.h, width: 120.w),
              errorWidget: (context, url, error) => Container(
                height: 120.h,
                width: 120.w,
                color: AppColors.grey.withOpacity(0.2),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.person,
                          size: 40.sp, color: AppColors.grey.withOpacity(0.7)),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cast.name ?? 'Unknown',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textDark,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 2.h),
                Text(
                  cast.character ?? 'Unknown role',
                  style: TextStyle(
                    fontSize: 10.sp,
                    color: AppColors.textSecondary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShimmerEffect({required double height, double? width}) {
    return Shimmer.fromColors(
      baseColor: AppColors.shimmerBase,
      highlightColor: AppColors.shimmerHighlight,
      period: const Duration(milliseconds: 1500),
      child: Container(
        height: height,
        width: width ?? double.infinity,
        color: AppColors.cardBackground,
      ),
    );
  }
}
