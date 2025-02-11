import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());

  Dio dio = Dio();
  Future login({required String phone, required String password}) async {
    try {
      emit(LoginLoadingState());
      final data = await dio.post(
        "https://todo.iraqsapp.com/auth/login",
        data: {
          "phone": phone,
          "password": password,
        },
      );
      SharedPreferences sharedPreferences =await SharedPreferences.getInstance();
      sharedPreferences.setString("access_token", data.data["access_token"]);
      sharedPreferences.setString("refresh_token", data.data["refresh_token"]);
      sharedPreferences.setString("id", data.data["_id"]);
      emit(LoginSuccessState());
      if (kDebugMode) {
        print("${data.data["access_token"]}");
      }
    } on DioException catch (e) {
      emit(LoginErrorState(e.response!.data["message"]));
      switch (e.type) {
        case DioExceptionType.connectionTimeout:
          log("connectionTimeout");
        case DioExceptionType.sendTimeout:
          log("sendTimeout");
        case DioExceptionType.receiveTimeout:
          log("receiveTimeout");
        case DioExceptionType.badCertificate:
          log("badCertificate");
        case DioExceptionType.badResponse:
          log("badResponse");
        case DioExceptionType.cancel:
          log("cancel");
        case DioExceptionType.connectionError:
          log("connectionError");
        case DioExceptionType.unknown:
          log("unknown");
      }
      return null;
    }
  }
}
