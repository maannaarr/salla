import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dio;

  static init() {
    dio = Dio(BaseOptions(
      baseUrl: 'https://student.valuxapps.com/api/',
      headers: {
        'Content-Type': 'application/json',
        'lang': 'en',
      },
      receiveDataWhenStatusError: true,
    ));
  }

  static Future<Response> postData(
      {required String url, Map<String, dynamic>? query, String? token, Map<String, dynamic>? data}) async {
    dio.options.headers = {
      'lang': 'en',
       'Authorization': token ?? '',
    };
    return await dio.post(url, queryParameters: query,data: data);
  }

  static Future<Response> getData(
      {required String url, Map<String, dynamic>? query, String? token}) async {
    dio.options.headers = {
      'lang': 'en',
       'Authorization': token ?? '',
    };
    return await dio.get(
      url,
      queryParameters: query,
    );
  }
}
