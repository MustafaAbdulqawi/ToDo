import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/API/get_todos.dart';
import 'package:todo/cubits/get_task_cubit/get_task_cubit.dart';
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
          // "image": image,
          "title": title,
          "desc": desc,
          "priority": priority,
          "status": status,
          "user": sharedPreferences.getString("id"),
        },
      );
      emit(EditTaskSuccessState());
      //log(data.data);
      log("okkkkkkkkkkkkkkkk");
    } on DioException catch (e) {
      emit(EditTaskErrorState());
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
          log("badResponse");
        case DioExceptionType.cancel:
          log("cancel");
        case DioExceptionType.connectionError:
          log("connectionError");
        case DioExceptionType.unknown:
          log("unknown");
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
    //  BlocProvider.of<GetTaskCubit>(context).getTasksList();
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
     // BlocProvider.of<GetTaskCubit>(context).getTasksList();
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
      print("object");
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
      print(e);
      emit(ErrorEdit());
    }
  }
}
