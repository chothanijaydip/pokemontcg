
import 'package:get/get.dart';

import '../controller/home_view_controller.dart';

class HomeViewBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeViewController());
  }
}