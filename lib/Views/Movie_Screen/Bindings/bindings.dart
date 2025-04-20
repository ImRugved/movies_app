import 'package:get/get.dart';
import '../Controllers/movie_controller.dart';

class MovieBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<MovieController>(MovieController());
  }
}
