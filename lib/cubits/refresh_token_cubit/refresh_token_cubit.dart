import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'refresh_token_state.dart';

class RefreshTokenCubit extends Cubit<RefreshTokenState> {
  RefreshTokenCubit() : super(RefreshTokenInitial());
  Dio dio = Dio();

  Future<void> refreshToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    try {
      emit(RefreshTokenLoadingState());
      final data = await dio.get(
        "https://todo.iraqsapp.com/auth/refresh-token?token=${sharedPreferences.getString("refresh_token")}",
        options: Options(
          headers: {
            'Authorization': 'Bearer ${sharedPreferences.getString("token")}',
          },
        ),
      );
      emit(RefreshTokenSuccessState());
      if (kDebugMode) {
        print(data.data);
      }
      if (kDebugMode) {
        print("access token OKKKKKKKKKKKKKKK");
      }
    } on DioException catch (e) {
      emit(RefreshTokenErrorState());
      switch (e.type) {
        case DioExceptionType.connectionTimeout:
          print("connectionTimeout");
        case DioExceptionType.sendTimeout:
          print("sendTimeout");
        case DioExceptionType.receiveTimeout:
          print("receiveTimeout");
        case DioExceptionType.badCertificate:
          print("badCertificate");
        case DioExceptionType.badResponse:
          print("badResponse");
        case DioExceptionType.cancel:
          print("cancel");
        case DioExceptionType.connectionError:
          print("connectionError");
        case DioExceptionType.unknown:
          print("unknown");
      }

    }
  }
}
