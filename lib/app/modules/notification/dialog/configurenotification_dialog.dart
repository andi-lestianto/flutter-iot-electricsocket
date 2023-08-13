import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:smartsocket/app/data/mainsocket_model.dart';
import 'package:smartsocket/app/data/notification_model.dart';
import 'package:smartsocket/app/helper/controlenum_helper.dart';
import 'package:smartsocket/app/modules/home/controllers/home_controller.dart';
import 'package:smartsocket/app/modules/notification/controllers/notification_controller.dart';
import 'package:smartsocket/app/theme/color_theme.dart';
import 'package:smartsocket/app/theme/font_theme.dart';

class ConfigureNotificationDialog {
  dialogShow(BuildContext context, {required bool isEdit}) {
    showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: ClrTheme.clrTransparent,
      useRootNavigator: true,
      context: context,
      builder: (context) => GetBuilder<NotificationController>(
        builder: (_) => Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            decoration: BoxDecoration(
                color: ClrTheme.clrWhite,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16.r),
                    topRight: Radius.circular(16.r))),
            child: Padding(
              padding: EdgeInsets.all(24.w),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      (isEdit ? 'Edit' : 'Tambah') + ' Data Pengingat',
                      style: FontTheme.bold.copyWith(fontSize: 16.sp),
                    ),
                    SizedBox(
                      height: 16.w,
                    ),
                    Text('Nama Pengingat',
                        style: FontTheme.regular.copyWith(fontSize: 12.sp)),
                    SizedBox(
                      height: 8.w,
                    ),
                    TextField(
                      controller: _.nameController,
                      style: FontTheme.regular.copyWith(fontSize: 12.sp),
                      cursorColor: ClrTheme.clrGold,
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
                    Text('Waktu',
                        style: FontTheme.regular.copyWith(fontSize: 12.sp)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('${_.selectedTime}',
                            style: FontTheme.bold.copyWith(fontSize: 32.sp)),
                        GestureDetector(
                          onTap: () async {
                            TimeOfDay? selectedTime = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                              builder: (context, child) => MediaQuery(
                                  data: MediaQuery.of(context).copyWith(
                                    alwaysUse24HourFormat: true,
                                  ),
                                  child: child!),
                            );

                            if (selectedTime != null) {
                              _.setSelectedTime(timeOfDay: selectedTime);
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.all(12.w),
                            height: 48.w,
                            width: 48.w,
                            decoration: BoxDecoration(
                                color: ClrTheme.clrWhiteGray,
                                borderRadius: BorderRadius.circular(12.r)),
                            child: SvgPicture.asset('assets/icon/ic-clock.svg'),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 16.w,
                    ),
                    Text('Kontrol StopKontak',
                        style: FontTheme.regular.copyWith(fontSize: 12.sp)),
                    SizedBox(
                      height: 8.w,
                    ),
                    Wrap(
                      spacing: 8.w,
                      runSpacing: 8.w,
                      children: [
                        ...List.generate(
                            _.listControlSocket.length,
                            (index) => GestureDetector(
                                  onTap: () {
                                    _.setSelectedControlSocket(
                                        controlSocket:
                                            _.listControlSocket[index]);
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 8.w, vertical: 4.w),
                                    decoration: BoxDecoration(
                                        color: _.selectedControlSocket ==
                                                _.listControlSocket[index]
                                            ? ClrTheme.clrGold.withOpacity(0.2)
                                            : ClrTheme.clrWhiteGray,
                                        borderRadius:
                                            BorderRadius.circular(4.r),
                                        border: Border.all(
                                            width: 1,
                                            color: _.selectedControlSocket ==
                                                    _.listControlSocket[index]
                                                ? ClrTheme.clrGold
                                                : ClrTheme.clrWhiteGray)),
                                    child: Text(
                                        ControlEnumHelper()
                                            .getStringControlSocket(
                                                controlSocketEnum:
                                                    _.listControlSocket[index],
                                                formatted: true),
                                        style: FontTheme.regular
                                            .copyWith(fontSize: 12.sp)),
                                  ),
                                ))
                      ],
                    ),
                    if (_.selectedControlSocket != ControlSocket.none)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 16.w,
                          ),
                          Text('Aksi',
                              style:
                                  FontTheme.regular.copyWith(fontSize: 12.sp)),
                          SizedBox(
                            height: 8.w,
                          ),
                          Wrap(
                            spacing: 8.w,
                            runSpacing: 8.w,
                            children: [
                              ...List.generate(
                                  _.listControlType.length,
                                  (index) => GestureDetector(
                                        onTap: () {
                                          _.setSelectedControlType(
                                              controlType:
                                                  _.listControlType[index]);
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 8.w, vertical: 4.w),
                                          decoration: BoxDecoration(
                                              color: _.selectedControlType ==
                                                      _.listControlType[index]
                                                  ? ClrTheme.clrGold
                                                      .withOpacity(0.2)
                                                  : ClrTheme.clrWhiteGray,
                                              borderRadius:
                                                  BorderRadius.circular(4.r),
                                              border: Border.all(
                                                  width: 1,
                                                  color:
                                                      _.selectedControlType ==
                                                              _.listControlType[
                                                                  index]
                                                          ? ClrTheme.clrGold
                                                          : ClrTheme
                                                              .clrWhiteGray)),
                                          child: Text(
                                              ControlEnumHelper()
                                                  .getStringControlType(
                                                      controlTypeEnum:
                                                          _.listControlType[
                                                              index],
                                                      formatted: true),
                                              style: FontTheme.regular
                                                  .copyWith(fontSize: 12.sp)),
                                        ),
                                      ))
                            ],
                          ),
                        ],
                      ),
                    SizedBox(
                      height: 20.w,
                    ),
                    SizedBox(
                      width: 1.sw,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.r)),
                              padding: EdgeInsets.symmetric(vertical: 12.w),
                              backgroundColor: ClrTheme.clrGold),
                          onPressed: () {
                            _.addNotificationAlarm(
                                timeAlarm: _.selectedTime,
                                alarmName: _.nameController.text,
                                controlSocket: _.selectedControlSocket,
                                controlType: _.selectedControlType);
                          },
                          child: Text(
                            'Simpan',
                            style: FontTheme.bold.copyWith(
                                fontSize: 16.sp, color: ClrTheme.clrWhite),
                          )),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class configureSocketDesc {
  dialogShow(BuildContext context,
      {required String socketId,
      required Socket socket,
      required TextEditingController textEditingController,
      required Function onSave}) {
    return showDialog(
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
                'Ubah Label ${socketId}',
                style: FontTheme.bold.copyWith(fontSize: 16.sp),
              ),
              SizedBox(
                height: 8.w,
              ),
              TextField(
                controller: textEditingController,
                cursorColor: ClrTheme.clrGold,
                style: FontTheme.regular.copyWith(fontSize: 12.sp),
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 12.w),
                    filled: true,
                    fillColor: ClrTheme.clrWhiteGray,
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(12.r))),
              ),
              SizedBox(
                height: 16.w,
              ),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Get.back();
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
                          child: Text('Kembali',
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
                        onSave();
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
                          child: Text('Simpan',
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
