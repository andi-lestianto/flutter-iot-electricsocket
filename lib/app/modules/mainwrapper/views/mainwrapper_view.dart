import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:smartsocket/app/helper/navigation_helper.dart';
import 'package:smartsocket/app/modules/home/views/home_view.dart';
import 'package:smartsocket/app/modules/notification/views/notification_view.dart';
import 'package:smartsocket/app/routes/app_pages.dart';
import 'package:smartsocket/app/theme/color_theme.dart';
import 'package:smartsocket/app/theme/font_theme.dart';

import '../controllers/mainwrapper_controller.dart';

class MainwrapperView extends GetView<MainwrapperController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainwrapperController>(
      builder: (_) => Scaffold(
        body: Navigator(
          initialRoute: '/',
          key: NavHelper.mainNav,
          onGenerateRoute: (settings) {
            Widget page;
            _.updateCurrentRoutes(settings.name.toString());

            switch (settings.name) {
              case Routes.HOME:
                page = HomeView();
                break;
              case Routes.NOTIFICATION:
                page = NotificationView();
                break;
              default:
                page = HomeView();
            }
            return PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) => page);
          },
        ),
        bottomNavigationBar: BottomAppBar(
          elevation: 0,
          color: ClrTheme.clrTransparent,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 15.w),
            decoration: BoxDecoration(
                color: ClrTheme.clrWhite,
                boxShadow: [
                  BoxShadow(
                      offset: Offset(0, 2),
                      blurRadius: 22,
                      spreadRadius: 2,
                      color: ClrTheme.clrDarkGray.withOpacity(0.2)),
                ],
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(28.r),
                    topRight: Radius.circular(28.r))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    if (_.currentRoutes != Routes.HOME) {
                      NavHelper.mainNav.currentState!
                          .pushReplacementNamed(Routes.HOME);
                    }
                  },
                  child: SvgPicture.asset(
                    'assets/icon/nav/ic-home.svg',
                    height: 38.w,
                    width: 38.w,
                  ),
                ),
                InkWell(
                  onTap: () {
                    if (_.currentRoutes != Routes.NOTIFICATION) {
                      NavHelper.mainNav.currentState!
                          .pushReplacementNamed(Routes.NOTIFICATION);
                    }
                  },
                  child: SvgPicture.asset(
                    'assets/icon/nav/ic-notification.svg',
                    height: 38.w,
                    width: 38.w,
                  ),
                ),
                InkWell(
                  onTap: () {
                    showDialog(
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
                                'Keluar Aplikasi?',
                                style: FontTheme.bold.copyWith(fontSize: 16.sp),
                              ),
                              SizedBox(
                                height: 8.w,
                              ),
                              Text(
                                'Yakin Ingin Keluar Aplikasi?',
                                style:
                                    FontTheme.regular.copyWith(fontSize: 12.sp),
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
                                            borderRadius:
                                                BorderRadius.circular(4.r),
                                            color: ClrTheme.clrWhiteGray,
                                            border: Border.all(
                                                width: 2,
                                                color: ClrTheme.clrWhiteGray)),
                                        child: Center(
                                          child: Text('Tidak',
                                              style: FontTheme.regular
                                                  .copyWith(fontSize: 12.sp)),
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
                                        SystemNavigator.pop();
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 8.w, vertical: 4.w),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(4.r),
                                            color: ClrTheme.clrGold,
                                            border: Border.all(
                                                width: 2,
                                                color: ClrTheme.clrGold)),
                                        child: Center(
                                          child: Text('Ya',
                                              style: FontTheme.regular.copyWith(
                                                  fontSize: 12.sp,
                                                  color: ClrTheme.clrWhite)),
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
                  },
                  child: SvgPicture.asset(
                    'assets/icon/nav/ic-logout.svg',
                    height: 38.w,
                    width: 38.w,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
