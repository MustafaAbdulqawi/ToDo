part of 'get_task_cubit.dart';

@immutable
sealed class GetTaskState {}

final class GetTaskInitial extends GetTaskState {}
final class GetTaskLoadingState extends GetTaskState {}
final class LoadedPrevious extends GetTaskState {}
final class LoadingPage extends GetTaskState {}
final class CheckingLoad extends GetTaskState {}
final class LoadState extends GetTaskState {}
final class LoadMore extends GetTaskState {}
final class LoadedCon extends GetTaskState {}
final class GetTaskSuccessState extends GetTaskState {
  final List<GetTodos> getTodos;
  GetTaskSuccessState({required this.getTodos});
}
final class GetTaskErrorState extends GetTaskState {}

final class BadRes extends GetTaskState {
 final String message;
  BadRes({required this.message});
}
