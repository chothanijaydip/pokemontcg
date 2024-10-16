
import 'package:get/get.dart';

import '../controller/details_view_controller.dart';

class DetailsViewBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DetailsViewController());
  }
}