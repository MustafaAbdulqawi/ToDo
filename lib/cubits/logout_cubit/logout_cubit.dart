import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'logout_state.dart';

class LogoutCubit extends Cubit<LogoutState> {
  LogoutCubit() : super(LogoutInitial());
  Dio dio = Dio();
  Future logout() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    try {
      emit(LogoutLoadingState());
      final data = await dio.post(
        "https://todo.iraqsapp.com/auth/logout",
        data: {
          "token": sharedPreferences.getString("refresh_token"),
        },
        options: Options(
          headers: {
            "Authorization": "Bearer ${sharedPreferences.getString('access_token')}",
          },
        ),
      );
      emit(LogoutSuccessState());
      if (kDebugMode) {
        print("OKKKKKKKKKKKKKKKKK");
      }

      return data.data;
    } catch (e) {
      emit(LogoutErrorState());

      if (kDebugMode) {
        print(e.toString());
      }

    }
  }
  logOutState(context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await logout();
    await sharedPreferences.clear();
    Navigator.pushNamedAndRemoveUntil(
      context,
      "/login_screen",
          (route) => false,
    );
  }
}
