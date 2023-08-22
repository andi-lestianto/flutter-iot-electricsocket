import 'package:alarm/alarm.dart';
import 'package:smartsocket/app/helper/controlenum_helper.dart';

class NotificationAlarm {
  ControlSocket? controlSocket;
  ControlType? controlType;
  AlarmSettings? alarmSettings;

  NotificationAlarm(this.controlSocket, this.controlType, this.alarmSettings);

  NotificationAlarm.fromJson(Map<String, dynamic> data) {
    controlSocket = ControlEnumHelper()
        .getEnumControlSocket(controlSocketString: data['controlSocket']);
    controlType = ControlEnumHelper()
        .getEnumControlType(controlTypeString: data['controlType']);
    alarmSettings = AlarmSettings.fromJson(data['alarmSettings']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['controlSocket'] = ControlEnumHelper()
        .getStringControlSocket(controlSocketEnum: this.controlSocket!);
    data['controlType'] = ControlEnumHelper()
        .getStringControlType(controlTypeEnum: this.controlType!);
    data['alarmSettings'] = this.alarmSettings!.toJson();
    return data;
  }

  NotificationAlarm copyWith(
      {ControlSocket? controlSocket,
      ControlType? controlType,
      AlarmSettings? alarmSettings}) {
    return NotificationAlarm(controlSocket ?? this.controlSocket,
        controlType ?? this.controlType, alarmSettings ?? this.alarmSettings);
  }
}

enum ControlSocket {
  none,
  socket1,
  socket2,
  socket3,
  socket4,
}

enum ControlType {
  none,
  turnon,
  turnoff,
}
