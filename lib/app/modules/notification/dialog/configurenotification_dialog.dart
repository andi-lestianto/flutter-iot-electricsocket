import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smartsocket/app/theme/color_theme.dart';
import 'package:smartsocket/app/theme/font_theme.dart';

class ConfigureNotificationDialog {
  dialogShow() {
    Get.bottomSheet(Container(
      decoration: BoxDecoration(color: ClrTheme.clrWhite),
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Tambah Data Pengingat',
              style: FontTheme.bold.copyWith(fontSize: 16.sp),
            ),
            SizedBox(
              height: 16.w,
            ),
            Text('Nama Pengingat',
                style: FontTheme.regular.copyWith(fontSize: 12.sp)),
            SizedBox(
              height: 16.w,
            ),
            TextField(
              decoration: InputDecoration(
                  filled: true,
                  fillColor: ClrTheme.clrWhiteGray,
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(12.r))),
            ),
            SizedBox(
              height: 16.w,
            ),
            Text('Waktu', style: FontTheme.regular.copyWith(fontSize: 12.sp)),
            Row(
              children: [
                Text('00:00', style: FontTheme.bold.copyWith(fontSize: 32.sp)),
              ],
            ),
          ],
        ),
      ),
    ));
  }
}
