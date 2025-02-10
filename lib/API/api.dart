import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:todo/API/api_consumer.dart';

class Api implements ApiConsumer {
  Dio dio = Dio();

  @override
  Future<dynamic> post({
    required String url,
    required Map<String, dynamic> data,
    Map<String, dynamic>? headers,

  }) async {
    try {
      final res = await dio.post(
        url,
        data: data,
        options: Options(headers: headers),
      );
      if (kDebugMode) {
        print("Response: ${res.data}");
      }
      return res.data;
    } on DioException catch (e) {
      switch(e.type){
        case DioExceptionType.connectionTimeout:
        print("mmmmmmm connectionTimeout");
        case DioExceptionType.sendTimeout:
          print("mmmmmmm sendTimeout");
        case DioExceptionType.receiveTimeout:
          print("mmmmmmm receiveTimeout");
        case DioExceptionType.badCertificate:
          print("mmmmmmm badCertificate");
        case DioExceptionType.badResponse:
          print("mmmmmmm badResponse");
        case DioExceptionType.cancel:
          print("mmmmmmm cancel");
        case DioExceptionType.connectionError:
          print("mmmmmmm connectionError");
        case DioExceptionType.unknown:
          print("mmmmmmm unknown");
      }

    }
  }

  @override
  get({required String url, required Map<String, dynamic> data, required Map<String, dynamic> headers}) {
    // TODO: implement get
    throw UnimplementedError();
  }


}
