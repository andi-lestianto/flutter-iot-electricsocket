import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:move_to_background/move_to_background.dart';
import 'package:get/get.dart';
import 'package:smartsocket/app/helper/navigation_helper.dart';
import 'package:smartsocket/app/modules/home/views/home_view.dart';
import 'package:smartsocket/app/modules/notification/dialog/configurenotification_dialog.dart';
import 'package:smartsocket/app/modules/notification/views/notification_view.dart';
import 'package:smartsocket/app/routes/app_pages.dart';
import 'package:smartsocket/app/theme/color_theme.dart';

import '../controllers/mainwrapper_controller.dart';

class MainwrapperView extends GetView<MainwrapperController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainwrapperController>(
      builder: (_) => WillPopScope(
        onWillPop: () async {
          MoveToBackground.moveTaskToBack();
          return false;
        },
        child: Scaffold(
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
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      page);
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
                      _.currentRoutes == Routes.HOME
                          ? 'assets/icon/nav/ic-home-active.svg'
                          : 'assets/icon/nav/ic-home.svg',
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
                      _.currentRoutes == Routes.NOTIFICATION
                          ? 'assets/icon/nav/ic-notification-active.svg'
                          : 'assets/icon/nav/ic-notification.svg',
                      height: 38.w,
                      width: 38.w,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      exitConfirmationDialog().show();
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
      ),
    );
  }
}
