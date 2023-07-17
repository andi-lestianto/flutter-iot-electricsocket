import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smartsocket/app/data/mainsocket_model.dart';
import 'package:smartsocket/app/theme/color_theme.dart';
import 'package:smartsocket/app/theme/font_theme.dart';

class SocketCardWidget extends StatelessWidget {
  final Socket? socket;
  final Function onTap;
  const SocketCardWidget(
      {super.key, required this.socket, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 250),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
          border: socket!.value == true
              ? null
              : Border.all(width: 2, color: ClrTheme.clrWhiteGray),
          color:
              socket!.value == true ? ClrTheme.clrDarkBlue : ClrTheme.clrWhite,
          borderRadius: BorderRadius.circular(10.r),
          boxShadow: socket!.value == true
              ? [
                  BoxShadow(
                      color: ClrTheme.clrDarkGray.withOpacity(0.5),
                      offset: Offset(9.w, 13.w),
                      spreadRadius: -6,
                      blurRadius: 20)
                ]
              : []),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SvgPicture.asset(
                'assets/icon/ic-sunfog.svg',
                height: 46.w,
                width: 46.w,
                color: socket!.value == true
                    ? ClrTheme.clrWhite
                    : ClrTheme.clrDarkGray,
              ),
              Text(
                socket!.location.toString(),
                style: FontTheme.medium.copyWith(
                    fontSize: 12.sp,
                    color: socket!.value == true
                        ? ClrTheme.clrWhite
                        : ClrTheme.clrDarkGray),
              ),
              GestureDetector(
                onTap: () {
                  onTap();
                },
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 250),
                  width: 65.w,
                  height: 30.w,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24.r),
                      color: ClrTheme.clrTransparent,
                      border: Border.all(
                          width: 2.w,
                          color: socket!.value == true
                              ? ClrTheme.clrTeal
                              : ClrTheme.clrDarkBlue)),
                  child: Stack(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            left: socket!.value == true ? 10.w : 0,
                            right: socket!.value == true ? 0.w : 10.w),
                        child: AnimatedAlign(
                            duration: Duration(milliseconds: 250),
                            alignment: socket!.value == true
                                ? Alignment.centerLeft
                                : Alignment.centerRight,
                            child: AnimatedSwitcher(
                              duration: Duration(milliseconds: 250),
                              child: Text(
                                socket!.value == true ? 'ON' : 'OFF',
                                style: FontTheme.medium.copyWith(
                                    fontSize: 12.sp,
                                    color: socket!.value == true
                                        ? ClrTheme.clrTeal
                                        : ClrTheme.clrDarkBlue),
                              ),
                            )),
                      ),
                      AnimatedAlign(
                        duration: Duration(milliseconds: 250),
                        alignment: socket!.value == true
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 250),
                          margin: EdgeInsets.symmetric(horizontal: 2.w),
                          width: 22.w,
                          height: 22.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: socket!.value == true
                                ? ClrTheme.clrTeal
                                : ClrTheme.clrDarkBlue,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.topRight,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 250),
              padding: EdgeInsets.all(4.w),
              height: 24.w,
              width: 24.w,
              decoration: BoxDecoration(
                  color: socket!.value == true
                      ? ClrTheme.clrTeal
                      : ClrTheme.clrDarkBlue,
                  borderRadius: BorderRadius.circular(4.r)),
              child: SvgPicture.asset(
                'assets/icon/ic-edit.svg',
                color: socket!.value == true
                    ? ClrTheme.clrDarkBlue
                    : ClrTheme.clrWhite,
              ),
            ),
          )
        ],
      ),
    );
  }
}
