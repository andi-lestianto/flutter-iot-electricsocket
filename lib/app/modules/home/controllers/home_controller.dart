import 'dart:async';
import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:smartsocket/app/data/mainsocket_model.dart';
import 'package:smartsocket/app/data/notification_model.dart';
import 'package:smartsocket/app/helper/controlenum_helper.dart';
import 'package:smartsocket/app/widget/toast_widget.dart';

class HomeController extends GetxController {
  DatabaseReference ref = FirebaseDatabase.instance.ref('data');
  MainSocket? mainSocket;

  final TextEditingController labelController = TextEditingController();

  setTextController({required String text}) {
    labelController.text = text;
  }

  late StreamSubscription<DatabaseEvent> socketSubscription;

  Future setSocketValue({required String socketName}) async {
    final Socket? socket = await getSpecificSocketValue(socketName: socketName);
    if (socket != null) {
      bool value = socket.value ?? false;

      await ref.update({
        socketName: {'description': socket.description, 'value': !value}
      });
    }
  }

  Future setSocketLabel(
      {required String socketName, required String labelName}) async {
    final Socket? socket = await getSpecificSocketValue(socketName: socketName);
    if (socket != null) {
      bool value = socket.value ?? false;

      await ref.update({
        socketName: {'description': labelName, 'value': value}
      });
      Get.back();
      ToastPopup().showSucess(message: 'Label berhasil diganti!');
    }
  }

  Future<Socket?> getSpecificSocketValue({required String socketName}) async {
    final data = await ref.child(socketName).get();
    if (data.exists) {
      print(data.value);
      return Socket.fromJson(jsonDecode(jsonEncode(data.value)));
    } else {
      return null;
    }
  }

  updateMainSocket(DatabaseEvent event) {
    mainSocket =
        MainSocket.fromJson(jsonDecode(jsonEncode(event.snapshot.value)));
    update();
  }

  Future setSocketValueFromAlarm(
      {required ControlSocket controlSocket,
      required ControlType controlType}) async {
    String socketName = ControlEnumHelper()
        .getStringControlSocket(controlSocketEnum: controlSocket);

    final Socket? socket = await getSpecificSocketValue(socketName: socketName);

    if (socket != null) {
      bool value = controlType == ControlType.turnoff ? false : true;
      await ref.update({
        socketName: {'description': socket.description, 'value': value}
      });
    }
  }

  @override
  void onInit() {
    super.onInit();
    socketSubscription = ref.onValue.listen(
      (DatabaseEvent event) {
        print(event.snapshot.value);
        updateMainSocket(event);
      },
      onError: (Object o) {
        final error = o as FirebaseException;
        print(error);
      },
    );
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
