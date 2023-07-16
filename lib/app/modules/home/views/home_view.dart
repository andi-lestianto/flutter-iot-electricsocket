import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) => Scaffold(
        appBar: AppBar(
          title: Text('HomeView'),
          centerTitle: true,
        ),
        body: Column(
          children: [
            ElevatedButton(
                onPressed: () {
                  controller.setSocketValue(socketName: 'socket1');
                },
                child: Text('Update socket1'))
          ],
        ),
      ),
    );
  }
}
