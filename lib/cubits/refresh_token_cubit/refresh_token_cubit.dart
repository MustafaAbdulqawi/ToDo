import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'refresh_token_state.dart';

class RefreshTokenCubit extends Cubit<RefreshTokenState> {
  RefreshTokenCubit() : super(RefreshTokenInitial());
  Dio dio = Dio();

  Future<String?>? refreshToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    try {
      emit(RefreshTokenLoadingState());
      final data = await dio.get(
        "https://todo.iraqsapp.com/auth/refresh-token?token=${sharedPreferences.getString("refresh_token")}",
        options: Options(
          headers: {
            'Authorization':
                'Bearer ${sharedPreferences.getString("access_token")}',
          },
        ),
      );
      String newAccessToken = data.data["access_token"];
      sharedPreferences.setString("access_token", newAccessToken);
      if (kDebugMode) {
        print(data.data["access_token"]);
      }
      emit(RefreshTokenSuccessState());
      return newAccessToken;
    } on DioException catch (e) {
      emit(RefreshTokenErrorState());
      switch (e.type) {
        case DioExceptionType.connectionTimeout:
          if (kDebugMode) {
            print("connectionTimeout");
          }
        case DioExceptionType.sendTimeout:
          if (kDebugMode) {
            print("sendTimeout");
          }
        case DioExceptionType.receiveTimeout:
          if (kDebugMode) {
            print("receiveTimeout");
          }
        case DioExceptionType.badCertificate:
          if (kDebugMode) {
            print("badCertificate");
          }
        case DioExceptionType.badResponse:
          if (kDebugMode) {
            print("badResponse");
          }
        case DioExceptionType.cancel:
          if (kDebugMode) {
            print("cancel");
          }
        case DioExceptionType.connectionError:
          if (kDebugMode) {
            print("connectionError");
          }
        case DioExceptionType.unknown:
          if (kDebugMode) {
            print("unknown");
          }
      }
      return null;
    }
  }
}
