class DateTimeHelper {
  String getDateNow() {
    DateTime dateNow = DateTime.now();
    return dateNow.toString().split(' ').first;
  }

  String getDateAfterNow() {
    DateTime dateAfterNow = DateTime(
        DateTime.now().year, DateTime.now().month, DateTime.now().day + 1);

    return dateAfterNow.toString().split(' ').first;
  }
}
