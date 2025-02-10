import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpInitial());
  Dio dio = Dio();
  Future signUp({
    required String displayName,
    required String phone,
    required String experienceYears,
    required String level,
    required String address,
    required String password,
  }) async {
    try {
      emit(SignUpLoadingState());
      final data = await dio.post(
        "https://todo.iraqsapp.com/auth/register",
        data: {
          "phone": phone,
          "password": password,
          "displayName": displayName,
          "experienceYears": experienceYears,
          "address": address,
          "level": level,
        },
      );
      emit(
        SignUpSuccessState(),
      );
      if (kDebugMode) {
        print(data.data);
        print(data.statusMessage);
        print(data.statusCode);
      }
    } on DioException catch (e) {
      print(e.response!.data["message"]);
      emit(SignUpErrorState(e.response!.data["message"]));
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
