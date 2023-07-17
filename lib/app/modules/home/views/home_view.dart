import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:smartsocket/app/theme/color_theme.dart';
import 'package:smartsocket/app/theme/font_theme.dart';
import 'package:smartsocket/app/widget/socketcard_widget.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
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
                          'Halo',
                          style: FontTheme.regular.copyWith(fontSize: 12.sp),
                        ),
                        Text(
                          'Andi Lestianto',
                          style: FontTheme.bold.copyWith(fontSize: 16.sp),
                        )
                      ],
                    ),
                    Image.asset(
                      'assets/image/img-profile.png',
                      width: 48.w,
                      height: 48.w,
                    )
                  ],
                ),
                SizedBox(
                  height: 24.w,
                ),
                Container(
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      border:
                          Border.all(width: 2.w, color: ClrTheme.clrWhiteGray)),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(8.w),
                        height: 40.w,
                        width: 40.w,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: ClrTheme.clrGold),
                        child: SvgPicture.asset('assets/icon/ic-sunfog.svg'),
                      ),
                      SizedBox(
                        width: 16.w,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Selamat Pagi',
                            style: FontTheme.regular.copyWith(fontSize: 12.sp),
                          ),
                          Text(
                            'Selasa, 18 Mei 2023',
                            style: FontTheme.bold.copyWith(fontSize: 12.sp),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 24.w,
                ),
                if (_.mainSocket != null)
                  Expanded(
                    child: GridView(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 24.w,
                            mainAxisSpacing: 24.w),
                        children: [
                          SocketCardWidget(
                            socket: _.mainSocket!.socket1,
                            onTap: () {
                              _.setSocketValue(socketName: 'socket1');
                            },
                          ),
                          SocketCardWidget(
                            socket: _.mainSocket!.socket2,
                            onTap: () {
                              _.setSocketValue(socketName: 'socket2');
                            },
                          ),
                          SocketCardWidget(
                            socket: _.mainSocket!.socket3,
                            onTap: () {
                              _.setSocketValue(socketName: 'socket3');
                            },
                          ),
                          SocketCardWidget(
                            socket: _.mainSocket!.socket4,
                            onTap: () {
                              _.setSocketValue(socketName: 'socket4');
                            },
                          ),
                        ]),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
