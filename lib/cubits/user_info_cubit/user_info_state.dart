part of 'user_info_cubit.dart';

sealed class UserInfoState {}

final class UserInfoInitial extends UserInfoState {}
final class GetUserLoadingState extends UserInfoState {}
final class GetUserSuccessState extends UserInfoState {
 final UserInfo userInfo;

  GetUserSuccessState({required this.userInfo});
}
final class GetUserErrorState extends UserInfoState {}
