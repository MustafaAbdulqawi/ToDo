part of 'sign_up_cubit.dart';

sealed class SignUpState {}

final class SignUpInitial extends SignUpState {}

final class SignUpLoadingState extends SignUpState {}
final class ToggledSuccessState extends SignUpState {}
final class SuccessSelectedCountryCode extends SignUpState {}
final class SuccessSelectedLevel extends SignUpState {}
final class SuccessSelectedNumber extends SignUpState {}



final class SignUpSuccessState extends SignUpState {

}

final class SignUpErrorState extends SignUpState {
  final String message;
  SignUpErrorState(this.message);

}

