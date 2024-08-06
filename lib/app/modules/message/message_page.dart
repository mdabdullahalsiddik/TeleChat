import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:telechat/utils/static/all_colors.dart';

import 'message_controller.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({super.key});

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  final controller = Get.put(MessageController());
  // ignore: annotate_overrides
  initState() {
    super.initState();
    controller.getMessage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AllColors.primaryColor,
      appBar: AppBar(
        backgroundColor: AllColors.primaryColor,
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.only(top: 6),
          child: Row(children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Image.network(
                controller.user.value.profileImage!,
                width: 45,
                height: 45,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    controller.user.value.name!,
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Obx(() => Text(
                        controller.isTyping.value == true
                            ? "Typing..."
                            : "Online",
                        style: const TextStyle(
                          fontSize: 12,
                        ),
                      )),
                ],
              ),
            ),
          ]),
        ),
        centerTitle: true,
        actions: const [
          Padding(
            padding: EdgeInsets.only(top: 10, right: 20),
            child: Icon(
              Icons.videocam_outlined,
              size: 20,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10, right: 20),
            child: Icon(
              Icons.call_outlined,
              size: 20,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10, right: 10),
            child: Icon(
              Icons.more_vert,
              size: 20,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Obx(
                    () => ListView.builder(
                      shrinkWrap: true,
                      primary: false,
                      itemCount: controller.messages.length,
                      itemBuilder: (context, index) {
                        final message = controller.messages[index];
                        return Align(
                          alignment: message.isMe == true
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          child: Text(
                            message.message ?? "",
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.07,
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Row(
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        controller.isTyping.value = value.isNotEmpty;
                      },
                      controller: controller.messageController,
                      keyboardType: TextInputType.text,
                      maxLines: 5,
                      minLines: 1,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Message",
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () => controller.sendMessage(),
                    child: Obx(
                      () => controller.isTyping.value == false
                          ? const SizedBox()
                          : Icon(
                              Icons.send,
                              color: AllColors.primaryColor,
                            ),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
