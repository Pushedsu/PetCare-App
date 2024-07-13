import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/utils.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

import '../../env/env.dart';
import '../../module/user/token_model.dart';

class GoogleLoginPage extends StatefulWidget {
  const GoogleLoginPage({Key? key}) : super(key: key);

  @override
  State<GoogleLoginPage> createState() => _GoogleLoginPageState();
}

class _GoogleLoginPageState extends State<GoogleLoginPage> {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/userinfo.profile',
    ],
  );

  static final storage = FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SNS Sign In"),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min, // Column의 크기를 내용물에 맞춤
          children: <Widget>[
            ElevatedButton.icon(
              icon: Image.asset('images/googleLogo.png', height: 24.0, width: 24.0), // Google logo icon
              label: Text('Sign in with Google'),
              onPressed: _handleSignIn,
              style: ElevatedButton.styleFrom(
                minimumSize: Size(200, 50), // Button size
              ),
            ),
            SizedBox(height: 15), // 버튼과 이미지 사이의 간격 조정
            ElevatedButton.icon(
              icon: Image.asset('images/kakao_logo.png', height: 24.0, width: 24.0), // Google logo icon
              label: Text('Sign in with kakao'),
              onPressed: _handleSignIn,
              style: ElevatedButton.styleFrom(
                minimumSize: Size(200, 50), // Button size
              ),
            ),          ],
        ),
      ),
    );
  }

  Future<void> _handleSignIn() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
        final String idToken = googleAuth.idToken!;

        // Send the ID token to the server
        await _sendTokenToServer(idToken);

        // Navigate to another route
        Navigator.pushNamed(context, '/pageRouter');
      }
    } catch (error) {
      print('Sign in failed: $error');
    }
  }

  Future<void> _sendTokenToServer(String idToken) async {
    try {
      var response = await http.post(
        Uri.parse('http://${env.UrlIp}:3000/auth/google/idToken'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'idToken': idToken,
        }),
      );

      if (response.statusCode == 201) {
        GetLoginTokenModel resToken = GetLoginTokenModel.fromJson(jsonDecode(response.body));
        await storage.write(key: 'refresh', value: resToken.data.refreshToken);
        await storage.write(key: 'access', value: resToken.data.accessToken);
        print('Token sent to server successfully');
      } else {
        print('Failed to send token to server');
        print(response.statusCode.printError);
      }
    } catch (e) {
      print('Error sending token to server: $e');
    }
  }
}
