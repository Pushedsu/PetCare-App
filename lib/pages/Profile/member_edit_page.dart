import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../widgets/text_field.dart';

class MemberEditPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=> FocusScope.of(context).unfocus(),
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
                  SizedBox(height: 120.h,),
                  Container(
                    child: Text(
                      '회원 정보 수정',
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
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/changeNickname');
                    },
                    child: Container(
                      height: 65.h,
                      width: 400.w,
                      child: Center(
                        child: Text(
                          '닉네임 변경',
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
                  SizedBox(height: 40.h),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/changePassword');
                    },
                    child: Container(
                      height: 65.h,
                      width: 400.w,
                      child: Center(
                        child: Text(
                          '비밀번호 변경',
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

