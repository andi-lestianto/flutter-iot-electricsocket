import 'package:smartsocket/app/data/notification_model.dart';

class ControlEnumHelper {
  String getStringControlSocket(
      {required ControlSocket controlSocketEnum, bool formatted = false}) {
    switch (controlSocketEnum) {
      case ControlSocket.none:
        return formatted ? 'Tidak ada' : 'none';
      case ControlSocket.socket1:
        return formatted ? 'Socket 1' : 'socket1';
      case ControlSocket.socket2:
        return formatted ? 'Socket 2' : 'socket2';
      case ControlSocket.socket3:
        return formatted ? 'Socket 3' : 'socket3';
      case ControlSocket.socket4:
        return formatted ? 'Socket 4' : 'socket4';
      default:
        return formatted ? 'Tidak ada' : 'none';
    }
  }

  ControlSocket getEnumControlSocket({required String controlSocketString}) {
    switch (controlSocketString) {
      case 'none':
        return ControlSocket.none;
      case 'socket1':
        return ControlSocket.socket1;
      case 'socket2':
        return ControlSocket.socket2;
      case 'socket3':
        return ControlSocket.socket3;
      case 'socket4':
        return ControlSocket.socket4;
      default:
        return ControlSocket.none;
    }
  }

  String getStringControlType(
      {required ControlType controlTypeEnum, bool formatted = false}) {
    switch (controlTypeEnum) {
      case ControlType.none:
        return formatted ? 'Tidak ada' : 'none';
      case ControlType.turnon:
        return formatted ? 'Hidupkan' : 'turnon';
      case ControlType.turnoff:
        return formatted ? 'Matikan' : 'turnoff';
      default:
        return formatted ? 'Tidak ada' : 'none';
    }
  }

  ControlType getEnumControlType({required String controlTypeString}) {
    switch (controlTypeString) {
      case 'none':
        return ControlType.none;
      case 'turnon':
        return ControlType.turnon;
      case 'turnoff':
        return ControlType.turnoff;
      default:
        return ControlType.none;
    }
  }
}
