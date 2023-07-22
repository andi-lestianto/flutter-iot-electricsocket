import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smartsocket/app/theme/color_theme.dart';
import 'package:smartsocket/app/theme/font_theme.dart';

class NotificationCardWidget extends StatelessWidget {
  final Function onTap;
  const NotificationCardWidget({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.w),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(width: 2.w, color: ClrTheme.clrWhiteGray)),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              onTap();
            },
            child: Container(
              padding: EdgeInsets.all(8.w),
              height: 40.w,
              width: 40.w,
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: ClrTheme.clrGold),
              child: SvgPicture.asset(
                'assets/icon/nav/ic-notification.svg',
                color: ClrTheme.clrWhite,
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
                'Matikan lampu ruang tamu',
                style: FontTheme.regular.copyWith(fontSize: 12.sp),
              ),
              Text(
                '05.00',
                style: FontTheme.bold.copyWith(fontSize: 12.sp),
              )
            ],
          )
        ],
      ),
    );
  }
}
