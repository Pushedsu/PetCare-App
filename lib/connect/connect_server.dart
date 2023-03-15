import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pet_care/utils/app_constants.dart';

class Put {
  Future<http.Response> plusLike(String id) async {
    final response = await http.put(
      Uri.parse('http://${appConstants.UriIp}:3000/posts/${id}'),
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
      Uri.parse('http://${appConstants.UriIp}:3000/posts/all'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
    );
    return response;
  }
  Future<http.Response> getMyPosts(String id) async{
    final response = await http.get(
      Uri.parse('http://${appConstants.UriIp}:3000/posts/${id}'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
    );
    return response;
  }
  // Future<AllUserData> getAllUser() async {
  //   final response = await http.get(
  //     Uri.parse('http://${appConstants.UriIp}:3000/user/all'),
  //     headers: <String, String>{
  //       'Content-Type': 'application/json',
  //     },
  //   );
  //   if(response.statusCode == 200 ) {
  //     return AllUserData.fromJson(jsonDecode(response.body));
  //   } else {
  //     print(response.body.toString());
  //     throw Exception('Failed to load post');
  //   }
  // }

  Future<http.Response> getUserInfo(String accessToken) async {
    final response = await http.get(
      Uri.parse('http://${appConstants.UriIp}:3000/user/userInfo'),
      headers: <String, String>{
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
      },
    );
    return response;
  }
  Future<http.Response> getAccessToken(String refreshToken) async {
    final response = await http.get(
      Uri.parse('http://${appConstants.UriIp}:3000/user/getAccessToken'),
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
      Uri.parse('http://${appConstants.UriIp}:3000/user/signUp'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(data),
    );
    return response;
  }

  Future<http.Response> login(Map<String, dynamic> data) async{
    final response =  await http.post(
      Uri.parse('http://${appConstants.UriIp}:3000/user/login'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(data),
    );
    return response;
  }
  Future<http.Response> createPost(Map<String, dynamic> data) async{
    final response =  await http.post(
      Uri.parse('http://${appConstants.UriIp}:3000/posts/posting'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(data),
    );
    return response;
  }
  Future<http.Response> deleteUser(String accessToken, Map<String, dynamic> data) async{
    final response =  await http.post(
      Uri.parse('http://${appConstants.UriIp}:3000/user/deleteUser'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
      body: jsonEncode(data),
    );
    return response;
  }
}

class Delete {
  Future<http.Response> logout(String id) async{
    final response =  await http.delete(
      Uri.parse('http://${appConstants.UriIp}:3000/user/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
    );
    return response;
  }
}