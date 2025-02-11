import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/API/get_todos.dart';
part 'get_task_state.dart';

class GetTaskCubit extends Cubit<GetTaskState> {
  GetTaskCubit() : super(GetTaskInitial());
  Dio dio = Dio();
  List<GetTodos> todosList = [];
  int currentPage = 1;
  bool hasMoreData = true;
  bool isLoadingMore = false;

  Future<List<GetTodos>> getTasksList() async {
    try {
      emit(GetTaskLoadingState());
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      final response = await dio.get(
        "https://todo.iraqsapp.com/todos?page=1",
        options: Options(
          headers: {
            "Authorization":
                "Bearer ${sharedPreferences.getString('access_token')}",
          },
        ),
      );
      List<GetTodos> todosList = (response.data as List)
          .map((item) => GetTodos.fromJson(item))
          .toList();

      emit(GetTaskSuccessState(getTodos: todosList));
      return todosList;
    } on DioException catch (e) {
      emit(GetTaskErrorState());
      switch (e.type) {
        case DioExceptionType.connectionTimeout:
          log("connectionTimeout");
        case DioExceptionType.sendTimeout:
          log("sendTimeout");
        case DioExceptionType.receiveTimeout:
          log("receiveTimeout");
        case DioExceptionType.badCertificate:
          log("badCertificate");
        case DioExceptionType.badResponse:
          emit(BadRes(message: e.response!.data["message"]));
          log(e.response!.data["message"]);
          log("badResponse");
        case DioExceptionType.cancel:
          log("cancel");
        case DioExceptionType.connectionError:
          log("connectionError");
        case DioExceptionType.unknown:
          log("unknown");
      }
      return [];
    }
  }

  Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'finished':
        return Color(0XFFe3f2ff);
      case 'inprogress':
        return Color(0XFFf0ecff);
      case 'waiting':
        return Color(0XFFffe4f2);
      case 'all':
        return Colors.purple;
      default:
        return Colors.grey.shade300;
    }
  }

  Color getStatusTextColor(String status) {
    switch (status.toLowerCase()) {
      case 'finished':
        return Color(0XFF0087FF);
      case 'inprogress':
        return Color(0XFF5F33E1);
      case 'waiting':
        return Color(0XFFFF7D53);
      case 'all':
        return Colors.white;
      default:
        return Colors.black;
    }
  }

  Color getPropirty(String priority) {
    switch (priority.toLowerCase()) {
      case "medium":
        return Color(0XFF5F33E1);
      case "heigh":
        return Color(0XFFFF7D53);
      case "high":
        return Color(0XFFFF7D53);
      case "low":
        return Color(0XFF0087FF);
      default:
        return Colors.red;
    }
  }
}
