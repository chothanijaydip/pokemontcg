import 'package:get/get.dart';

import '../views/details_view/bindings/details_view_bindings.dart';
import '../views/details_view/ui/details_page.dart';
import '../views/home_view/bindings/home_view_bindings.dart';
import '../views/home_view/ui/home_page.dart';

part './app_routes.dart';

abstract class AppPages {
  static final pages = [
    GetPage(
      name: Routes.home,
      page: () => HomePage(),
      binding: HomeViewBindings(),
    ),
    GetPage(
      name: Routes.details,
      page: () => DetailsPage(),
      binding: DetailsViewBindings(),
    ),
  ];
}
