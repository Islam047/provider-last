import 'dart:convert';


import 'package:dio/dio.dart';

import '../model/post_model.dart';
import 'intecepter.dart';

class Network {
  static String BASE = "https://jsonplaceholder.typicode.com";
  /* Http Apis */

  static String API_LIST = "/posts";
  static String API_CREATE = "/posts";
  static String API_UPDATE = "/posts/"; //{id}
  static String API_DELETE = "/posts/"; //{id}

  /// Headers */
  static Map<String, String> get headers {
    Map<String, String> headers = {
      'Accept': '*/*',
      'Content-Type': 'application/json',
      'Accept-Version': 'v1',
    };
    return headers;
  }


  /// BaseOptions */
  static final BaseOptions _baseDioOptions = BaseOptions(
    baseUrl: BASE,
    headers: headers,
    connectTimeout: 40000,
    receiveTimeout: 40000,
    contentType: 'application/json',
    responseType: ResponseType.json,
  );


  static final Dio _dio = Dio(_baseDioOptions)..interceptors.add(DioInterceptor());

  /* Dio Requests */
  static Future GET(String api, Map<String, dynamic> params) async {
    Response response = await _dio.get(api, queryParameters: params);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.data;
    }
    return null;
  }

  static Future POST(String api, Map<String, dynamic> body) async {
    Response response = await _dio.post(api, data: jsonEncode(body) );
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.data;
    }
    return null;
  }


  static Future<Map<String, dynamic>?> PUT(String api, Map<String, dynamic> params) async {
    Response response = await _dio.put(api, data: params); // http or https
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.data;
    }
    return null;
  }


  static Future<dynamic> DELETE(String api, Map<String, dynamic> params) async {
    Response response = await _dio.delete(api, data: params);
    if (response.statusCode == 200 || response.statusCode == 201||response.statusCode == 204) {
      return response.data;
    }
    return null;
  }


  static Map<String, String> paramsEmpty() {
    Map<String, String> params = {};
    return params;
  }

  static Map<String, String> paramsCreate(PostProvider post) {
    Map<String, String> params = {};
    params.addAll({
      'title': post.title,
      'body': post.body,
      'userId': post.userId.toString(),
    });
    return params;
  }

  static Map<String, String> paramsUpdate(PostProvider post) {
    Map<String, String> params = {};
    params.addAll({
      'id': post.id.toString(),
      'title': post.title,
      'body': post.body,
      'userId': post.userId.toString(),
    });
    return params;
  }

  static List<PostProvider> parsePostProviderList(List str) {

    List<PostProvider> list = str.map((e) => PostProvider.fromJson(e)).toList();
    return list;
  }
}