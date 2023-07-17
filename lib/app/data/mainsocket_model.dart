class MainSocket {
  Socket? socket2;
  Socket? socket1;
  Socket? socket4;
  Socket? socket3;

  MainSocket({
    this.socket1,
    this.socket2,
    this.socket3,
    this.socket4,
  });

  MainSocket.fromJson(Map<String, dynamic> json) {
    socket1 =
        json['socket1'] != null ? new Socket.fromJson(json['socket1']) : null;
    socket2 =
        json['socket2'] != null ? new Socket.fromJson(json['socket2']) : null;
    socket3 =
        json['socket3'] != null ? new Socket.fromJson(json['socket3']) : null;
    socket4 =
        json['socket4'] != null ? new Socket.fromJson(json['socket4']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.socket1 != null) {
      data['socket1'] = this.socket1!.toJson();
    }
    if (this.socket2 != null) {
      data['socket2'] = this.socket2!.toJson();
    }
    if (this.socket3 != null) {
      data['socket3'] = this.socket3!.toJson();
    }
    if (this.socket4 != null) {
      data['socket4'] = this.socket4!.toJson();
    }
    return data;
  }
}

class Socket {
  String? imgpath;
  String? location;
  bool? value;

  Socket({this.imgpath, this.location, this.value});

  Socket.fromJson(Map<String, dynamic> json) {
    imgpath = json['imgpath'];
    location = json['location'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['imgpath'] = this.imgpath;
    data['location'] = this.location;
    data['value'] = this.value;
    return data;
  }
}
