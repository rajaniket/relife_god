// ignore_for_file: prefer_const_literals_to_create_immutables

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:relife_god/model/get_all_user_details_model.dart';
import 'package:relife_god/pages/habit_detail.dart';
import 'package:relife_god/services/get_all_users_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ListUserPage extends StatefulWidget {
  const ListUserPage({
    Key? key,
  }) : super(key: key);

  @override
  State<ListUserPage> createState() => _ListUserPageState();
}

class _ListUserPageState extends State<ListUserPage> {
  Detail? currentUserDetail;
  String? selectedHabitId, selectedHabitName;
  late final List<Detail>?
      listOfUsers; // it is imp to make it final otherwise drop down will not work
  bool isLoading = true;
  Future<String?> getsharedToken() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    return sharedPreferences.getString('token');
  }

  Future<GetAllUserResponseModel?> getAllUser() async {
    var token = await getsharedToken();
    GetAllUserResponseModel? getAllUserResponseModel =
        await GetAllUsersService().getAllUsers(token!, context);
    // for (int i = 0; i < getAllUserResponseModel!.details!.length; i++) {
    //   UserDetail userDetail;
    //   // userDetail.firstName = getAllUserResponseModel
    //   //  allUsersDetail.add(UserDetail())
    // }
    listOfUsers = getAllUserResponseModel!.details;
    log("isLoading : $isLoading");
    isLoading = false;
    setState(() {});
    log("isLoading : $isLoading");
    return getAllUserResponseModel;
  }

  @override
  void initState() {
    getAllUser();
    super.initState();
    // getAllUser();
  }

  @override
  Widget build(BuildContext context) {
    log("list_user");
    log("isLoading widget : $isLoading");
    return Scaffold(
      backgroundColor: const Color(0xffF7F6F2),
      appBar: AppBar(),
      body: !isLoading
          ? SingleChildScrollView(
              child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 30.h),
                  child: Center(
                    child: Container(
                      width: 336.w,
                      height: 60.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: DropdownButton<Detail>(
                            onTap: () {
                              currentUserDetail = null;
                              selectedHabitId = null;
                              setState(() {});
                            },
                            borderRadius: BorderRadius.circular(20),
                            focusColor: Colors.grey,
                            value: currentUserDetail,
                            hint: const Text('select user'),
                            underline: const SizedBox(),
                            items: listOfUsers!.map((value) {
                              return DropdownMenuItem<Detail>(
                                value: value,
                                child: Text(
                                    value.firstName! + " " + value.lastName!),
                              );
                            }).toList(),
                            onChanged: (val) {
                              currentUserDetail = val!;
                              print(currentUserDetail!.firstName);
                              setState(() {});
                            }),
                      ),
                    ),
                  ),
                ),
                if (currentUserDetail != null)
                  HabitDropdown(
                    currentUserDetail: currentUserDetail!,
                    callBack: (id, name) {
                      selectedHabitId = id;
                      selectedHabitName = name;

                      setState(() {});
                    },
                  ),
                SizedBox(
                  height: 50.h,
                ),
                if (selectedHabitId != null)
                  ElevatedButton(
                    onPressed: () {
                      print(currentUserDetail!.firstName);
                      print(selectedHabitId);
                      print(selectedHabitName);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => HabitDetailPage(
                                    userId: currentUserDetail!.id!,
                                    habitId: selectedHabitId!,
                                    habitName: selectedHabitName!,
                                    userFirstName:
                                        currentUserDetail!.firstName!,
                                    userAvtar:
                                        currentUserDetail!.profilePicture!,
                                  )));
                    },
                    child: const Text("proceed"),
                  ),
              ],
            ))
          : const Center(child: CircularProgressIndicator()),
    );
  }
}

class HabitDropdown extends StatefulWidget {
  HabitDropdown(
      {Key? key, required this.currentUserDetail, required this.callBack})
      : super(key: key);
  final Detail currentUserDetail;
  final Function(String habitId, String habitName)? callBack;

  @override
  State<HabitDropdown> createState() => _HabitDropdownState();
}

class _HabitDropdownState extends State<HabitDropdown> {
  String? selectedHabitId, selectedHabitName;

  @override
  Widget build(BuildContext context) {
    log("drop down");
    return Padding(
      padding: EdgeInsets.only(top: 30.h),
      child: Center(
        child: Container(
          width: 336.w,
          height: 60.h,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: DropdownButton<String>(
                borderRadius: BorderRadius.circular(20),
                focusColor: Colors.grey,
                value: selectedHabitId,
                hint: const Text('select habit'),
                underline: const SizedBox(),
                items: widget.currentUserDetail.habits!.map((value) {
                  String habitname = "";
                  switch (value.habitDetails) {
                    case '620d605f39e03e00128b6f43': //reading

                      habitname = 'reading';
                      break;
                    case '620d60f539e03e00128b6f48': //running

                      habitname = 'running';
                      break;
                    case '620d5fbc39e03e00128b6f3d': //exercise

                      habitname = 'exercise';
                      break;
                  }

                  return DropdownMenuItem<String>(
                    value: value.habitDetails,
                    child: Text(habitname),
                  );
                }).toList(),
                onChanged: (val) {
                  switch (val) {
                    case '620d605f39e03e00128b6f43': //reading

                      selectedHabitName = 'reading';
                      break;
                    case '620d60f539e03e00128b6f48': //running

                      selectedHabitName = 'running';
                      break;
                    case '620d5fbc39e03e00128b6f3d': //exercise

                      selectedHabitName = 'exercise';
                      break;
                  }
                  selectedHabitId = val!;

                  if (widget.callBack != null) {
                    widget.callBack!(val, selectedHabitName!);
                  }
                  setState(() {});
                }),
          ),
        ),
      ),
    );
  }
}
