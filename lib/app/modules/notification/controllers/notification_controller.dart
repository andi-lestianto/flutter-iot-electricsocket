import 'package:alarm/alarm.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartsocket/app/data/notification_model.dart';
import 'package:smartsocket/app/database/db_services.dart';
import 'package:smartsocket/app/helper/datetime_helper.dart';
import 'package:smartsocket/app/widget/toast_widget.dart';

class NotificationController extends GetxController {
  final DBServices dbServices = DBServices();
  final TextEditingController nameController = TextEditingController();
  String selectedTime = '00:00';

  List<ControlSocket> listControlSocket = [
    ControlSocket.none,
    ControlSocket.socket1,
    ControlSocket.socket2,
    ControlSocket.socket3,
    ControlSocket.socket4,
  ];
  ControlSocket selectedControlSocket = ControlSocket.none;

  setSelectedControlSocket({required ControlSocket controlSocket}) {
    selectedControlSocket = controlSocket;
    if (controlSocket == ControlSocket.none) {
      selectedControlType = ControlType.none;
    }
    update();
  }

  List<ControlType> listControlType = [
    ControlType.none,
    ControlType.turnoff,
    ControlType.turnon
  ];

  ControlType selectedControlType = ControlType.none;

  setSelectedControlType({required ControlType controlType}) {
    selectedControlType = controlType;
    update();
  }

  setSelectedTime({required TimeOfDay timeOfDay}) {
    String? jam;
    String? menit;
    if (timeOfDay.hour.toString().length == 1) {
      jam = '0${timeOfDay.hour}';
    } else {
      jam = '${timeOfDay.hour}';
    }

    if (timeOfDay.minute.toString().length == 1) {
      menit = '0${timeOfDay.minute}';
    } else {
      menit = '${timeOfDay.minute}';
    }
    selectedTime = '${jam}:${menit}';
    update();
  }

  List<NotificationAlarm> notificationAlarm = [];

  clearAlarmForm() {
    nameController.clear();
    selectedControlSocket = ControlSocket.none;
    selectedControlType = ControlType.none;
    setSelectedTime(timeOfDay: TimeOfDay.now());
  }

  fillAlarmForm({required NotificationAlarm data}) {
    nameController.text = data.alarmSettings!.notificationTitle!;
    selectedControlSocket = data.controlSocket!;
    selectedControlType = data.controlType!;
    setSelectedTime(
        timeOfDay: TimeOfDay.fromDateTime(data.alarmSettings!.dateTime));
  }

  addNotificationAlarm(
      {required String timeAlarm,
      required String alarmName,
      required ControlSocket controlSocket,
      required ControlType controlType}) async {
    try {
      if (alarmName == '') {
        ToastPopup().showAlert(message: 'Nama pengingat wajib diisi!');
      } else if (controlSocket != ControlSocket.none &&
          controlType == ControlType.none) {
        ToastPopup().showAlert(message: 'Type kontrol tidak boleh \'none\'');
      } else if ((notificationAlarm.firstWhereOrNull((element) =>
                  element.alarmSettings!.dateTime ==
                  DateTime.parse(
                      '${DateTimeHelper().getDateNow()} ${timeAlarm}')) !=
              null) ||
          (notificationAlarm.firstWhereOrNull((element) =>
                  element.alarmSettings!.dateTime ==
                  DateTime.parse(
                      '${DateTimeHelper().getDateAfterNow()} ${timeAlarm}')) !=
              null)) {
        ToastPopup()
            .showAlert(message: 'Data alarm dengan waktu yang sama sudah ada!');
      } else {
        NotificationAlarm data = NotificationAlarm(
            controlSocket,
            controlType,
            AlarmSettings(
              id: notificationAlarm.isEmpty
                  ? 1
                  : notificationAlarm.last.alarmSettings!.id + 1,
              dateTime: DateTime.parse(
                  '${DateTimeHelper().getDateNow()} ${timeAlarm}'),
              assetAudioPath: 'assets/audio/alarmtone.mp3',
              loopAudio: true,
              vibrate: true,
              fadeDuration: 3.0,
              notificationTitle: alarmName,
              notificationBody: 'Klik disini untuk menonaktifkan notifikasi',
              enableNotificationOnKill: true,
            ));
        notificationAlarm.add(data);
        dbServices.updateNotificationData(
            listNotificationAlarm: notificationAlarm);
        update();
        ToastPopup().showSucess(message: 'Pengingat berhasil ditambahkan!');
        print(data.alarmSettings);
        await setAlarm(data: data.alarmSettings!);
      }
    } catch (e) {
      print(e);
    }
  }

  editNotificationAlarm(
      {required int idAlarm,
      required String timeAlarm,
      required String alarmName,
      required ControlSocket controlSocket,
      required ControlType controlType}) async {
    try {
      if (alarmName == '') {
        ToastPopup().showAlert(message: 'Nama pengingat wajib diisi!');
      } else if (controlSocket != ControlSocket.none &&
          controlType == ControlType.none) {
        ToastPopup().showAlert(message: 'Type kontrol tidak boleh \'none\'');
      } else {
        NotificationAlarm data = NotificationAlarm(
            controlSocket,
            controlType,
            AlarmSettings(
              id: notificationAlarm.isEmpty
                  ? 1
                  : notificationAlarm.last.alarmSettings!.id + 1,
              dateTime: DateTime.parse(
                  '${DateTimeHelper().getDateNow()} ${timeAlarm}'),
              assetAudioPath: 'assets/audio/alarmtone.mp3',
              loopAudio: true,
              vibrate: true,
              fadeDuration: 3.0,
              notificationTitle: alarmName,
              notificationBody: 'Klik disini untuk menonaktifkan notifikasi',
              enableNotificationOnKill: true,
            ));
        notificationAlarm.add(data);
        dbServices.updateNotificationData(
            listNotificationAlarm: notificationAlarm);
        update();
        ToastPopup().showSucess(message: 'Pengingat berhasil ditambahkan!');
      }
    } catch (e) {
      print(e);
    }
  }

  deleteNotificationAlarm({required NotificationAlarm data}) async {
    final response = await Alarm.getAlarm(data.alarmSettings!.id);
    if (response != null) {
      Alarm.stop(response.id);
    }
    notificationAlarm.removeWhere(
        (element) => element.alarmSettings!.id == data.alarmSettings!.id);
    dbServices.updateNotificationData(listNotificationAlarm: notificationAlarm);
    update();
  }

  tesDate() {
    print(DateTimeHelper().getDateNow());
    print(DateTimeHelper().getDateAfterNow());

    DateTime dateAlarm = DateTime.parse('2023-08-13 19:11:26');
    print(dateAlarm.isAfter(DateTime.now()));
  }

  Future setAlarm({required AlarmSettings data}) async {
    if (await getAlarm(id: data.id)) {
      Alarm.stop(data.id);
    } else {
      bool? response;
      if (data.dateTime.isBefore(DateTime.now())) {
        print('jam sebelum sekarang');
        NotificationAlarm? currentNotificationAlarm =
            notificationAlarm.firstWhereOrNull(
                (element) => element.alarmSettings!.id == data.id);

        if (currentNotificationAlarm != null) {
          DateTime currentAlarmDate =
              currentNotificationAlarm.alarmSettings!.dateTime;
          if (currentAlarmDate.isBefore(DateTime.now())) {
            String timeAlarm = currentAlarmDate.toString().split(' ').last;

            currentNotificationAlarm.alarmSettings =
                currentNotificationAlarm.alarmSettings!.copyWith(
                    dateTime: DateTime.parse(
                        '${DateTimeHelper().getDateAfterNow()} ${timeAlarm}'));
          }
        }
        dbServices.updateNotificationData(
            listNotificationAlarm: notificationAlarm);
        response = await Alarm.set(
            alarmSettings: currentNotificationAlarm!.alarmSettings!);
      } else {
        response = await Alarm.set(alarmSettings: data);
      }
      if (response) {
        print('Alarm setted');
      } else {
        print('Alarm failed');
      }
    }
    update();
  }

  Future<bool> getAlarm({required int id}) async {
    final response = await Alarm.getAlarm(id);
    if (response != null) {
      return true;
    } else {
      return false;
    }
  }

  getDataNotificationFromLocal() async {
    List<NotificationAlarm> data = await dbServices.getAllNotificationData();
    if (data.isNotEmpty) {
      notificationAlarm.addAll(data);
    }

    await Future.delayed(Duration.zero).then((value) => update());
  }

  @override
  void onInit() {
    super.onInit();
    getDataNotificationFromLocal();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
