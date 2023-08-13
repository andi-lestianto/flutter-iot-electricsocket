import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smartsocket/app/theme/color_theme.dart';
import 'package:smartsocket/app/theme/font_theme.dart';

class ToastPopup {
  showAlert({required String message}) {
    Get.snackbar('Error', message,
        margin: EdgeInsets.all(24.w),
        backgroundColor: ClrTheme.clrGold,
        messageText: Container(
          child: Text(message,
              style: FontTheme.regular.copyWith(
                fontSize: 12.sp,
                color: ClrTheme.clrWhite,
              )),
        ),
        titleText: Text(
          'Error',
          style: FontTheme.bold
              .copyWith(fontSize: 16.sp, color: ClrTheme.clrWhite),
        ));
  }

  showSucess({required String message}) {
    Get.snackbar('Berhasil', message,
        margin: EdgeInsets.all(24.w),
        backgroundColor: ClrTheme.clrTeal,
        messageText: Container(
          child: Text(message,
              style: FontTheme.regular.copyWith(
                fontSize: 12.sp,
                color: ClrTheme.clrWhite,
              )),
        ),
        titleText: Text(
          'Berhasil',
          style: FontTheme.bold
              .copyWith(fontSize: 16.sp, color: ClrTheme.clrWhite),
        ));
  }
}
