import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasky/data/get_todos.dart';
part 'get_task_state.dart';

class GetTaskCubit extends Cubit<GetTaskState> {
  GetTaskCubit() : super(GetTaskInitial());
  Dio dio = Dio();
  List<GetTodos> todos = [];
  Future<void> getTasksList() async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      emit(GetTaskLoadingState());
      final response = await dio.get(
        "https://todo.iraqsapp.com/todos?page=1",
        options: Options(
          headers: {
            "Authorization":
                "Bearer ${sharedPreferences.getString('access_token')}",
          },
        ),
      );

      List<GetTodos> firstPageTasks = (response.data as List)
          .map((item) => GetTodos.fromJson(item))
          .toList();

      todos = firstPageTasks;
      emit(GetTaskSuccessState(getTodos: todos));
      int currentPage = 2;
      bool hasMoreData = true;
      while (hasMoreData) {
        final nextPageResponse = await dio.get(
          "https://todo.iraqsapp.com/todos?page=$currentPage",
          options: Options(
            headers: {
              "Authorization":
                  "Bearer ${sharedPreferences.getString('access_token')}",
            },
          ),
        );
        List<GetTodos> nextPageTasks = (nextPageResponse.data as List)
            .map((item) => GetTodos.fromJson(item))
            .toList();

        if (nextPageTasks.isEmpty || nextPageTasks.length < 20) {
          hasMoreData = false;
        }

        todos.addAll(nextPageTasks);
        emit(GetTaskSuccessState(getTodos: todos));
        currentPage++;
      }
    } on DioException catch (e) {
      emit(GetTaskErrorState());
      handleDioError(e);
    }
  }

  void handleDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        if (kDebugMode) {
          print("connectionTimeout");
        }
        break;
      case DioExceptionType.sendTimeout:
        if (kDebugMode) {
          print("sendTimeout");
        }
        break;
      case DioExceptionType.receiveTimeout:
        if (kDebugMode) {
          print("receiveTimeout");
        }
        break;
      case DioExceptionType.badCertificate:
        if (kDebugMode) {
          print("badCertificate");
        }
        break;
      case DioExceptionType.badResponse:
        emit(BadRes(message: e.response!.data["message"]));
        if (kDebugMode) {
          print(e.response!.data["message"]);
        }
        break;
      case DioExceptionType.cancel:
        if (kDebugMode) {
          print("cancel");
        }
        break;
      case DioExceptionType.connectionError:
        if (kDebugMode) {
          print("connectionError");
        }
        break;
      case DioExceptionType.unknown:
        if (kDebugMode) {
          print("unknown");
        }
        break;
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
