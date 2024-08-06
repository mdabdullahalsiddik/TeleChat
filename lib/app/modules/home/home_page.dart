import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:telechat/app/modules/message/message_controller.dart';
import 'package:telechat/app/routes/message_routes.dart';

import 'package:telechat/app/modules/home/home_controller.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final messageController = Get.put(MessageController());
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chats'),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {
              controller.logout();
            },
            icon: const Icon(Icons.logout_outlined),
          ),
        ],
      ),
      body: Column(
        children: [
          // Padding(
          //   padding: const EdgeInsets.symmetric(
          //     horizontal: 10,
          //     vertical: 10,
          //   ),
          //   child: CupertinoSearchTextField(
          //     onChanged: (value) {
          //     },
          //   ),
          // ),
          Obx(
            () => controller.users.isEmpty
                ? ListView.builder(
                    
                    itemBuilder: (context, index) {
                      return Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: ListTile(
                          leading: const CircleAvatar(),
                          title: SizedBox(
                            width: size.width,
                            height: size.height * 0.01,
                            child: const DecoratedBox(
                              decoration: BoxDecoration(
                                color: Colors.white,
                              ),
                            ),
                          ),
                          subtitle: SizedBox(
                            width: size.width,
                            height: size.height * 0.01,
                            child: const DecoratedBox(
                              decoration: BoxDecoration(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      );
                    })
                : ListView.builder(
                    shrinkWrap: true,
                    primary: false,
                    itemCount: controller.users.length,
                    itemBuilder: (context, index) {
                  final user = controller.users[index];
                      return ListTile(
                        onTap: () {
                          messageController.user.value = user;
                          Get.toNamed(MessageRoutes.message);
                        },
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(user.profileImage!),
                        ),
                        title: Text(user.name!),
                        subtitle: Text(user.email!),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
