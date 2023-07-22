class DateTimeHelper {
  String getDateNow() {
    DateTime dateNow = DateTime.now();
    return dateNow.toString().split(' ').first;
  }
}
