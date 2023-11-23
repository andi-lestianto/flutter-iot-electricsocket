import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:smartsocket/app/helper/datetime_helper.dart';
import 'package:smartsocket/app/modules/notification/dialog/configurenotification_dialog.dart';
import 'package:smartsocket/app/theme/color_theme.dart';
import 'package:smartsocket/app/theme/font_theme.dart';
import 'package:smartsocket/app/widget/socketcard_widget.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
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
                          'Hello',
                          style: FontTheme.regular.copyWith(fontSize: 12.sp),
                        ),
                        Text(
                          _.userModel == null
                              ? 'User'
                              : _.userModel!.nama!.toString(),
                          style: FontTheme.bold.copyWith(fontSize: 16.sp),
                        )
                      ],
                    ),
                    GestureDetector(
                        onTap: () {
                          configureUserUpdate().dialogShow();
                        },
                        child: _.userModel == null
                            ? Container(
                                padding: EdgeInsets.all(8.w),
                                height: 48.w,
                                width: 48.w,
                                child: SvgPicture.asset(
                                  'assets/icon/ic-user.svg',
                                ),
                              )
                            : ClipOval(
                                child: SizedBox(
                                  height: 48.w,
                                  width: 48.w,
                                  child: Image.file(
                                    File(_.userModel!.profilePict.toString()),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ))
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
                          GestureDetector(
                            onTap: () {
                              print(_.mainSocket);
                            },
                            child: Text(
                              DateTimeHelper().getGreeting(),
                              style:
                                  FontTheme.regular.copyWith(fontSize: 12.sp),
                            ),
                          ),
                          Text(
                            DateTimeHelper().getDateNowId(),
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
                        physics: BouncingScrollPhysics(),
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
                            onEditTap: () {
                              _.setTextController(
                                  text: _.mainSocket!.socket1!.description
                                      .toString());
                              configureSocketDesc().dialogShow(context,
                                  socketId: 'Socket 1',
                                  socket: _.mainSocket!.socket1!,
                                  textEditingController: _.labelController,
                                  onSave: () {
                                _.setSocketLabel(
                                    socketName: 'socket1',
                                    labelName: _.labelController.text);
                              });
                            },
                          ),
                          SocketCardWidget(
                            socket: _.mainSocket!.socket2,
                            onTap: () {
                              _.setSocketValue(socketName: 'socket2');
                            },
                            onEditTap: () {
                              _.setTextController(
                                  text: _.mainSocket!.socket2!.description
                                      .toString());

                              configureSocketDesc().dialogShow(context,
                                  socketId: 'Socket 2',
                                  socket: _.mainSocket!.socket2!,
                                  textEditingController: _.labelController,
                                  onSave: () {
                                _.setSocketLabel(
                                    socketName: 'socket2',
                                    labelName: _.labelController.text);
                              });
                            },
                          ),
                          SocketCardWidget(
                            socket: _.mainSocket!.socket3,
                            onTap: () {
                              _.setSocketValue(socketName: 'socket3');
                            },
                            onEditTap: () {
                              _.setTextController(
                                  text: _.mainSocket!.socket3!.description
                                      .toString());

                              configureSocketDesc().dialogShow(context,
                                  socketId: 'Socket 3',
                                  socket: _.mainSocket!.socket3!,
                                  textEditingController: _.labelController,
                                  onSave: () {
                                _.setSocketLabel(
                                    socketName: 'socket3',
                                    labelName: _.labelController.text);
                              });
                            },
                          ),
                          SocketCardWidget(
                            socket: _.mainSocket!.socket4,
                            onTap: () {
                              _.setSocketValue(socketName: 'socket4');
                            },
                            onEditTap: () {
                              _.setTextController(
                                  text: _.mainSocket!.socket4!.description
                                      .toString());

                              configureSocketDesc().dialogShow(context,
                                  socketId: 'Socket 4',
                                  socket: _.mainSocket!.socket4!,
                                  textEditingController: _.labelController,
                                  onSave: () {
                                _.setSocketLabel(
                                    socketName: 'socket4',
                                    labelName: _.labelController.text);
                              });
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
