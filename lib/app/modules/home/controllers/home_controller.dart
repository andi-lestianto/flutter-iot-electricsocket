import 'dart:async';
import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:smartsocket/app/data/mainsocket_model.dart';

class HomeController extends GetxController {
  DatabaseReference ref = FirebaseDatabase.instance.ref('data');
  MainSocket? mainSocket;

  late StreamSubscription<DatabaseEvent> counterSubscription;

  Future readSocketValue() async {
    print('object');
    final snapshot = await ref.get();
    if (snapshot.exists) {
      print(jsonEncode(snapshot.value));
      mainSocket = MainSocket.fromJson(jsonDecode(jsonEncode(snapshot.value)));
    } else {
      print('No data available.');
    }
    update();
  }

  Future setSocketValue({required String socketName}) async {
    final Socket? socket = await getSpecificSocketValue(socketName: socketName);
    if (socket != null) {
      bool value = socket.value ?? false;

      await ref.update({
        socketName: {
          'imgpath': 'assets/icon/ic_lamp.svg',
          'location': 'Living Room',
          'value': !value
        }
      });
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

  tes(DatabaseEvent event) {
    mainSocket =
        MainSocket.fromJson(jsonDecode(jsonEncode(event.snapshot.value)));
    update();
  }

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    print('Hooiiii');
    counterSubscription = ref.onValue.listen(
      (DatabaseEvent event) {
        print(event.snapshot.value);
        tes(event);
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
  void increment() => count.value++;
}
