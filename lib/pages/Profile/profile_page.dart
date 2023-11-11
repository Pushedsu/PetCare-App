// ignore_for_file: unnecessary_nullable_for_final_variable_declarations

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pet_care/module/user/user_model.dart';
import 'package:pet_care/providers/events_provider.dart';
import 'package:provider/provider.dart';

import '../../connect/connect_server.dart';
import '../../module/response/response_model.dart';
import '../../providers/user_info_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pet_care/utils/app_constants.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  static final storage = FlutterSecureStorage();

  final ImagePicker _picker = ImagePicker();
  XFile? pickImage;
  String imgUrl = '';
  String userObjId = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    imgUrl = context.read<UserInfoProvider>().getImgUrl();
    userObjId = context.read<UserInfoProvider>().getObjId();
  }

  @override
  Widget build(BuildContext context) {
    UserInfoProvider userInfoController = Provider.of<UserInfoProvider>(context);
    return Scaffold(
      body: Center(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                children: [
                  Positioned(
                    child: imgUrl == '' ? Container(
                      width: 150.w,
                      height: 150.h,
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
                      child:  Center(
                        child: Icon(Icons.person,size: 100.sp,),
                      ),
                    ) : Container(
                      width: 150.w,
                      height: 150.h,
                      decoration: BoxDecoration(
                        image: DecorationImage(fit: BoxFit.cover, image: NetworkImage(imgUrl)),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.7),
                            spreadRadius: 0,
                            blurRadius: 5.0,
                            offset: Offset(0, 10),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 5.h,
                    right: 5.w,
                    child: GestureDetector(
                      onTap: () async {
                        pickImage = await _picker.pickImage(
                          //이미지를 선택
                          source: ImageSource.gallery, //위치는 갤러리
                          maxHeight: 150.h,
                          maxWidth: 150.w,
                          imageQuality: 50, // 이미지 크기 압축을 위해 퀄리티를 30으로 낮춤.
                        );
                        if(imgUrl!='') {
                          RegExpMatch? match = appConstants.deleteImgRegExp.firstMatch(imgUrl);
                          if (match != null) {
                            String? extractedValue = match.group(0);
                            var deleteImgJson = UserDeleteProfileImgModel(extractedValue!).toJson();
                            var deleteImgResponse = await Post().deleteImg(deleteImgJson);
                            if(deleteImgResponse.statusCode == 201) {
                              ResIsBoolSuccessModel res = ResIsBoolSuccessModel.fromJson(jsonDecode(deleteImgResponse.body));
                              print("이미지 삭제 성공! ${res.success}");
                            } else {
                              ResIsBoolFailList post = ResIsBoolFailList.fromJson(jsonDecode(deleteImgResponse.body));
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) => AlertDialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    title: Text('다시 이미지를 선택하시오'),
                                    content: Text('${post.message![0]}...'),
                                    actions: <Widget>[
                                      TextButton(
                                          onPressed: () => Navigator.pop(context),
                                          child: Text('Ok')),
                                    ],
                                  )
                              );
                            }
                          }
                          var response = await Post().updateImg(pickImage!,userObjId);
                          if(response.statusCode == 201) {
                            GetUserInfoModel res = GetUserInfoModel.fromJson(jsonDecode(response.body));
                            imgUrl=res.data.image;
                            Provider.of<UserInfoProvider>(context,listen: false).setImgUrl(imgUrl);
                          } else {
                            ResIsBoolFailList post = ResIsBoolFailList.fromJson(jsonDecode(response.body));
                            showDialog(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  title: Text('다시 이미지를 선택하시오'),
                                  content: Text('${post.message![0]}...'),
                                  actions: <Widget>[
                                    TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: Text('Ok')),
                                  ],
                                )
                            );
                          }
                        }
                        setState(() {
                          pickImage;
                          imgUrl;
                        });
                      },
                      child: Container(
                        width: 60.w,
                        height: 60.h,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.teal,
                          border: Border.all(color: Colors.black87),
                        ),
                        child: Center(
                          child: Icon(Icons.add,size: 40.sp,color: Colors.black87,),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 20.h,),
              Text(
                '${userInfoController.getName()}님',
                style: TextStyle(
                    color: Colors.teal,
                    fontSize: 40.sp,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 60.h,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/memberEdit');
                },
                child: Container(
                  height: 65.h,
                  width: 400.w,
                  child: Center(
                    child: Text(
                      '회원 정보 수정',
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
                  Navigator.pushNamed(context, '/myPost');
                },
                child: Container(
                  height: 65.h,
                  width: 400.w,
                  child: Center(
                    child: Text(
                      '내 글 보기',
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
                onTap: () async {
                  var response = await Delete().logout(userInfoController.getObjId());
                  if(response.statusCode == 200 ) {
                    ResIsBoolSuccessModel res = ResIsBoolSuccessModel.fromJson(jsonDecode(response.body));
                    print('로그아웃 api 성공 여부: ${res.success}');
                    storage.deleteAll();
                    context.read<EventsProvider>().removeEvents();
                    Navigator.pushNamed(context, '/login');
                  } else {
                    context.read<EventsProvider>().removeEvents();
                    storage.deleteAll();
                    ResIsBoolFail res = ResIsBoolFail.fromJson(jsonDecode(response.body));
                    showDialog(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          title: Text('${res.message}'),
                          content: Text('서버 통신 실패'),
                          actions: <Widget>[
                            TextButton(
                                onPressed: () => Navigator.pushNamed(context, '/login'),
                                child: Text('Ok')),
                          ],
                        )
                    );
                  }
                },
                child: Container(
                  height: 65.h,
                  width: 400.w,
                  child: Center(
                    child: Text(
                      '로그아웃',
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
                  Navigator.pushReplacementNamed(context, '/delete');
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
    );
  }
}
