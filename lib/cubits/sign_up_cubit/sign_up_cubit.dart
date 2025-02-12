import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/components/custom_toast.dart';
part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpInitial());
  Dio dio = Dio();
  TextEditingController signUpPhoneCon = TextEditingController();
  TextEditingController signUpPasswordCon = TextEditingController();
  TextEditingController signUpDisplayCon = TextEditingController();
  TextEditingController signUpExpYerCon = TextEditingController();
  TextEditingController signUpAddressCon = TextEditingController();
  TextEditingController signUpLevelCon = TextEditingController();
  IconData signUpIconData = Icons.visibility;
  bool signUpShowPassword = false;
  String countryCode = '+20';
  String selectLevel = "Junior";
  String selectedLevel = "Senior";
  String selectedNumber = "+20";
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
      signUpPhoneCon.clear();
      signUpPasswordCon.clear();
      signUpDisplayCon.clear();
      signUpExpYerCon.clear();
      signUpAddressCon.clear();
      signUpLevelCon.clear();
      toast(
        msg: "تم انشاء الحساب بنجاح",
        color: Colors.green,
      );
      if (kDebugMode) {
        print(data.data);
        print(data.statusMessage);
        print(data.statusCode);
      }
    } on DioException catch (e) {
      if (kDebugMode) {
        print(e.response!.data["message"]);
      }
      emit(SignUpErrorState(e.response!.data["message"]));
      toast(
        msg: e.response!.data["message"],
        color: Colors.red,
      );
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

  void togglePasswordVisibility() {
    signUpIconData =
        signUpShowPassword ? Icons.visibility : Icons.visibility_off_outlined;
    signUpShowPassword = !signUpShowPassword;
    emit(ToggledSuccessState());
  }
  void chooseCountryCode(v){
    countryCode = v;
    emit(SuccessSelectedCountryCode());
  }
  void chooseLevel(value){
    selectedLevel = value;
    emit(SuccessSelectedLevel());
  }
  void chooseNumber(value){
    selectedNumber = value;
    emit(SuccessSelectedNumber());
  }
}
