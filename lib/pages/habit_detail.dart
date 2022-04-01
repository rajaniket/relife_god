import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:relife_god/model/user_habits_model.dart';
import 'package:relife_god/services/user_habits_service.dart';
import 'package:relife_god/widget/full_calendar_widget.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class HabitDetailPage extends StatefulWidget {
  const HabitDetailPage(
      {Key? key,
      required this.userId,
      required this.habitId,
      required this.habitName,
      required this.userFirstName,
      required this.userAvtar})
      : super(key: key);
  final String userId, habitId, habitName, userFirstName, userAvtar;

  @override
  State<HabitDetailPage> createState() => _HabitDetailPageState();
}

class _HabitDetailPageState extends State<HabitDetailPage> {
  ScreenshotController screenShot_1 = ScreenshotController();
  ScreenshotController screenShot_2 = ScreenshotController();
  bool isLoading = true;
  late final Details userHabitDetail;
  Future<String?> getsharedToken() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    return sharedPreferences.getString('token');
  }

  Future<Details?> getUserHabits() async {
    var token = await getsharedToken();
    UserAllHabitsModel? getAllHabitsOfUser =
        await GetUserHabitsService().getUserHabits(token!, widget.userId);
    for (int i = 0; i < getAllHabitsOfUser!.details!.length; i++) {
      if (getAllHabitsOfUser.details![i].habitDetails!.id == widget.habitId) {
        userHabitDetail = getAllHabitsOfUser.details![i];
        break;
      }
    }
    isLoading = false;
    setState(() {});
    return userHabitDetail;
  }

  @override
  void initState() {
    getUserHabits();
    super.initState();
    // getAllUser();
  }

  void _takeScreenshotAndSave(ScreenshotController screenshotController) async {
    final imageFile = await screenshotController.capture(
        delay: const Duration(milliseconds: 10));
    if (imageFile != null) {
      ImageGallerySaver.saveImage(imageFile);
    }
  }

  void _takeScreenshotAndShare(
      ScreenshotController screenshotController) async {
    final imageFile = await screenshotController.capture(
        delay: const Duration(milliseconds: 10));
    if (imageFile != null) {
      final directory = await getApplicationDocumentsDirectory();
      final imagePath = await File('${directory.path}/image.png').create();
      await imagePath.writeAsBytes(imageFile);
      Share.shareFiles(
        [imagePath.path],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF7F6F2),
      appBar: AppBar(
          backgroundColor: const Color(0xffF7F6F2),
          elevation: 0,
          automaticallyImplyLeading: false,
          title: Text(
            widget.habitName,
            style: TextStyle(
                overflow: TextOverflow.ellipsis,
                color: Colors.black,
                fontSize: 24.sp,
                fontWeight: FontWeight.w500),
          ),
          leading: CupertinoButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back_ios_rounded,
              color: Colors.black,
            ),
          )),
      body: RefreshIndicator(
        onRefresh: () async {
          // await getAllUser();
        },
        child: !isLoading
            ? SingleChildScrollView(
                child: Padding(
                padding: const EdgeInsets.all(25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "friend",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    GestureDetector(
                      onTap: () {
                        launch(
                            "https://wa.me/${userHabitDetail.accountabilityPartnerPhoneNumber}");
                      },
                      child: Text(
                        "${userHabitDetail.accountabilityPartnerName!.toLowerCase()} - ${userHabitDetail.accountabilityPartnerPhoneNumber}",
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      "first update",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 16),
                    Screenshot(
                      controller: screenShot_1,
                      child: Container(
                        color: Colors.white, //const Color(0xffF7F6F2),

                        // : 270.h,
                        // width: 270..w,
                        padding: const EdgeInsets.fromLTRB(16, 18, 14, 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "${widget.userFirstName.toLowerCase()} has decided to \nbuild a habit of ${widget.habitName}",
                              style: TextStyle(
                                color: const Color(0xff062540),
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(
                              height: 15.33.h,
                            ),
                            Text(
                              "here’s what ${widget.userFirstName.toLowerCase()} says",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(
                              height: 18.55.h,
                            ),
                            SvgPicture.asset(
                              "assets/svg/quote.svg",
                              height: 16.26.r,
                            ),
                            SizedBox(
                              height: 10.22.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Container(
                                    height: 33.44.r,
                                    width: 33.44.r,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1.39.r,
                                          color: const Color(0xffFA8A3C)),
                                      shape: BoxShape.circle,
                                    ),
                                    child: ClipRRect(
                                      borderRadius:
                                          BorderRadius.circular(100.r),
                                      child: Image.network(
                                        'https://relife.co.in/api/${widget.userAvtar}',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.only(
                                        left: 8, right: 0),

                                    // width: 200.w,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        RichText(
                                          maxLines: 3,
                                          text: TextSpan(
                                            style: TextStyle(
                                                fontSize: 13.sp,
                                                color: Colors.black,
                                                fontFamily: 'Poppins',
                                                overflow:
                                                    TextOverflow.ellipsis),
                                            children: [
                                              TextSpan(
                                                text: 'i\'ll do this for ',
                                                style:
                                                    TextStyle(fontSize: 13.sp),
                                              ),
                                              TextSpan(
                                                text:
                                                    "${userHabitDetail.daysPerMonth} days this month 🎯",
                                                style: TextStyle(
                                                    fontSize: 13.sp,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ],
                                          ),
                                        ),
                                        RichText(
                                          maxLines: 3,
                                          text: TextSpan(
                                            style: TextStyle(
                                                fontSize: 13.sp,
                                                color: Colors.black,
                                                fontFamily: 'Poppins',
                                                overflow:
                                                    TextOverflow.ellipsis),
                                            children: [
                                              TextSpan(
                                                text: 'if i don\'t, ',
                                                style: TextStyle(
                                                    fontSize: 13.sp,
                                                    overflow:
                                                        TextOverflow.ellipsis),
                                              ),
                                              TextSpan(
                                                text:
                                                    "i'll ${userHabitDetail.punishment}" +
                                                        ' 🤐',
                                                style: TextStyle(
                                                    fontSize: 13.sp,
                                                    fontWeight: FontWeight.w600,
                                                    overflow:
                                                        TextOverflow.ellipsis),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 16,
                                        ),
                                        Text(
                                          '${userHabitDetail.accountabilityPartnerName!.toLowerCase()} will check this',
                                          style: TextStyle(
                                              fontSize: 13.sp,
                                              fontWeight: FontWeight.w400,
                                              overflow: TextOverflow.ellipsis),
                                          maxLines: 2,
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Center(
                                child: SvgPicture.asset(
                                    "assets/svg/relife_logo.svg")),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: CustomTextButton(
                        message: "download",
                        borderRadius: 30.r,
                        buttonColor: const Color(0xffDF532B),
                        elevation: 0,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        onTap: () {
                          _takeScreenshotAndSave(screenShot_1);
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("image saved successfully"),
                            duration: Duration(seconds: 2),
                          ));
                        },
                        buttonSize: Size(239.w, 47.0.h),
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: CustomTextButton(
                        message: "share",
                        borderRadius: 30.r,
                        buttonColor: const Color(0xffDF532B),
                        elevation: 0,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        onTap: () {
                          _takeScreenshotAndShare(screenShot_1);
                        },
                        buttonSize: Size(239.w, 47.0.h),
                      ),
                    ),
                    const SizedBox(
                      height: 37,
                    ),
                    Text(
                      "weekly update",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    Text(
                      "week - 1",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    Screenshot(
                      controller: screenShot_2,
                      child: Container(
                          color: Colors.white, //const Color(0xffF7F6F2),
                          padding: const EdgeInsets.all(18),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 2),
                                child: Text(
                                  "${widget.userFirstName.toLowerCase()}'s progress",
                                  style: TextStyle(
                                    color: const Color(0xff062540),
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 3),
                                child: Text(
                                  widget.habitName,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              const SizedBox(
                                height: 11,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 0),
                                child: FullCalendar(
                                  userHabitDetail: userHabitDetail,
                                ),
                              ),
                              SizedBox(
                                height: 21.h,
                              ),
                              SvgPicture.asset(
                                "assets/svg/quote.svg",
                                height: 16.26.r,
                              ),
                              SizedBox(
                                height: 10.22.h,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 12.0),
                                    child: Container(
                                      height: 33.44.r,
                                      width: 33.44.r,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 1.39.r,
                                            color: const Color(0xffFA8A3C)),
                                        shape: BoxShape.circle,
                                      ),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(100.r),
                                        child: Image.network(
                                          'https://relife.co.in/api/${widget.userAvtar}',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      padding: const EdgeInsets.only(
                                          left: 8, right: 0),

                                      // width: 200.w,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          RichText(
                                            maxLines: 3,
                                            text: TextSpan(
                                              style: TextStyle(
                                                  fontSize: 13.sp,
                                                  color: Colors.black,
                                                  fontFamily: 'Poppins',
                                                  overflow:
                                                      TextOverflow.ellipsis),
                                              children: [
                                                TextSpan(
                                                  text: 'i\'ll do this for ',
                                                  style: TextStyle(
                                                      fontSize: 13.sp),
                                                ),
                                                TextSpan(
                                                  text:
                                                      "${userHabitDetail.daysPerMonth} days this month 🎯",
                                                  style: TextStyle(
                                                      fontSize: 13.sp,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ],
                                            ),
                                          ),
                                          RichText(
                                            maxLines: 3,
                                            text: TextSpan(
                                              style: TextStyle(
                                                  fontSize: 13.sp,
                                                  color: Colors.black,
                                                  fontFamily: 'Poppins',
                                                  overflow:
                                                      TextOverflow.ellipsis),
                                              children: [
                                                TextSpan(
                                                  text: 'if i don\'t, ',
                                                  style: TextStyle(
                                                      fontSize: 13.sp,
                                                      overflow: TextOverflow
                                                          .ellipsis),
                                                ),
                                                TextSpan(
                                                  text:
                                                      "i'll ${userHabitDetail.punishment}" +
                                                          ' 🤐',
                                                  style: TextStyle(
                                                      fontSize: 13.sp,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      overflow: TextOverflow
                                                          .ellipsis),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 16,
                                          ),
                                          Text(
                                              '${userHabitDetail.toReachYourGoal!} days to reach goal',
                                              style: TextStyle(
                                                  fontSize: 13.sp,
                                                  fontWeight: FontWeight.w500,
                                                  overflow:
                                                      TextOverflow.ellipsis))
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 14,
                              ),
                              Center(
                                  child: SvgPicture.asset(
                                      "assets/svg/relife_logo.svg")),
                            ],
                          )),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: CustomTextButton(
                        message: "download",
                        borderRadius: 30.r,
                        buttonColor: const Color(0xffDF532B),
                        elevation: 0,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        onTap: () {
                          _takeScreenshotAndSave(screenShot_2);
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("image saved successfully"),
                            duration: Duration(seconds: 2),
                          ));
                        },
                        buttonSize: Size(239.w, 47.0.h),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: CustomTextButton(
                        message: "share",
                        borderRadius: 30.r,
                        buttonColor: const Color(0xffDF532B),
                        elevation: 0,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        onTap: () {
                          _takeScreenshotAndShare(screenShot_2);
                        },
                        buttonSize: Size(239.w, 47.0.h),
                      ),
                    ),
                  ],
                ),
              ))
            : const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}

class CustomTextButton extends StatelessWidget {
  final String message;
  final double fontSize;
  final FontWeight fontWeight;
  final double elevation;
  final Size buttonSize;
  final double borderRadius;
  final Color buttonColor;
  final VoidCallback onTap;

  const CustomTextButton({
    Key? key,
    required this.message,
    required this.fontSize,
    required this.fontWeight,
    required this.elevation,
    required this.buttonSize,
    required this.borderRadius,
    required this.buttonColor,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      child: Text(
        message,
        style: TextStyle(fontSize: fontSize, fontWeight: fontWeight),
      ),
      style: ElevatedButton.styleFrom(
        primary: buttonColor,
        elevation: elevation,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        minimumSize: buttonSize,
      ),
    );
  }
}
