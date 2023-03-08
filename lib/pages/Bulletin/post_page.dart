import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_care/connect/connect_server.dart';
import 'package:pet_care/module/response/response_model.dart';
import 'package:pet_care/providers/current_post_provider.dart';
import 'package:pet_care/providers/on_off_provider.dart';
import 'package:provider/provider.dart';


class PostPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    CurrentPostProvider currentPost = Provider.of<CurrentPostProvider>(context);
    OnOffProvider onOff = Provider.of<OnOffProvider>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('게시글', style: TextStyle(color: Colors.teal, fontWeight: FontWeight.bold),),
        backgroundColor: Colors.white,
        leading: IconButton(onPressed: () async {
          if(context.read<OnOffProvider>().change) {
            print('좋아요 누름!');
            var response = await Put().plusLike(currentPost.getObjectId());
            if(response.statusCode == 200) {
              ResIsBoolSuccessModel res = ResIsBoolSuccessModel.fromJson(jsonDecode(response.body));
              print('좋아요 api 성공 여부: ${res.success}');
              onOff.onOff();
              Navigator.pushReplacementNamed(context,'/pageRouter');
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
            }
          } else {
            print('좋아요 누르지 않음.');
            Navigator.pop(context);
          }
        }, icon: Icon(Icons.arrow_back,color: Colors.teal,)),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.more_vert,color: Colors.teal,))
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Container(
                width: 330.w,
                child: Column(
                  children: [
                    SizedBox(height: 30.h,),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '${currentPost.getTitle()}',
                        style: TextStyle(
                          color: Colors.teal,
                          fontWeight: FontWeight.bold,
                          fontSize: 40.sp,
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h,),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '글쓴이: ${currentPost.getName()}',
                        style: TextStyle(
                            color: Colors.teal,
                            fontSize: 20.sp,
                        ),
                      ),
                    ),
                    SizedBox(height: 30.h,),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '${currentPost.getContents()}',
                        style: TextStyle(
                          color: Colors.teal,
                          fontSize: 30.sp,
                        ),
                      ),
                    ),
                    SizedBox(height: 30.h,),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: GestureDetector(
                        onTap: () {
                          onOff.onOff();
                        },
                        child: Container(
                          width: 100.w,
                          child: Row(
                            children: [
                              Icon(
                                Icons.thumb_up_sharp,
                                color: context.read<OnOffProvider>().change ? Colors.teal: Colors.grey,
                                size: 20.sp,
                              ),
                              SizedBox(width: 5.w,),
                              Text('좋아요', style: TextStyle(fontSize: 18.sp, color: context.read<OnOffProvider>().change ? Colors.teal: Colors.grey),),
                              SizedBox(width: 5.w,),
                              Text(
                                '${context.read<OnOffProvider>().change? currentPost.getLikeCount()+1: currentPost.getLikeCount() }',
                                style: TextStyle(
                                    fontSize: 20.sp,
                                    color: context.read<OnOffProvider>().change ? Colors.teal: Colors.grey
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30.h,),
            ],
          ),
        ),
      ),
    );
  }
}
