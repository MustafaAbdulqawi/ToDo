part of 'get_task_cubit.dart';

@immutable
sealed class GetTaskState {}

final class GetTaskInitial extends GetTaskState {}
final class GetTaskLoadingState extends GetTaskState {}
final class GetTaskSuccessState extends GetTaskState {
  final List<GetTodos> getTodos;
  GetTaskSuccessState({required this.getTodos});
}
final class GetTaskErrorState extends GetTaskState {}

final class BadRes extends GetTaskState {
 final String message;
  BadRes({required this.message});
}
