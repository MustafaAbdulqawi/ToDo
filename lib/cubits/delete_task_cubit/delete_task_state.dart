part of 'delete_task_cubit.dart';

sealed class DeleteTaskState {}

final class DeleteTaskInitial extends DeleteTaskState {}
final class DeleteLoadingState extends DeleteTaskState {}
final class DeleteSuccessState extends DeleteTaskState {}
final class DeleteErrorState extends DeleteTaskState {}
