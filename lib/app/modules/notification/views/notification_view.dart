import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:smartsocket/app/modules/notification/dialog/configurenotification_dialog.dart';
import 'package:smartsocket/app/theme/color_theme.dart';
import 'package:smartsocket/app/theme/font_theme.dart';
import 'package:smartsocket/app/widget/notificationcard_widget.dart';

import '../controllers/notification_controller.dart';

class NotificationView extends GetView<NotificationController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<NotificationController>(
      init: NotificationController(),
      builder: (_) => Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(24.w),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Atur',
                          style: FontTheme.regular.copyWith(fontSize: 12.sp),
                        ),
                        Text(
                          'Pengingat',
                          style: FontTheme.bold.copyWith(fontSize: 16.sp),
                        )
                      ],
                    ),
                    InkWell(
                      highlightColor: Colors.transparent,
                      splashColor: ClrTheme.clrTransparent,
                      onTap: () {
                        ConfigureNotificationDialog().dialogShow();
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 9.w),
                        child: SvgPicture.asset(
                          'assets/icon/ic-addsquare.svg',
                          height: 30.w,
                          width: 30.w,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 24.w,
                ),
                _.notificationAlarm.isEmpty
                    ? Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Lottie.asset(
                                'assets/lottie/lottie-emptynotification.json',
                                width: 200.w,
                                height: 200.w,
                                fit: BoxFit.cover),
                            SizedBox(
                              height: 24.w,
                            ),
                            Text(
                              'Pengingat Masih Kosong',
                              style:
                                  FontTheme.regular.copyWith(fontSize: 12.sp),
                            ),
                            SizedBox(
                              height: 48.w,
                            ),
                          ],
                        ),
                      )
                    : Column(
                        children: [
                          ...List.generate(
                              _.notificationAlarm.length,
                              (index) => NotificationCardWidget(
                                    onTap: () {
                                      // _.getAlarm();
                                    },
                                  ))
                        ],
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
