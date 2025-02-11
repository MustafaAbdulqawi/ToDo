import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart' as path;

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
      log("CREATED");
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
  // TextFormField createImageCon = TextFormField();
  // TextFormField createTitleCon = TextFormField();
  // TextFormField createDescCon = TextFormField();
  // TextFormField createDateCon = TextFormField();
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
      quality: 65,
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


        print("📷 Image Compressed and Encoded Successfully!");
      } else {
        print("❌ فشل ضغط الصورة!");
      }
    } else {
      print('لم يتم اختيار أي صورة.');
    }
  }
  void selectedPriorityF(value){
    selectedPriority = value;
    emit(SelectedPriorityState());
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