import 'package:get/get.dart';

import '../modules/sing_in/sing_in_binding.dart';
import '../modules/sing_in/sing_in_page.dart';

class SingInRoutes {
  SingInRoutes._();

  static const singIn = '/sing-in';

  static final routes = [
    GetPage(
      name: singIn,
      page: () => const SingInPage(),
      binding: SingInBinding(),
    ),
  ];
}
