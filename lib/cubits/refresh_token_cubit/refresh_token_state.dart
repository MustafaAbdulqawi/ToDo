part of 'refresh_token_cubit.dart';

@immutable
sealed class RefreshTokenState {}

final class RefreshTokenInitial extends RefreshTokenState {}
final class RefreshTokenLoadingState extends RefreshTokenState {}
final class RefreshTokenSuccessState extends RefreshTokenState {}
final class RefreshTokenErrorState extends RefreshTokenState {}
