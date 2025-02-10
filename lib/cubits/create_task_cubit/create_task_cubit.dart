import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/API/error_info.dart';
import 'package:todo/end_point.dart';

part 'create_task_state.dart';

class CreateTaskCubit extends Cubit<CreateTaskState> {
  CreateTaskCubit() : super(CreateTaskInitial());
  Dio dio = Dio();
  TextEditingController titleCon = TextEditingController();
  TextEditingController descCon = TextEditingController();
  TextEditingController dateCon = TextEditingController();

  Future createTask({
    required String image,
    required String title,
    required String desc,
    required String priority,
    required String dueDate,
  }) async {
    try {
      emit(LoadingCreateTask());
      SharedPreferences sharedPreferences =await SharedPreferences.getInstance();
      final data = await dio.post(
        "https://todo.iraqsapp.com/todos",
        data: {
          "image": image,
          "title": title,
          "desc": desc,
          "priority": priority,
          "dueDate": dueDate,
        },
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Authorization":
                "Bearer ${sharedPreferences.getString('token')}"
          },
        ),
      );
      emit(SuccessCreateTask());
      print(data.data);
    } on DioException catch (e) {
      print("❌ API Error: ${e.response?.data}");
      print("❌ Status Code: ${e.response?.statusCode}");
      emit(ErrorCreateTask(error: e.response!.data["message"], statusCode: e.response!.data["statusCode"]));

      switch (e.type) {
        case DioExceptionType.connectionTimeout:
          print("connectionTimeout");
          break;
        case DioExceptionType.sendTimeout:
          print("sendTimeout");
          break;
        case DioExceptionType.receiveTimeout:
          print("receiveTimeout");
          break;
        case DioExceptionType.badCertificate:
          print("badCertificate");
          break;
        case DioExceptionType.badResponse:
          print("badResponse: ${e.response?.data}");
          break;
        case DioExceptionType.cancel:
          print("cancel");
          break;
        case DioExceptionType.connectionError:
          print("connectionError");
          break;
        case DioExceptionType.unknown:
          print("unknown");
          break;
      }
      return null;
    }
  }

  DateTime? selectedDate;
  void selectDateV(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null && pickedDate != selectedDate) {
      selectedDate = pickedDate;
      emit(SelectedDateState()); // حالة جديدة لتحديث الـ UI
    }
  }
}
