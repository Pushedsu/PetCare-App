import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pet_care/utils/app_constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pet_care/module/user/user_model.dart';
import 'package:provider/provider.dart';

import '../../connect/connect_server.dart';
import '../../module/response/response_model.dart';
import '../../providers/user_info_provider.dart';
import '../../widgets/text_field.dart';

class ChangePasswordPage extends StatelessWidget {
  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  String id = '';
  static final storage = FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    UserInfoProvider userInfoProvider = Provider.of<UserInfoProvider>(context);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Container(
          width: MediaQuery.of(context).size.width * 1,
          height: MediaQuery.of(context).size.height * 1,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/BGI.png'), fit: BoxFit.fill),
          ),
          child: SafeArea(
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: SingleChildScrollView(
                physics: NeverScrollableScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 1,
                      child: Container(
                        margin: EdgeInsets.only(left: 37.w, right: 37.w),
                        alignment: Alignment.centerLeft,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            height: 60.h,
                            width: 60.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.7),
                                  spreadRadius: 0,
                                  blurRadius: 5.0,
                                  offset: Offset(0, 10),
                                ),
                              ],
                              color: Colors.teal,
                            ),
                            child: Center(
                              child: Icon(
                                Icons.arrow_back_ios_outlined,
                                color: Colors.white,
                                size: 35.sp,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 80.h,
                    ),
                    Container(
                      child: Text(
                        '비밀번호 변경',
                        style: TextStyle(
                          color: Colors.teal,
                          fontWeight: FontWeight.bold,
                          fontSize: 60.sp,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 80.h,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 37.w, right: 37.w), //바깥쪽 여백
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '기존 비밀번호를 입력하시오.',
                        style: TextStyle(
                          color: Colors.teal,
                          fontWeight: FontWeight.bold,
                          fontSize: 25.sp,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 37.w, right: 37.w), //바깥쪽 여백
                      child: CustomTextField(
                        controller: currentPasswordController,
                        text: '기존 비밀번호',
                        hintText: '비밀번호 입력',
                        password: true,
                      ),
                    ),
                    SizedBox(
                      height: 60.h,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 37.w, right: 37.w), //바깥쪽 여백
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '새 비밀번호를 입력하시오.',
                        style: TextStyle(
                          color: Colors.teal,
                          fontWeight: FontWeight.bold,
                          fontSize: 25.sp,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 37.w, right: 37.w), //바깥쪽 여백
                      child: CustomTextField(
                        controller: passwordController,
                        text: '새 비밀번호',
                        hintText: '비밀번호 입력',
                        password: true,
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 37.w, right: 37.w), //바깥쪽 여백
                      child: CustomTextField(
                        controller: confirmPasswordController,
                        text: '비밀번호 확인',
                        hintText: '비밀번호 입력',
                        password: true,
                      ),
                    ),
                    SizedBox(
                      height: 60.h,
                    ),
                    GestureDetector(
                      onTap: () async {
                        if (passwordController.text.length < 8 ||
                            !appConstants.passwordRegExp
                                .hasMatch(passwordController.text)) {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    title: Text('Password Error'),
                                    content: Text('8 ~ 16자 영문, 숫자 조합으로 입력하시오'),
                                    actions: <Widget>[
                                      TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: Text('Ok')),
                                    ],
                                  ));
                          passwordController.clear();
                          confirmPasswordController.clear();
                        } else if (passwordController.text !=
                            confirmPasswordController.text) {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    title: Text('비밀번호 불일치'),
                                    content: Text('동일한 비밀번호를 입력하시오.'),
                                    actions: <Widget>[
                                      TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: Text('Ok')),
                                    ],
                                  ));
                          passwordController.clear();
                          confirmPasswordController.clear();
                        } else {
                          var posting = UserUpdatePasswordModel(
                              userInfoProvider.getObjId(),
                              passwordController.text,
                              currentPasswordController.text)
                              .toJson();
                          var response = await Post().updatePassword(posting);
                          if (response.statusCode == 201) {
                            ResIsBoolSuccessModel post =
                            ResIsBoolSuccessModel.fromJson(
                                jsonDecode(response.body));
                            print('비밀번호 재설정 성공! ${post.success}');
                            Navigator.pushReplacementNamed(
                                context, '/pageRouter');
                          } else {
                            ResIsBoolFailList post = ResIsBoolFailList.fromJson(
                                jsonDecode(response.body));
                            showDialog(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  title: Text('다시 입력하시오'),
                                  content: Text('${post.message![0]}...'),
                                  actions: <Widget>[
                                    TextButton(
                                        onPressed: () =>
                                            Navigator.pop(context),
                                        child: Text('Ok')),
                                  ],
                                ));
                          }
                          confirmPasswordController.clear();
                          currentPasswordController.clear();
                          passwordController.clear();
                        }
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: 37.w, right: 37.w),
                        //바깥쪽 여백
                        child: Container(
                          height: 65.h,
                          width: 400.w,
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.7),
                                  spreadRadius: 0,
                                  blurRadius: 5.0,
                                  offset: Offset(
                                      0, 10), // changes position of shadow
                                ),
                              ],
                              color: Colors.teal,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: Center(
                            child: Text(
                              '변경 완료',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ), // ,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
