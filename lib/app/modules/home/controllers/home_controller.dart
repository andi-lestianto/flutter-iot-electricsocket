import 'dart:async';
import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_background/flutter_background.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smartsocket/app/data/mainsocket_model.dart';
import 'package:smartsocket/app/data/notification_model.dart';
import 'package:smartsocket/app/data/user_model.dart';
import 'package:smartsocket/app/database/db_services.dart';
import 'package:smartsocket/app/helper/controlenum_helper.dart';
import 'package:smartsocket/app/modules/notification/dialog/configurenotification_dialog.dart';
import 'package:smartsocket/app/widget/toast_widget.dart';

class HomeController extends GetxController {
  final DBServices dbServices = DBServices();
  DatabaseReference ref = FirebaseDatabase.instance.ref('data');
  MainSocket? mainSocket;

  final TextEditingController labelController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  setTextController({required String text}) {
    labelController.text = text;
  }

  UserModel? userModel;
  XFile? pickedFoto;
  final ImagePicker picker = ImagePicker();

  pickFotoProfile() async {
    try {
      final XFile? pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
      );
      if (pickedFile != null) {
        pickedFoto = pickedFile;
      }
    } catch (e) {
      print(e);
    }

    update();
  }

  checkProfile() async {
    Map<String, dynamic>? response = await dbServices.getUserData();
    if (response != null) {
      userModel = UserModel.fromJson(response);
      pickedFoto = XFile(userModel!.profilePict.toString());
      update();
    } else {
      configureUserUpdate().dialogShow(isFirst: true);
    }
  }

  saveProfile() async {
    if (nameController.text == '' || pickedFoto == null) {
      ToastPopup().showAlert(message: 'Semua data harus di isi!');
    } else {
      Map<String, dynamic> newUserData = {
        'nama': nameController.text,
        'profilePict': pickedFoto == null ? null : pickedFoto!.path,
      };
      userModel = UserModel.fromJson(newUserData);
      final response = await dbServices.saveUserData(userModel!);
      if (response) {
        Get.back();
        ToastPopup().showSucess(message: 'Data pengguna berhasil disimpan!');
      } else {
        ToastPopup().showAlert(message: 'Gagal menyimpan data pengguna!');
      }
      update();
    }
  }

  clearUserForm() async {
    nameController.clear();
    pickedFoto = null;
    await Future.delayed(Duration.zero).then((value) => update());
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
    if (labelName == '') {
      ToastPopup().showAlert(message: 'Label tidak boleh kosong!');
    } else {
      final Socket? socket =
          await getSpecificSocketValue(socketName: socketName);
      if (socket != null) {
        bool value = socket.value ?? false;

        await ref.update({
          socketName: {'description': labelName, 'value': value}
        });
        Get.back();
        ToastPopup().showSucess(message: 'Label berhasil diganti!');
      }
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

  requetsBackgroundServices() async {
    bool success = await FlutterBackground.initialize();
    print(success);
    bool hasPermissions = await FlutterBackground.hasPermissions;

    if (!hasPermissions) {
      Get.back();
      return backgroundPermissionDenied().show(onRequestPermission: () {
        requetsBackgroundServices();
      });
    } else {
      print('Background service grandted');
      Get.back();
      checkProfile();
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
      FlutterBackground.enableBackgroundExecution();
    }
  }

  @override
  void onInit() {
    super.onInit();
    requetsBackgroundServices();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
