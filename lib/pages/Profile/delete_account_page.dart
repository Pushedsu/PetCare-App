import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pet_care/widgets/text_field.dart';
import 'package:pet_care/utils/app_constants.dart';
import '../../connect/connect_server.dart';
import '../../module/response/response_model.dart';
import '../../module/user/user_model.dart';

class DeleteAccountPage extends StatelessWidget {
  static final storage = FlutterSecureStorage();
  dynamic access_token = null;
  TextEditingController passwordController = TextEditingController();

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
          child: SafeArea(
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 1,
                    child: Container(
                      margin: EdgeInsets.only(left: 37.w, right: 37.w),
                      alignment: Alignment.centerLeft,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushReplacementNamed(context, '/pageRouter');
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
                  ),
                  SizedBox(height: 160.h,),
                  Container(
                    margin: EdgeInsets.only(left: 37.w, right: 37.w),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '주의하세요!',
                      style: TextStyle(
                        fontSize: 40.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal,
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h,),
                  Container(
                    margin: EdgeInsets.only(left: 37.w, right: 37.w),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '한번 삭제된 회원 정보는 복구가 불가능합니다.',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w200,
                        color: Colors.teal,
                      ),
                    ),
                  ),
                  SizedBox(height: 60.h,),
                  Container(
                    margin: EdgeInsets.only(left: 37.w, right: 37.w),
                    child: CustomTextField(
                      text: 'PASSWORD',
                      hintText: '비밀번호를 입력하시오',
                      controller: passwordController,
                      password: true,
                    ),
                  ),
                  SizedBox(
                    height: 20.w,
                  ),
                  GestureDetector(
                    onTap: () => {
                      if (passwordController.text.length < 8 || !appConstants.passwordRegExp.hasMatch(passwordController.text)) {
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
                              )),
                        passwordController.clear(),
                      } else {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              title: Text('회원 탈퇴'),
                              content: Text('회원 탈퇴를 하시겠습니까?'),
                              actions: <Widget>[
                                TextButton(
                                    onPressed: () async {
                                      access_token = await storage.read(key:'access');
                                      var user_passwrod = PasswordToJsonModel(passwordController.text).toJson();
                                      var response = await Post().deleteUser(access_token,user_passwrod);
                                      if(response.statusCode == 201 ) {
                                        storage.deleteAll();
                                        GetUserInfoModel res = GetUserInfoModel.fromJson(jsonDecode(response.body));
                                        print('${res.data.name}님의 유저 정보가 삭제되었습니다');
                                        Navigator.pushReplacementNamed(context, '/login');
                                      } else {
                                        print(response.body.toString());
                                        ResIsBoolFail res = ResIsBoolFail.fromJson(jsonDecode(response.body));
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context)=>AlertDialog(
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(10.0),
                                              ),
                                              title: Text('실패'),
                                              content: Text('${res.message}'),
                                              actions: [
                                                TextButton(onPressed: ()=> Navigator.pop(context), child: Text('Ok')),
                                              ],
                                            )
                                        );
                                      }
                                    },
                                    child: Text('Ok')),
                                TextButton(
                                  onPressed: () => Navigator.pop(context, 'Cancel'),
                                  child: const Text('Cancel'),
                                ),
                              ],
                            )),
                      }
                    },
                    child: Container(
                      height: 65.h,
                      width: 400.w,
                      child: Center(
                        child: Text(
                          '회원 탈퇴',
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
                    height: 20.w,
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
