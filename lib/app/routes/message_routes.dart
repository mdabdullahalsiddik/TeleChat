import 'package:get/get.dart';

import '../modules/message/message_binding.dart';
import '../modules/message/message_page.dart';

class MessageRoutes {
  MessageRoutes._();

  static const message = '/message/message';

  static final routes = [
    GetPage(
      name: message,
      page: () => const MessagePage(),
      binding: MessageBinding(),
    ),
  ];
}
