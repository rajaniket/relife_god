import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:relife_god/pages/list_users_page.dart';
import 'package:relife_god/provider/login_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  String? token;
  String? id;
  Future<String?> getsharedToken() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    return sharedPreferences.getString('token');
  }

  Future<String?> getsharedTokenId() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    return sharedPreferences.getString('userId');
  }

  getToken() async {
    token = await getsharedToken();
    id = await getsharedTokenId();
  }

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback(
      (timeStamp) async {
        token = await getsharedToken().whenComplete(() {});
        id = await getsharedTokenId();
        if (token == null) {
          var loginProvider =
              Provider.of<LoginProvider>(context, listen: false);
          loginProvider.requestModel.email = "yash@relife.co.in";
          loginProvider.requestModel.password = "Habits#250";
          bool result = await loginProvider.login(context);
          if (result == true) {
            log("login successful");
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (_) => const ListUserPage()));
          }
        } else {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => const ListUserPage()));
        }
      },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        toolbarHeight: 0,
        elevation: 0,
        // systemOverlayStyle: const SystemUiOverlayStyle(
        //   statusBarColor: Color(0xffFA8A3C),

        //   statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
        //   statusBarBrightness: Brightness.light, // For iOS (dark icons)
        // ),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    log("welcome page");
    return Column(
      children: [
        Expanded(
          child: Container(
            decoration: const BoxDecoration(
                // gradient: LinearGradient(
                //   begin: Alignment.topCenter,
                //   end: Alignment.bottomCenter,
                //   colors: [
                //     Color(0xffFF878B),
                //     Color(0xffF08A5D),
                //   ],
                // ),
                color: Color(0xffFA8A3C)),
            child: Center(
                child: Text("relife",
                    style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.white))),
          ),
        ),
      ],
    );
  }
}
