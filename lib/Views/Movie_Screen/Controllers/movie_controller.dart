import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'dart:developer';
import 'package:flutter/material.dart';
import '../Models/movies_list_model.dart';
import '../../../Utils/api.dart';
import '../../../Constants/global.dart';
import '../../../Constants/colors.dart';

class MovieController extends GetxController {
  static MovieController get to => Get.find();

  List<MoviesListModel> moviesList = [];
  List<MoviesListModel> favoriteMovies = [];
  bool isLoading = false;
  bool hasError = false;
  String errorMessage = '';

  @override
  void onInit() {
    super.onInit();
    fetchMovies();
  }

  Future<void> fetchMovies() async {
    try {
      isLoading = true;
      update(['movies_list']);

      final API api = API();
      final response = await api.sendRequest.get(Global.movieEndpoint);

      if (response.statusCode == 200) {
        final responseData = response.data;

        if (responseData != null) {
          List<dynamic> data = responseData is List
              ? responseData
              : (responseData is Map && responseData['data'] is List)
                  ? responseData['data']
                  : throw Exception('Unexpected API response format');

          moviesList =
              data.map((movie) => MoviesListModel.fromJson(movie)).toList();
          hasError = false;
          errorMessage = '';
          log('Loaded ${moviesList.length} ');
        } else {
          throw Exception('The server returned an empty response');
        }
      } else {
        throw Exception('Server error code: ${response.statusCode}');
      }
    } on DioException catch (e) {
      hasError = true;
      errorMessage = _handleDioException(e);
      log('Network error: ${e.message}', error: e);
    } catch (e) {
      hasError = true;
      errorMessage = 'Unable to load movies. Please try again later.';
      log('Error in fetchmovies: $e');
    } finally {
      isLoading = false;
      update(['movies_list']);
    }
  }

  String _handleDioException(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
        return 'Connection timed out. Please check your internet connection.';
      case DioExceptionType.badResponse:
        return 'Server error: ${e.response?.statusCode}. Please try again later.';
      case DioExceptionType.connectionError:
        return 'No internet connection. Please check your network.';
      default:
        return 'Network error. Please try again.';
    }
  }

  void toggleFavorite(MoviesListModel movie) {
    final index = favoriteMovies.indexWhere((m) => m.id == movie.id);

    if (index >= 0) {
      favoriteMovies.removeAt(index);
      Get.snackbar(
        'Removed from Favorites',
        '${movie.originalTitle} has been removed from your favorites',
        backgroundColor: AppColors.primaryDark,
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(10),
      );
    } else {
      favoriteMovies.add(movie);
      Get.snackbar(
        'Added to Favorites',
        '${movie.originalTitle} has been added to your favorites',
        backgroundColor: AppColors.primaryDark,
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(10),
      );
    }

    update(['movies_list', 'favorites_list']);
  }

  bool isFavorite(String? id) {
    return favoriteMovies.any((movie) => movie.id == id);
  }
}
