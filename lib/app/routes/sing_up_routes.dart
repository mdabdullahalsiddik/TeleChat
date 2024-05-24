import 'package:get/get.dart';

import '../modules/sing_up/sing_up_binding.dart';
import '../modules/sing_up/sing_up_page.dart';

class SingUpRoutes {
  SingUpRoutes._();

  static const singUp = '/sing-up';

  static final routes = [
    GetPage(
      name: singUp,
      page: () => const SingUpPage(),
      binding: SingUpBinding(),
    ),
  ];
}
