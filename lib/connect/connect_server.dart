import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:pet_care/env/env.dart';

class Put {
  Future<http.Response> plusLike(String id) async {
    final response = await http.put(
      Uri.parse('http://${env.UriIp}:3000/posts/${id}'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
    );
    return response;
  }
}

class Get {
  Future<http.Response> getAllPosts() async {
    final response = await http.get(
      Uri.parse('http://${env.UriIp}:3000/posts/all'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
    );
    return response;
  }
  Future<http.Response> getMyPosts(String id) async{
    final response = await http.get(
      Uri.parse('http://${env.UriIp}:3000/posts/${id}'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
    );
    return response;
  }

  Future<http.Response> getUserInfo(String accessToken) async {
    final response = await http.get(
      Uri.parse('http://${env.UriIp}:3000/user/userInfo'),
      headers: <String, String>{
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
      },
    );
    return response;
  }
  Future<http.Response> getAccessToken(String refreshToken) async {
    final response = await http.get(
      Uri.parse('http://${env.UriIp}:3000/user/getAccessToken'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $refreshToken',
      },
    );
    return response;
  }
}

class Post {
  Future<http.Response> signUp(Map<String, dynamic> data) async{
    final response = await http.post(
      Uri.parse('http://${env.UriIp}:3000/user/signUp'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(data),
    );
    return response;
  }

  Future<http.Response> login(Map<String, dynamic> data) async{
    final response =  await http.post(
      Uri.parse('http://${env.UriIp}:3000/user/login'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(data),
    );
    return response;
  }
  Future<http.Response> createPost(Map<String, dynamic> data) async{
    final response =  await http.post(
      Uri.parse('http://${env.UriIp}:3000/posts/posting'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(data),
    );
    return response;
  }
  Future<http.Response> deleteUser(String accessToken, Map<String, dynamic> data) async{
    final response =  await http.post(
      Uri.parse('http://${env.UriIp}:3000/user/deleteUser'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
      body: jsonEncode(data),
    );
    return response;
  }
  Future<http.Response> updateName(Map<String, dynamic> data) async{
    final response = await http.post(
      Uri.parse('http://${env.UriIp}:3000/user/updateName'),
      headers: <String, String>{
      'Content-Type': 'application/json',
      },
      body: jsonEncode(data),
    );
    return response;
  }
  Future<http.Response> updatePassword(Map<String, dynamic> data) async{
    final response = await http.post(
      Uri.parse('http://${env.UriIp}:3000/user/updatePassword'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(data),
    );
    return response;
  }
  Future<http.Response> searchTitle(Map<String, dynamic> data) async{
    final response = await http.post(
      Uri.parse('http://${env.UriIp}:3000/posts/searchTitle'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(data),
    );
    return response;
  }
  Future<http.Response> searchContents(Map<String, dynamic> data) async{
    final response = await http.post(
      Uri.parse('http://${env.UriIp}:3000/posts/searchContents'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(data),
    );
    return response;
  }
  Future<http.Response> updateImg(XFile imageFile, String id) async{
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('http://${env.UriIp}:3000/user/uploadImg'),
    );

    // 이미지 파일 추가
    request.files.add(
      await http.MultipartFile.fromPath(
        'image',
        imageFile.path,
      ),
    );

    // id를 form-data로 추가
    request.fields['id'] = id;

    var response = await request.send();
    return await http.Response.fromStream(response);
  }
  Future<http.Response> deleteImg(Map<String, dynamic> data) async{
    final response = await http.post(
      Uri.parse('http://${env.UriIp}:3000/user/deleteImg'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(data),
    );
    return response;
  }
  Future<http.Response> findPassword(Map<String, dynamic> data) async{
    final response = await http.post(
      Uri.parse('http://${env.UriIp}:3000/user/findPassword'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(data),
    );
    return response;
  }
}

class Delete {
  Future<http.Response> logout(String id) async{
    final response =  await http.delete(
      Uri.parse('http://${env.UriIp}:3000/user/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
    );
    return response;
  }
}