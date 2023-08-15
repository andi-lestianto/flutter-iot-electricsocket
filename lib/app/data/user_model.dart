class UserModel {
  String? nama;
  String? profilePict;

  UserModel({required this.nama, required this.profilePict});

  UserModel.fromJson(Map<String, dynamic> json) {
    nama = json['nama'];
    profilePict = json['profilePict'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['nama'] = this.nama;
    data['profilePict'] = this.profilePict;
    return data;
  }
}
