import 'package:alarm/service/notification.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smartsocket/app/data/notification_model.dart';
import 'package:smartsocket/app/helper/controlenum_helper.dart';
import 'package:smartsocket/app/theme/color_theme.dart';
import 'package:smartsocket/app/theme/font_theme.dart';

class NotificationCardWidget extends StatelessWidget {
  final bool isActive;
  final NotificationAlarm data;
  final Function onIconTap;
  final Function onTap;
  const NotificationCardWidget({
    super.key,
    required this.isActive,
    required this.onIconTap,
    required this.data,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.w),
      child: GestureDetector(
        onTap: () {
          onTap();
        },
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  border: Border.all(width: 2.w, color: ClrTheme.clrWhiteGray)),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      onIconTap();
                    },
                    child: Container(
                      padding: EdgeInsets.all(8.w),
                      height: 40.w,
                      width: 40.w,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isActive
                              ? ClrTheme.clrGold
                              : ClrTheme.clrWhiteGray),
                      child: SvgPicture.asset(
                        'assets/icon/nav/ic-notification.svg',
                        color: isActive ? ClrTheme.clrWhite : ClrTheme.clrBlack,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 16.w,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data.alarmSettings!.notificationTitle.toString(),
                        style: FontTheme.regular.copyWith(fontSize: 12.sp),
                      ),
                      Text(
                        data.alarmSettings!.dateTime
                            .toString()
                            .split(' ')
                            .last
                            .substring(0, 5),
                        style: FontTheme.bold.copyWith(fontSize: 12.sp),
                      )
                    ],
                  )
                ],
              ),
            ),
            if (data.controlSocket != ControlSocket.none)
              Positioned.fill(
                  child: Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: EdgeInsets.all(8.w),
                        child: Wrap(
                          spacing: 8.w,
                          runSpacing: 8.w,
                          children: [
                            Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8.w, vertical: 4.w),
                                decoration: BoxDecoration(
                                    color: ClrTheme.clrGold.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(4.r),
                                    border: Border.all(
                                        width: 1, color: ClrTheme.clrGold)),
                                child: Text(
                                    ControlEnumHelper().getStringControlSocket(
                                        controlSocketEnum: data.controlSocket!,
                                        formatted: true),
                                    style: FontTheme.regular
                                        .copyWith(fontSize: 8.sp))),
                            Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8.w, vertical: 4.w),
                                decoration: BoxDecoration(
                                    color: ClrTheme.clrGold.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(4.r),
                                    border: Border.all(
                                        width: 1, color: ClrTheme.clrGold)),
                                child: Text(
                                    ControlEnumHelper().getStringControlType(
                                        controlTypeEnum: data.controlType!,
                                        formatted: true),
                                    style: FontTheme.regular
                                        .copyWith(fontSize: 8.sp))),
                          ],
                        ),
                      ))),
          ],
        ),
      ),
    );
  }
}
