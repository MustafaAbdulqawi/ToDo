import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/API/user_info.dart';

part 'user_info_state.dart';

class UserInfoCubit extends Cubit<UserInfoState> {
  UserInfoCubit() : super(UserInfoInitial());
  Dio dio = Dio();
  Future<UserInfo?> getUserInfo() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    try {
      emit(GetUserLoadingState());
      final data = await dio.get(
        "https://todo.iraqsapp.com/auth/profile",
        options: Options(
          headers: {
            "Authorization": "Bearer ${sharedPreferences.getString('access_token')}",
          },
        ),
      );
      UserInfo userInfo = UserInfo.json(data.data);
      log("User Level: ${userInfo.level}");
      // print(userInfo.level);
      emit(GetUserSuccessState(userInfo: userInfo));
      return userInfo;
    } on DioException catch (e) {
      emit(GetUserErrorState());
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
      return null;
    }
  }
}
