import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  DatabaseReference ref = FirebaseDatabase.instance.ref('data');
  Future readSocketValue() async {
    print('object');
    final snapshot = await ref.get();
    if (snapshot.exists) {
      print(snapshot.value);
    } else {
      print('No data available.');
    }
  }

  Future setSocketValue({required String socketName}) async {
    final currentValue = await getSpecificSocketValue(socketName: socketName);
    final data = await ref.update({socketName: !currentValue});
  }

  Future getSpecificSocketValue({required String socketName}) async {
    final data = await ref.child(socketName).get();
    if (data.exists) {
      return data.value;
    } else {
      return false;
    }
  }

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    readSocketValue();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
