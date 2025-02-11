import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
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
                "Bearer ${sharedPreferences.getString('access_token')}"
          },
        ),
      );
      emit(SuccessCreateTask());
      log(data.data);
    } on DioException catch (e) {
      log("❌ API Error: ${e.response?.data}");
      log("❌ Status Code: ${e.response?.statusCode}");
      emit(ErrorCreateTask(
          error: e.response?.data["message"] ?? "",
          statusCode: e.response?.data["status"] ?? 0));

      switch (e.type) {
        case DioExceptionType.connectionTimeout:
          log("connectionTimeout");
          break;
        case DioExceptionType.sendTimeout:
          log("sendTimeout");
          break;
        case DioExceptionType.receiveTimeout:
          log("receiveTimeout");
          break;
        case DioExceptionType.badCertificate:
          log("badCertificate");
          break;
        case DioExceptionType.badResponse:
          log("badResponse: ${e.response?.data}");
          break;
        case DioExceptionType.cancel:
          log("cancel");
          break;
        case DioExceptionType.connectionError:
          log("connectionError");
          break;
        case DioExceptionType.unknown:
          log("unknown");
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
      emit(SelectedDateState());
    }
  }
}


// if (state.error == errorMessagePriority) {
// toast(
// msg: "please choose priority",
// color: Colors.red,
// );
// } else if (state.error == errorMessageDesc) {
// toast(
// msg: "please enter description",
// color: Colors.red,
// );
// } else if (state.error == errorMessageTitle) {
// toast(
// msg: "please enter title",
// color: Colors.red,
// );
// } else if (state.error ==
// "Todo validation failed: title: Path `title` is required., desc: Path `desc` is required., priority: `Medium` is not a valid enum value for path `priority`.") {
// toast(
// msg: "Please make sure to fill in all fields",
// color: Colors.red,
// );
// } else if (state.error == "Todo validation failed: title: Path `title` is required., priority: `Medium` is not a valid enum value for path `priority`."){
// toast(
// msg: "Please make sure to fill in all fields",
// color: Colors.red,
// );
// }
// else if (state.error == "Todo validation failed: title: Path `title` is required., desc: Path `desc` is required."){
// toast(
// msg: "Please make sure to fill in all fields",
// color: Colors.red,
// );
// }else if(state.error == "Todo validation failed: desc: Path `desc` is required., priority: `Medium` is not a valid enum value for path `priority`."){
// toast(
// msg: "Please make sure to fill in all fields",
// color: Colors.red,
// );
// }