import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasky/components/custom_toast.dart';
import 'package:tasky/cubits/get_task_cubit/get_task_cubit.dart';
part 'delete_task_state.dart';

class DeleteTaskCubit extends Cubit<DeleteTaskState> {
  DeleteTaskCubit() : super(DeleteTaskInitial());
  Dio dio = Dio();
  Future delete({
    required String id,
  }) async {
    try {
      emit(DeleteLoadingState());
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      final data = await dio.delete(
        "https://todo.iraqsapp.com/todos/$id",
        options: Options(
          headers: {
            "Authorization":
                "Bearer ${sharedPreferences.getString('access_token')}",
          },
        ),
      );
      emit(DeleteSuccessState());
      if (kDebugMode) {
        print(data.data);
      }
      return data.data;
    } on DioException catch (e) {
      emit(DeleteErrorState());
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

  deleteTask(data, context) {
    delete(
      id: data.id,
    ).then((v) {
      toast(
        msg: "Deleted",
        color: Colors.green,
      );
      BlocProvider.of<GetTaskCubit>(context).getTasksList();
      Navigator.pop(context);
    });
  }
}
