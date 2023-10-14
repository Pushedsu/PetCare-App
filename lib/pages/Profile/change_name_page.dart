import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../widgets/text_field.dart';

class ChangeNamePage extends StatelessWidget {
  TextEditingController nicknameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                      '새로운 닉네임을 입력하시오.',
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
                      controller: nicknameController,
                      text: '닉네임',
                      hintText: '닉네임 입력',
                    ),
                  ),
                  SizedBox(
                    height: 60.h,
                  ),
                  GestureDetector(
                    onTap: () {},
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
