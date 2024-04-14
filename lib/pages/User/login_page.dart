import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pet_care/module/user/token_model.dart';
import 'package:pet_care/utils/app_constants.dart';
import '../../connect/connect_server.dart';
import '../../module/response/response_model.dart';
import '../../module/user/user_model.dart';
import '../../widgets/text_field.dart';

class LoginPage extends StatelessWidget {
  TextEditingController idController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailConfirmController = TextEditingController();
  String id = '';
  static final storage = FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=> FocusScope.of(context).unfocus(),
      child: Container(
        child: Container(
          width: MediaQuery.of(context).size.width * 1,
          height: MediaQuery.of(context).size.height * 1,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/BGI.png'), fit: BoxFit.fill),
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 50.h,),
                  Container(
                    height: 150.h,
                    width: 150.w,
                    margin: EdgeInsets.only(top: 150.h, ),
                    decoration: BoxDecoration(
                      color: Colors.teal,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        '로그인',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 40.sp,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 80.h,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 37.w, right: 37.w), //바깥쪽 여백
                    child: CustomTextField(
                      controller: idController,
                      text: 'Email',
                      hintText: '아이디 입력',
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 37.w, right: 37.w), //바깥쪽 여백
                    child: CustomTextField(
                      controller: passwordController,
                      text: 'Password',
                      hintText: '비밀번호 입력',
                      password: true,
                    ),
                  ),
                  SizedBox(height: 50.h),
                  GestureDetector(
                    onTap: () async {
                      if (idController.text.length < 6 ||
                          !appConstants.emailRegExp.hasMatch(idController.text)) {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              title: Text('Email Error'),
                              content:
                              Text('영문자로 시작하고 숫자를 포함하여 총 6~20자 입력하시오'),
                              actions: <Widget>[
                                TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: Text('Ok')),
                              ],
                            ));
                        idController.clear();
                      } else if (passwordController.text.length < 8 ||
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
                                    onPressed: () => Navigator.pop(context),
                                    child: Text('Ok')),
                              ],
                            )
                        );
                        passwordController.clear();
                      } else {
                        var user = ConfirmUserModel(idController.text, passwordController.text).toJson();
                        var response = await Post().login(user);
                        if(response.statusCode == 201 ) {
                          GetLoginTokenModel res_token = GetLoginTokenModel.fromJson(jsonDecode(response.body));
                          await storage.write(key: 'refresh', value: res_token.data.refreshToken);
                          await storage.write(key: 'access', value: res_token.data.accessToken);
                          Navigator.pushNamed(context, '/pageRouter');
                        } else {
                          print(response.body.toString());
                          ResIsBoolFail res =  ResIsBoolFail.fromJson(jsonDecode(response.body));
                          showDialog(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                title: Text('${res.message}'),
                                content: Text('다시 입력하시오'),
                                actions: <Widget>[
                                  TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: Text('Ok')),
                                ],
                              )
                          );
                          if(res.message.toString() == '비밀번호가 일치하지 않습니다'){
                            passwordController.clear();
                          } else{
                            idController.clear();
                          }
                        }
                      }
                    },
                    child: Container(
                      height: 65.h,
                      width: 400.w,
                      child: Center(
                        child: Text(
                          '로그인',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      margin: EdgeInsets.only(left: 37.w, right: 37.w),
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.7),
                              spreadRadius: 0,
                              blurRadius: 5.0,
                              offset:
                              Offset(0, 10), // changes position of shadow
                            ),
                          ],
                          color: Colors.teal,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/signUp');
                    },
                    child: Container(
                      height: 65.h,
                      width: 400.w,
                      child: Center(
                        child: Text(
                          '회원가입',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      margin: EdgeInsets.only(left: 37.w, right: 37.w),
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.7),
                              spreadRadius: 0,
                              blurRadius: 5.0,
                              offset: Offset(0, 10), // changes position of shadow
                            ),
                          ],
                          color: Colors.teal,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            title: Text('이메일을 입력하시오.'),
                            content: CustomTextField(
                              controller: emailConfirmController,
                              text: '이메일 확인',
                              hintText: '이메일 입력',
                            ),
                            actions: <Widget>[
                              TextButton(
                                  onPressed: () => Na현vigator.pop(context),
                                  child: Text('Ok')),
                            ],
                          )
                      );
                    },
                    child: Text(
                      "비밀번호찾기",
                      style: TextStyle(
                        fontSize: 20.sp,
                        decoration: TextDecoration.underline,
                      ),
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

