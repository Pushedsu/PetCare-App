import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: ()=>{
              Navigator.pushNamed(context, '/calendar'),
            },
            child: Container(
              height: 65.h,
              width: 400.w,
              child: Center(
                child: Text(
                  'Calender Page',
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
                  borderRadius: BorderRadius.all(Radius.circular(10))
              ),
            ),
          ),
        ],
      ),
    );
  }
}
