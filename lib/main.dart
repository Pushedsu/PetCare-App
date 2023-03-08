import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:pet_care/pages/Calendar/calendar_page.dart';
import 'package:pet_care/pages/Profile/delete_account_page.dart';
import 'package:pet_care/providers/events_provider.dart';
import 'package:pet_care/providers/on_off_provider.dart';
import 'package:pet_care/providers/page_index_provider.dart';
import 'package:pet_care/providers/user_info_provider.dart';
import 'package:pet_care/pages/Bulletin/bulletin_board_page.dart';
import 'package:pet_care/pages/Bulletin/create_post_page.dart';
import 'package:pet_care/pages/User/login_page.dart';
import 'package:pet_care/pages/main_page.dart';
import 'package:pet_care/pages/Bulletin/post_page.dart';
import 'package:pet_care/providers/current_post_provider.dart';
import 'package:pet_care/routes/page_router.dart';
import 'package:pet_care/pages/User/signup_page.dart';
import 'package:provider/provider.dart';

void main() => initializeDateFormatting().then((_) => runApp(MyApp()));

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CurrentPostProvider()),
        ChangeNotifierProvider(create: (_) => UserInfoProvider()),
        ChangeNotifierProvider(create: (_) => OnOffProvider()),
        ChangeNotifierProvider(create: (_) => PageIndexProvider()),
        ChangeNotifierProvider(create: (_) => EventsProvider()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(430, 930),
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'My App',
            home: PageRouter(),
            initialRoute: '/',
            routes: {
              '/delete': (context)=> DeleteAccountPage(),
              '/post': (context) => PostPage(),
              '/pageRouter': (context) => PageRouter(),
              '/createPost': (context) => CreatePostPage(),
              '/bulletin': (context) => BulletinBoardPage(),
              '/login': (context) => LoginPage(),
              '/signUp': (context) => SignUpPage(),
              '/main': (context) => MainPage(),
              '/calendar': (context) => CalendarPage(),
            },
          );
        },
      ),
    );
  }
}
