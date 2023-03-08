import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:pet_care/pages/Profile/profile_page.dart';
import 'package:pet_care/providers/page_index_provider.dart';
import 'package:provider/provider.dart';
import '../connect/connect_server.dart';
import '../module/response/response_model.dart';
import '../module/user/token_model.dart';
import '../module/user/user_model.dart';
import '../pages/Bulletin/bulletin_board_page.dart';
import '../pages/main_page.dart';
import '../providers/user_info_provider.dart';

class PageRouter extends StatefulWidget {
  const PageRouter({Key? key}) : super(key: key);

  @override
  State<PageRouter> createState() => _PageRouterState();
}

class _PageRouterState extends State<PageRouter> {
  static final storage = FlutterSecureStorage();
  dynamic refresh_token = null;
  dynamic access_token = null;
  static String obj_id = '';

  final List<Widget> _widgetOptions = <Widget>[
    MainPage(),
    BulletinBoardPage(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      context.read<PageIndexProvider>().setPageIndex(index);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _init();
  }

  _init() async {
    refresh_token = await storage.read(key:'refresh');
    access_token = await storage.read(key:'access');
    if ( refresh_token == null || access_token == null) {
      Navigator.pushReplacementNamed(context, '/login');
      print('storage에 저장된 토큰이 없습니다 로그인이 필요합니다');
    } else if(JwtDecoder.isExpired(refresh_token)){
      storage.deleteAll();
      Navigator.pushReplacementNamed(context, '/login');
      print('리프레쉬 토큰의 기간이 만료되었습니다');
    } else if(JwtDecoder.isExpired(access_token)) {
      print('액세스 토큰의 기간이 만료되었습니다.');
      var response = await Get().getAccessToken(refresh_token);
      if(response.statusCode == 200 ) {
        GetAccessTokenModel res_token = GetAccessTokenModel.fromJson(jsonDecode(response.body));
        await storage.write(key: 'access', value: res_token.data.access_token);
        access_token = await storage.read(key: 'access');
        print('액세스 토큰 갱신 api 성공 여부: ${res_token.success}');
      } else {
        ResIsBoolFail res = ResIsBoolFail.fromJson(jsonDecode(response.body));
        Navigator.pushReplacementNamed(context, '/login');
        print('${res.message}, 로그인이 필요합니다');
      }
    }
    var response = await Get().getUserInfo(access_token);
    if(response.statusCode == 200 ) {
      print('로그인된 현재 유저 정보를 불러왔습니다');
      GetUserInfoModel info =  GetUserInfoModel.fromJson(jsonDecode(response.body));
      obj_id = info.data.id;
      Provider.of<UserInfoProvider>(context,listen: false).setObjId(obj_id);
      Provider.of<UserInfoProvider>(context,listen: false).setName(info.data.name);
    } else {
      print('로그인된 현재 유저 정보를 불러오지 못했습니다');
      ResIsBoolFail res = ResIsBoolFail.fromJson(jsonDecode(response.body));
      print('${res.message}');
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: _widgetOptions.elementAt(context.read<PageIndexProvider>().pageIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_sharp,
            ),
            label: "홈",
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.format_list_bulleted_rounded,
              ),
              label: "게시판"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person_pin,
              ),
              label: "프로필"),
        ],
        currentIndex: context.read<PageIndexProvider>().pageIndex,
        onTap: _onItemTapped,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.teal,
        showUnselectedLabels: true,
      ),
    );
  }
}

