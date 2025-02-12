import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart' as path;
import 'package:tasky/components/custom_toast.dart';
part 'create_task_state.dart';

class CreateTaskCubit extends Cubit<CreateTaskState> {
  CreateTaskCubit() : super(CreateTaskInitial());
  Dio dio = Dio();
  TextEditingController titleCon = TextEditingController();
  TextEditingController descCon = TextEditingController();
  TextEditingController dateCon = TextEditingController();
  String selectedPriority = "medium";
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
      await dio.post(
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
      if (kDebugMode) {
        print("CREATED");
      }
    } on DioException catch (e) {
      if (kDebugMode) {
        print("❌ API Error: ${e.response?.data}");
      }
      if (kDebugMode) {
        print("❌ Status Code: ${e.response?.statusCode}");
      }
      emit(ErrorCreateTask(
          error: e.response?.data["message"] ?? "",
          statusCode: e.response?.data["status"] ?? 0));

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
          toast(
            msg: "حجم الصوره كبير",
            color: Colors.red,
          );
          if (kDebugMode) {
            print("badResponse: ${e.response?.data}");
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

  String priority = "Medium";
  File? image;
  String? base64Image;

  Future<File?> compressImage(File imageFile) async {
    final tempDir = await getTemporaryDirectory();
    final targetPath = path.join(tempDir.path,
        "compressed_${DateTime.now().millisecondsSinceEpoch}.jpg");

    final compressedImage = await FlutterImageCompress.compressAndGetFile(
      imageFile.absolute.path,
      targetPath,
      quality: 20,
      minWidth: 500,
      minHeight: 500,
    );

    return compressedImage != null ? File(compressedImage.path) : null;
  }

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      File originalImage = File(pickedFile.path);

      File? compressedImage = await compressImage(originalImage);

      if (compressedImage != null) {
        image = compressedImage;
        emit(CompressedImageState());

        final bytes = await compressedImage.readAsBytes();
        final base64Image2 = base64Encode(bytes);

        base64Image = base64Image2;

        if (kDebugMode) {
          print("Image Compressed and Encoded Successfully!");
        }
      } else {
        if (kDebugMode) {
          print("Image compression failed❌");
        }
      }
    } else {
      if (kDebugMode) {
        print("Image compression selected");
      }
    }
  }

  void selectedPriorityF(value) {
    selectedPriority = value;
    emit(SelectedPriorityState());
  }
}
