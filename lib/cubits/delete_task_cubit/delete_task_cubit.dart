import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/cubits/get_task_cubit/get_task_cubit.dart';

part 'delete_task_state.dart';

class DeleteTaskCubit extends Cubit<DeleteTaskState> {
  DeleteTaskCubit() : super(DeleteTaskInitial());
  Dio dio = Dio();
  Future delete({
    required String id,
  }) async {
    try {
      emit(DeleteLoadingState());
      SharedPreferences sharedPreferences =await SharedPreferences.getInstance();
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
      print(data.data);
      return data.data;
    } on DioException catch (e) {
      emit(DeleteErrorState());
      switch (e.type) {
        case DioExceptionType.connectionTimeout:
          print("connectionTimeout");
        case DioExceptionType.sendTimeout:
          print("sendTimeout");
        case DioExceptionType.receiveTimeout:
          print("receiveTimeout");
        case DioExceptionType.badCertificate:
          print("badCertificate");
        case DioExceptionType.badResponse:
          print("badResponse");
        case DioExceptionType.cancel:
          print("cancel");
        case DioExceptionType.connectionError:
          print("connectionError");
        case DioExceptionType.unknown:
          print("unknown");
      }
      return null;
    }
  }

  deleteTask(data, context){
    delete(
      id: data.id,
    ).then((v){
      BlocProvider.of<GetTaskCubit>(context).getTasksList();
      Navigator.pop(context);
    });
  }
}


