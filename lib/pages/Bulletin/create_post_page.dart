import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../connect/connect_server.dart';
import '../../module/post/post_model.dart';
import '../../module/response/response_model.dart';
import '../../providers/user_info_provider.dart';

class CreatePostPage extends StatelessWidget {

  TextEditingController titleController = TextEditingController();
  TextEditingController contentsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    UserInfoProvider userInfoProvider = Provider.of<UserInfoProvider>(context);
    return GestureDetector(
      onTap: ()=> FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  SizedBox(height: 10.h,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.arrow_back_ios_outlined,
                          color: Colors.teal,
                          size: 35.sp,
                        ),
                      ),
                      SizedBox(width: 100.w,),
                      Text(
                        '글쓰기',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Colors.teal,
                            fontWeight: FontWeight.w400,
                            fontSize: 35.sp
                        ),
                      ),
                      SizedBox(width: 100.w,),
                      GestureDetector(
                        onTap: () async {
                          var posting = PostingModel(userInfoProvider.getObjId(), contentsController.text,userInfoProvider.getName() ,titleController.text).toJson();
                          var response = await Post().createPost(posting);
                          if(response.statusCode == 201 ) {
                            ResIsBoolSuccessModel post = ResIsBoolSuccessModel.fromJson(jsonDecode(response.body));
                            print('새글 저장 api 통신 성공! ${post.success}');
                            Navigator.pushReplacementNamed(context, '/pageRouter');
                          } else {
                            ResIsBoolFailLIst post = ResIsBoolFailLIst.fromJson(jsonDecode(response.body));
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
                          }
                        },
                        child: Text(
                          '저장',
                          style: TextStyle(
                            color: Colors.teal,
                            fontWeight: FontWeight.w400,
                            fontSize: 35.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h,),
                  Divider(thickness: 10,),
                  TextField(
                    maxLength: 15,
                    controller: titleController,
                    decoration: InputDecoration(
                      hintText: '    제목을 입력하시오.',
                    ),
                  ),
                  Container(
                    height: 500.h,
                    child: TextFormField(
                      maxLines: 30,
                      controller: contentsController,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: '    본문을 입력하시오.'
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
