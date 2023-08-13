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
                        _.clearAlarmForm();
                        ConfigureNotificationDialog()
                            .dialogShow(context, isEdit: false);
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
                    : Expanded(
                        child: SingleChildScrollView(
                          physics: BouncingScrollPhysics(),
                          child: Column(
                            children: [
                              ...List.generate(
                                  _.notificationAlarm.length,
                                  (index) => Dismissible(
                                        key: ValueKey(index),
                                        direction: DismissDirection.endToStart,
                                        onDismissed: (direction) async {},
                                        confirmDismiss: (direction) async {
                                          return await showConfirmDialog(
                                              context, onDelete: () {
                                            _.deleteNotificationAlarm(
                                                data:
                                                    _.notificationAlarm[index]);
                                          });
                                        },
                                        child: FutureBuilder(
                                          future: _.getAlarm(
                                              id: _.notificationAlarm[index]
                                                  .alarmSettings!.id),
                                          builder: (context, snapshot) =>
                                              NotificationCardWidget(
                                            isActive: snapshot.data == null
                                                ? false
                                                : snapshot.data!,
                                            data: _.notificationAlarm[index],
                                            onIconTap: () async {
                                              // _.tesDate();
                                              await _.setAlarm(
                                                  data: _
                                                      .notificationAlarm[index]
                                                      .alarmSettings!);
                                            },
                                            onTap: () {
                                              _.fillAlarmForm(
                                                  data: _.notificationAlarm[
                                                      index]);
                                              ConfigureNotificationDialog()
                                                  .dialogShow(context,
                                                      isEdit: true);
                                            },
                                          ),
                                        ),
                                      ))
                            ],
                          ),
                        ),
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }

  showConfirmDialog(BuildContext context, {required Function onDelete}) async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        elevation: 0,
        backgroundColor: ClrTheme.clrTransparent,
        content: Container(
          padding: EdgeInsets.all(24.w),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              color: ClrTheme.clrWhite),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Hapus Data?',
                style: FontTheme.bold.copyWith(fontSize: 16.sp),
              ),
              SizedBox(
                height: 8.w,
              ),
              Text(
                'Yakin Ingin Menghapus Data?',
                style: FontTheme.regular.copyWith(fontSize: 12.sp),
              ),
              SizedBox(
                height: 16.w,
              ),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop(false);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.w, vertical: 4.w),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4.r),
                            color: ClrTheme.clrWhiteGray,
                            border: Border.all(
                                width: 2, color: ClrTheme.clrWhiteGray)),
                        child: Center(
                          child: Text('Tidak',
                              style:
                                  FontTheme.regular.copyWith(fontSize: 12.sp)),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 16.w,
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop(true);
                        onDelete();
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.w, vertical: 4.w),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4.r),
                            color: ClrTheme.clrGold,
                            border:
                                Border.all(width: 2, color: ClrTheme.clrGold)),
                        child: Center(
                          child: Text('Ya',
                              style: FontTheme.regular.copyWith(
                                  fontSize: 12.sp, color: ClrTheme.clrWhite)),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
