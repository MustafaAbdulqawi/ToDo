part of 'create_task_cubit.dart';

sealed class CreateTaskState {}

final class CreateTaskInitial extends CreateTaskState {}

final class LoadingCreateTask extends CreateTaskState {}

final class SuccessCreateTask extends CreateTaskState {}
final class SelectedPriorityState extends CreateTaskState {}

final class ErrorCreateTask extends CreateTaskState {
  final String error;
  final int statusCode;
  ErrorCreateTask( {required this.statusCode,required this.error});
}
final class SelectedDateState extends CreateTaskState {}
final class CompressedImageState extends CreateTaskState {}
