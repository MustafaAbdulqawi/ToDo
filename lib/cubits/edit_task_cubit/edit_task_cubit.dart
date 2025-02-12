import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasky/cubits/get_task_cubit/get_task_cubit.dart';
import 'package:tasky/data/get_todos.dart';
part 'edit_task_state.dart';

class EditTaskCubit extends Cubit<EditTaskState> {
  EditTaskCubit() : super(EditTaskInitial());
  Dio dio = Dio();
  Future edit({
    required String id,
    required String title,
    required String desc,
    required String status,
    required String priority,
  }) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    try {
      emit(EditTaskLoadingState());
      await dio.put(
        "https://todo.iraqsapp.com/todos/$id",
        options: Options(
          headers: {
            'Authorization':
                'Bearer ${sharedPreferences.getString("access_token")}',
            'Content-Type': 'application/json',
          },
        ),
        data: {
          "title": title,
          "desc": desc,
          "priority": priority,
          "status": status,
          "user": sharedPreferences.getString("id"),
        },
      );
      emit(EditTaskSuccessState());
      if (kDebugMode) {
        print("okkkkkkkkkkkkkkkk");
      }
    } on DioException catch (e) {
      emit(EditTaskErrorState());
      switch (e.type) {
        case DioExceptionType.connectionTimeout:
          if (kDebugMode) {
            print("connectionTimeout");
          }
        case DioExceptionType.sendTimeout:
          if (kDebugMode) {
            print("sendTimeout");
          }
        case DioExceptionType.receiveTimeout:
          if (kDebugMode) {
            print("receiveTimeout");
          }
        case DioExceptionType.badCertificate:
          if (kDebugMode) {
            print("badCertificate");
          }
        case DioExceptionType.badResponse:
          if (kDebugMode) {
            print("badResponse");
          }
        case DioExceptionType.cancel:
          if (kDebugMode) {
            print("cancel");
          }
        case DioExceptionType.connectionError:
          if (kDebugMode) {
            print("connectionError");
          }
        case DioExceptionType.unknown:
          if (kDebugMode) {
            print("unknown");
          }
      }
      return null;
    }
  }

  TextEditingController titleCon = TextEditingController();
  TextEditingController descCon = TextEditingController();
  String? selectedStatus;
  String? selectedPriority;
  Future<void> updateStatus(String value, GetTodos data, context) async {
    selectedStatus = value;
    emit(EditedStatus());
    await editOne(
      id: data.id,
      status: selectedStatus ?? data.status,
      priority: selectedPriority ?? data.priority,
    ).then((v) {
      BlocProvider.of<GetTaskCubit>(context).getTasksList();
      Navigator.pop(context);
    });
    emit(EditedStatus());
  }

  Future<void> updatePriority(value, GetTodos data, context) async {
    selectedPriority = value;
    await editOne(
      id: data.id,
      status: selectedStatus ?? data.status,
      priority: selectedPriority ?? data.priority,
    ).then((v) {
      BlocProvider.of<GetTaskCubit>(context).getTasksList();
      Navigator.pop(context);
    });
    emit(EditedPriority());
  }

  Future editOne({
    required String status,
    required String priority,
    required String id,
  }) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    try {
      emit(EditTaskLoadingState());
      await dio.put(
        "https://todo.iraqsapp.com/todos/$id",
        options: Options(
          headers: {
            'Authorization':
                'Bearer ${sharedPreferences.getString("access_token")}',
            'Content-Type': 'application/json',
          },
        ),
        data: {
          "priority": priority,
          "status": status,
          "user": sharedPreferences.getString("id"),
        },
      );
      emit(EditTaskSuccessState());
    } catch (e) {
      if (kDebugMode) {
        print("object");
      }
    }
  }

  Future<void> editing(GetTodos data, context) async {
    try {
      emit(LoadingEdit());
      await edit(
        id: data.id,
        title: titleCon.text,
        desc: descCon.text,
        status: selectedStatus ?? data.status,
        priority: selectedPriority ?? data.priority,
      ).then(
        (value) {
          BlocProvider.of<GetTaskCubit>(context).getTasksList();
          Navigator.pop(context);
        },
      );
      emit(SuccessEdit());
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      emit(ErrorEdit());
    }
  }
}
