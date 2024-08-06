import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:telechat/app/data/models/message_model.dart';
import 'package:telechat/app/data/models/users_model.dart';
import 'package:telechat/app/data/services/api_services.dart';

class MessageController extends GetxController {
  TextEditingController messageController = TextEditingController();
  var messages = <MessagesModel>[].obs;
  final user = UsersModel().obs;

  final _isLoading = false.obs;
  final isTyping = false.obs;
  final isSending = false.obs;

  getMessage() async {
    _isLoading.value = true;
    final response = await ApiServices.messages(user.value.id.toString());

    _isLoading.value = false;
    messages.value = messagesModelFromJson(response.body);

    update();
  }

  sendMessage() async {
    await ApiServices.sendMessages(
      user.value.id.toString(),
      messageController.text,
    ).then((value) {
      messageController.clear();
      isTyping.value = false;
    });

    update();
  }
}
