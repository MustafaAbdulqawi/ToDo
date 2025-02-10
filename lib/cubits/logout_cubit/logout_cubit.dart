import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
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
            "Authorization": "Bearer ${sharedPreferences.getString('token')}",
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
        print(e);
      }
    }
  }
  logOutState(context)async{
    SharedPreferences sharedPreferences =await SharedPreferences.getInstance();
   await sharedPreferences.clear();
    logout().then(
          (value) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          "/login_screen",
              (route) => false,
        );
      },
    );
  }
}
