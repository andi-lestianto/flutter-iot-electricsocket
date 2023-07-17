import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:smartsocket/app/helper/navigation_helper.dart';
import 'package:smartsocket/app/modules/home/views/home_view.dart';
import 'package:smartsocket/app/routes/app_pages.dart';
import 'package:smartsocket/app/theme/color_theme.dart';

import '../controllers/mainwrapper_controller.dart';

class MainwrapperView extends GetView<MainwrapperController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Navigator(
        initialRoute: '/',
        key: NavHelper.mainNav,
        onGenerateRoute: (settings) {
          Widget page;

          switch (settings.name) {
            case Routes.HOME:
              page = HomeView();
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
                  topLeft: Radius.circular(28.w),
                  topRight: Radius.circular(28.w))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SvgPicture.asset(
                'assets/icon/nav/ic-home.svg',
                height: 38.w,
                width: 38.w,
              ),
              SvgPicture.asset(
                'assets/icon/nav/ic-notification.svg',
                height: 38.w,
                width: 38.w,
              ),
              SvgPicture.asset(
                'assets/icon/nav/ic-logout.svg',
                height: 38.w,
                width: 38.w,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
