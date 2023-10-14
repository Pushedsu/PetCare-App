import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pet_care/utils/app_constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_care/connect/connect_server.dart';
import 'package:provider/provider.dart';

import '../../module/response/response_model.dart';
import '../../module/user/user_model.dart';
import '../../providers/user_info_provider.dart';
import '../../widgets/text_field.dart';

class ChangeNamePage extends StatelessWidget {
  TextEditingController nameController = TextEditingController();

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
                  SizedBox(
                    height: 80.h,
                  ),
                  Container(
                    child: Text(
                      '닉네임 변경',
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
                      '변경할 이름을 입력하시오.',
                      style: TextStyle(
                        color: Colors.teal,
                        fontWeight: FontWeight.bold,
                        fontSize: 25.sp,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 37.w, right: 37.w), //바깥쪽 여백
                    child: CustomTextField(
                      controller: nameController,
                      text: '이름',
                      hintText: '이름 입력',
                    ),
                  ),
                  SizedBox(
                    height: 60.h,
                  ),
                  GestureDetector(
                    onTap: () async {
                      if (nameController.text.length < 2 && !appConstants.nameRegExp
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
                      } else{
                        var posting = UserUpdateNameModel(userInfoProvider.getObjId(),nameController.text).toJson();
                        var response = await Post().updateName(posting);
                        if(response.statusCode == 201) {
                          ResIsBoolSuccessModel post = ResIsBoolSuccessModel.fromJson(jsonDecode(response.body));
                          print('이름 재설정 성공! ${post.success}');
                          Navigator.pushReplacementNamed(context,'/pageRouter');
                        } else {
                          ResIsBoolFailList post = ResIsBoolFailList.fromJson(jsonDecode(response.body));
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
                                      onPressed: () => Navigator.pop(context),
                                      child: Text('Ok')),
                                ],
                              )
                          );
                          nameController.clear();
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
        ),
      ),
    );
  }
}
