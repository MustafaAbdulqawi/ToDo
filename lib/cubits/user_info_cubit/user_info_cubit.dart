import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasky/data/user_info.dart';

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
      emit(GetUserSuccessState(userInfo: userInfo));
      return userInfo;
    } on DioException catch (e) {
      emit(GetUserErrorState());
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
