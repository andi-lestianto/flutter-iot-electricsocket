import 'package:intl/intl.dart';

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

  String getDateNowId() {
    String dateNow = DateTime.now().toString().split(' ').first;
    List<String> splittedDate = dateNow.split('-');
    String monthText = convertToMonthString(monthNumber: splittedDate[1]);
    String formattedDate = DateFormat('EEEE', 'id_ID').format(DateTime.now());

    return '${formattedDate}, ${splittedDate[2]} ${monthText} ${splittedDate[0]}';
  }

  String convertToMonthString({required String monthNumber}) {
    switch (monthNumber) {
      case '01':
        return "Januari";
      case '02':
        return "Februari";
      case '03':
        return "Maret";
      case '04':
        return "April";
      case '05':
        return "Mei";
      case '06':
        return "Juni";
      case '07':
        return "Juli";
      case '08':
        return "Agustus";
      case '09':
        return "September";
      case '10':
        return "Oktober";
      case '11':
        return "November";
      case '12':
        return "Desember";
      default:
        return "Bulan tidak valid";
    }
  }

  String getGreeting() {
    int hour = DateTime.now().hour;

    if (hour >= 4 && hour < 10) {
      return "Selamat Pagi";
    } else if (hour >= 10 && hour < 15) {
      return "Selamat Siang";
    } else if (hour >= 15 && hour < 18) {
      return "Selamat Sore";
    } else {
      return "Selamat Malam";
    }
  }
}
