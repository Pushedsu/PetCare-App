import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_care/utils/app_constants.dart';
import 'package:pet_care/widgets/text_field.dart';
import '../../connect/connect_server.dart';
import '../../module/response/response_model.dart';
import '../../module/user/user_model.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController idController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  String inputName = '';
  String nameButtonText = 'Unfinished';

  @override
  void dispose() {
    nameController.clear();
    idController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: GestureDetector(
          onTap: ()=>FocusScope.of(context).unfocus(),
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          margin: EdgeInsets.only(left: 37.w, right: 37.w), //바깥쪽 여백
                          alignment: Alignment.centerLeft,
                          child: Container(
                            width: 50.w,
                            height: 50.h,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.7),
                                  spreadRadius: 0,
                                  blurRadius: 5.0,
                                  offset: Offset(0, 10),
                                ),
                              ], color: Colors.teal,
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
                      SizedBox(
                        height: 30.h,
                      ),
                      Container(
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                            color: Colors.teal,
                            fontWeight: FontWeight.bold,
                            fontSize: 60.sp,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 90.h,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 37.w, right: 37.w), //바깥쪽 여백
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Create Your Account',
                          style: TextStyle(
                            color: Colors.teal,
                            fontWeight: FontWeight.bold,
                            fontSize: 25.sp,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      //별명필드
                      Container(
                        margin: EdgeInsets.only(left: 37.w, right: 37.w), //바깥쪽 여백
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 200.w,
                              height: 60.h,
                              child: CustomTextField(
                                controller: nameController,
                                text: 'Name',
                                hintText: '이름 입력',
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                if (nameController.text.length < 2 &&
                                    !appConstants.nameRegExp
                                        .hasMatch(nameController.text)) {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) => AlertDialog(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(10.0),
                                        ),
                                        title: Text('Name Error'),
                                        content:
                                        Text('2자 이상 20자 이하, 영어 또는 숫자로 구성하시오'),
                                        actions: <Widget>[
                                          TextButton(
                                              onPressed: () =>
                                                  Navigator.pop(context),
                                              child: Text('Ok')),
                                        ],
                                      ));
                                  nameController.clear();
                                  nameButtonText = 'Unfinished';
                                } else {
                                  inputName = nameController.text;
                                  setState(() {
                                    nameButtonText = 'Done';
                                  });
                                }
                              },
                              child: Container(
                                width: 130.w,
                                height: 60.h,
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
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                                child: Center(
                                  child: Text(
                                    nameButtonText,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 40.h,),
                      //email 필드
                      Container(
                        margin: EdgeInsets.only(left: 37.w, right: 37.w), //바깥쪽 여백
                        child: CustomTextField(
                          controller: idController,
                          text: 'Email',
                          hintText: '아이디 입력',
                        ),
                      ),
                      SizedBox(height: 40.h,),
                      //비밀번호 필드
                      Container(
                        margin: EdgeInsets.only(left: 37.w, right: 37.w), //바깥쪽 여백
                        child: CustomTextField(
                          controller: passwordController,
                          text: 'Password',
                          hintText: '비밀번호 입력',
                          password: true,
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      //비밀번호 재입력 필드
                      Container(
                        margin: EdgeInsets.only(left: 37.w, right: 37.w), //바깥쪽 여백
                        child: CustomTextField(
                          controller: confirmPasswordController,
                          text: 'Confirm Password',
                          hintText: '비밀번호 재입력',
                          password: true,
                        ),
                      ),
                      SizedBox(height: 20.h,),
                      //sign up 버튼
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
                                        onPressed: () => Navigator.pop(context),
                                        child: Text('Ok')),
                                  ],
                                ));
                            passwordController.clear();
                            confirmPasswordController.clear();
                          } else {
                            var user = UserAccountModel(idController.text, nameController.text, passwordController.text).toJson();
                            var response = await Post().signUp(user);
                            if(response.statusCode == 201 ) {
                              ResIsBoolSuccessModel res = ResIsBoolSuccessModel.fromJson(jsonDecode(response.body));
                              print('sign Up api 성공 여부: ${res.success}');
                              Navigator.pushNamed(context, '/login');
                            } else {
                              ResIsBoolFail res = ResIsBoolFail.fromJson(jsonDecode(response.body));
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
                              idController.clear();
                              nameController.clear();
                              passwordController.clear();
                              confirmPasswordController.clear();
                            }
                          }
                        },
                        child: Container(
                          margin: EdgeInsets.only(left: 37.w, right: 37.w), //바깥쪽 여백
                          child: Container(
                            height: 65.h,
                            width: 400.w,
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
                                borderRadius: BorderRadius.all(Radius.circular(10))
                            ),
                            child: Center(
                              child: Text(
                                'Sign Up',
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
            ),
          ),
        )
    );
  }
}


