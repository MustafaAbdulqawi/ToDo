part of 'edit_task_cubit.dart';

@immutable
sealed class EditTaskState {}

final class EditTaskInitial extends EditTaskState {}
final class EditTaskLoadingState extends EditTaskState {}
final class EditTaskSuccessState extends EditTaskState {}
final class EditTaskErrorState extends EditTaskState {}
final class EditedStatus extends EditTaskState {}
final class EditedPriority extends EditTaskState {}
final class LoadingEdit extends EditTaskState {}
final class SuccessEdit extends EditTaskState {}
final class ErrorEdit extends EditTaskState {}
