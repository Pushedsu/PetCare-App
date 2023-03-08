import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_care/connect/connect_server.dart';
import 'package:pet_care/providers/current_post_provider.dart';
import 'package:pet_care/widgets/text_field.dart';
import 'package:provider/provider.dart';

import '../../module/post/post_model.dart';
import '../../module/response/response_model.dart';

class BulletinBoardPage extends StatefulWidget {
  const BulletinBoardPage({Key? key}) : super(key: key);

  @override
  State<BulletinBoardPage> createState() => _BulletinBoardPageState();
}

class _BulletinBoardPageState extends State<BulletinBoardPage> {
  TextEditingController searchController = TextEditingController();
  List postsAuthorNameData = [];
  List postsObjectIdData = [];
  List postsContentsData = [];
  List postsTitleData = [];
  List postsLikeCount = [];
  static int count = 0;

  @override
  void initState() {
    super.initState();
    postsAuthorNameData = new List.empty(growable: true);
    postsContentsData = new List.empty(growable: true);
  }

  @override
  void dispose() {
    postsTitleData.clear();
    postsAuthorNameData.clear();
    postsContentsData.clear();
    // TODO: implement dispose
    super.dispose();
  }

  Future getPosts() async {
    var response = await Get().getAllPosts();
    if(response.statusCode == 200 ) {
      GetAllPostsModel postRes = GetAllPostsModel.fromJson(jsonDecode(response.body));
      setState(() {
        for (int i = 0; i < postRes.data!.length.toInt(); i++) {
          postsContentsData.add(postRes.data![i].contents);
          postsAuthorNameData.add(postRes.data![i].name);
          postsTitleData.add(postRes.data![i].title);
          postsObjectIdData.add(postRes.data![i].id);
          postsLikeCount.add(postRes.data![i].likeCount);
        }
        count = postRes.data!.length;
      });
      return 'Success';
    } else {
      ResIsBoolFail res = ResIsBoolFail.fromJson(jsonDecode(response.body));
      print('${res.message}');
      return 'Fail';
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=> FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Stack(
          children: [
            Positioned(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('images/BGI.png'), fit: BoxFit.fill),
                ),
              ),
            ),
            SafeArea(
              child: SingleChildScrollView(
                physics: NeverScrollableScrollPhysics(),
                child: Column(
                  children: [
                    SizedBox(height: 10.h,),
                    Container(
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
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                      alignment: Alignment.center,
                      padding: EdgeInsets.only(top: 15,bottom: 15),
                      margin: EdgeInsets.only(left: 20.w,right: 20.w),
                      child: Row(
                        children: [
                          SizedBox(width: 10.w,),
                          Text(
                            '게시판',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: Colors.teal,
                                fontWeight: FontWeight.bold,
                                fontSize: 35.sp),
                          ),
                          SizedBox(
                            width: 40.w,
                          ),
                          Icon(
                            Icons.search_rounded,
                            color: Colors.teal,
                            size: 35.sp,
                          ),
                          Container(
                            width: 190.w,
                            height: 40.h,
                            child: CustomTextField(
                                text: 'Search',
                                hintText: '검색어를 입력하시오.',
                                controller: searchController),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.h,),
                    FutureBuilder(
                        future: getPosts(),
                        builder: (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.hasData) {
                            return Container(
                              width: MediaQuery.of(context).size.width - 20.w,
                              height: 740.h,
                              child: count == 0
                                  ? Center(
                                      child: Text(
                                        '게시글이 없습니다.',
                                        style: TextStyle(
                                            fontSize: 50.sp,
                                            color: Colors.teal,
                                            fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.center,
                                      ),
                                    )
                                  : ListView.builder(
                                      padding: EdgeInsets.only(top: 30.h),
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Column(
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                Provider.of<CurrentPostProvider>(context,listen: false).setObjectId(postsObjectIdData![index]);
                                                Provider.of<CurrentPostProvider>(context,listen: false).setTitle(postsTitleData![index]);
                                                Provider.of<CurrentPostProvider>(context,listen: false).setContents(postsContentsData![index]);
                                                Provider.of<CurrentPostProvider>(context,listen: false).setName(postsAuthorNameData![index]);
                                                Provider.of<CurrentPostProvider>(context,listen: false).setLikeCount(postsLikeCount![index]);
                                                Navigator.pushNamed(context,'/post');
                                              },
                                              child: Container(
                                                padding: EdgeInsets.only(top: 10.h, bottom: 10.h),
                                                width: 360.w,
                                                decoration: BoxDecoration(
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.grey
                                                            .withOpacity(0.7),
                                                        spreadRadius: 0,
                                                        blurRadius: 5.0,
                                                        offset: Offset(0, 10), // changes position of shadow
                                                      ),
                                                    ],
                                                    color: Colors.white,
                                                    borderRadius: BorderRadius.all(Radius.circular(10))),
                                                child: Container(
                                                  margin: EdgeInsets.only(left: 15.w, right: 15.w),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Container(
                                                        width: 300.w,
                                                        child: Text(
                                                          '${postsTitleData![index]}',
                                                          style: TextStyle(
                                                              fontSize: 35.sp,
                                                              color: Colors.teal),
                                                          overflow:
                                                              TextOverflow.ellipsis,
                                                        ),
                                                      ),
                                                      Divider(
                                                        color: Colors.teal,
                                                        thickness: 1,
                                                      ),
                                                      SizedBox(height: 5.h,),
                                                      Text(
                                                        '${postsAuthorNameData![index]}',
                                                        style: TextStyle(
                                                          fontSize: 20.sp,
                                                          color: Colors.teal,
                                                        ),
                                                      ),
                                                      SizedBox(height: 5.h,),
                                                      Container(
                                                        child: Row(
                                                          children: [
                                                            Container(
                                                              width: 300.w,
                                                              child: Text(
                                                                '${postsContentsData![index]}',
                                                                style: TextStyle(
                                                                    fontSize: 20.sp,
                                                                    color: Colors.teal),
                                                                overflow: TextOverflow.ellipsis,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(height: 5.h,),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 30.h,),
                                          ],
                                        );
                                      },
                                      itemCount: count,
                                    ),
                            );
                          } else if (snapshot.hasError) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Error: ${snapshot.error}',
                                style: TextStyle(fontSize: 15.sp),
                              ),
                            );
                          } else {
                            return CircularProgressIndicator();
                          }
                        }),
                  ],
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, '/createPost');
          },
          backgroundColor: Colors.teal,
          child: const Icon(Icons.border_color_sharp),
        ),
      ),
    );
  }
}
