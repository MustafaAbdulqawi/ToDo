part of 'app_cubit.dart';
@immutable
sealed class AppState {}

final class AppInitial extends AppState {}

final class ShowAndHidePasswordLogin extends AppState {}

final class ShowAndHidePasswordSignUp extends AppState {}

final class VisibilitySuccessState extends AppState {}

final class LoginLoadingState extends AppState {}

final class LoginSuccessState extends AppState {}

final class LoginErrorState extends AppState {
  final String message;
  LoginErrorState(this.message);
}