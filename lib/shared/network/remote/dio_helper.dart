import 'package:dio/dio.dart';

import '../../components/constants.dart';

class DioHelper {
  static late Dio dio;

  static init() {
    print('dioHelper Initialized');
    dio = Dio(BaseOptions(
        baseUrl: 'https://plantgradutionapi.herokuapp.com/',
        receiveDataWhenStatusError: true,
        headers: {'Content-Type': 'application/json'}));
  }

  static Future<Response> postData({
    required String url,
    Map<String, dynamic>? data,
    String? token,
  }) async {
    dio.options.headers["Authorization"] = "Bearer $token";
    print('post ok');
    return await dio.post(
      url,
      data: data,
    );
  }

  static Future<Response> getData(
      {required String url,
      Map<String, dynamic>? query,
      Map<String, dynamic>? data,
      String? token}) async {
    dio.options.headers["Authorization"] = "Bearer $token";
    print('get ok');
    return await dio.get(
      url,
    );
  }

  static Future<Response> putData(
      {required String url,
      Map<String, dynamic>? query,
      Map<String, dynamic>? data,
      String? token}) async {
    dio.options.headers["Authorization"] = "Bearer $token";
    print('put ok');
    return await dio.put(
      url,
      queryParameters: query,
      data: data,
    );
  }

  static Future<Response> deleteData(
      {required String url,
      Map<String, dynamic>? query,
      Map<String, dynamic>? data,
      String? token}) async {
    dio.options.headers["Authorization"] = "Bearer $token";
    print('delete ok');
    return await dio.delete(
      url,
      queryParameters: query,
      data: data,
    );
  }
}
