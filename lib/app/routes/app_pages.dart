import 'home_routes.dart';
import 'sing_in_routes.dart';
import 'sing_up_routes.dart';
import 'splash_routes.dart';
import 'message_routes.dart';


class AppPages {
  AppPages._();

  // ignore: constant_identifier_names
  static const INITIAL = '/';

  static final routes = [
    ...HomeRoutes.routes,
		...SingInRoutes.routes,
		...SingUpRoutes.routes,
		...SplashRoutes.routes,
		
		...MessageRoutes.routes,
  ];
}
