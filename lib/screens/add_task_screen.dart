import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:todo/cubits/create_task_cubit/create_task_cubit.dart';
import 'package:todo/cubits/get_task_cubit/get_task_cubit.dart';
import 'package:todo/custom/custom_button.dart';
import 'package:todo/custom/custom_text_form_field.dart';
import 'package:todo/end_point.dart';
import 'package:todo/screens/login_screen.dart';
import 'package:todo/screens/propirty.dart';
import 'package:path/path.dart' as path;

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  TextFormField imageCon = TextFormField();
  TextFormField titleCon = TextFormField();
  TextFormField descCon = TextFormField();
  TextFormField dateCon = TextFormField();
  String priority = "Medium";
  File? _image;
  String? _base64Image;

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
        setState(() {
          _image = compressedImage;
        });

        final bytes = await compressedImage.readAsBytes();
        final base64Image = base64Encode(bytes);

        setState(() {
          _base64Image = base64Image;
        });

        print("📷 Image Compressed and Encoded Successfully!");
      } else {
        print("❌ فشل ضغط الصورة!");
      }
    } else {
      print('لم يتم اختيار أي صورة.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreateTaskCubit, CreateTaskState>(
      listener: (context, state) {
        final cubit = BlocProvider.of<CreateTaskCubit>(context);
        if (state is SuccessCreateTask) {
          context.read<GetTaskCubit>().getTasksList();
          Navigator.pop(context);
          cubit.titleCon.clear();
          cubit.descCon.clear();
          cubit.dateCon.clear();
          toast(
            msg: "Created",
            color: Colors.green,
          );
        } else if (state is LoadingCreateTask) {
        } else if (state is ErrorCreateTask) {
          if (state.error == errorMessagePriority) {
            toast(
              msg: "please choose priority",
              color: Colors.red,
            );
          } else if (state.error == errorMessageDesc) {
            toast(
              msg: "please enter description",
              color: Colors.red,
            );
          } else if (state.error == errorMessageTitle) {
            toast(
              msg: "please enter title",
              color: Colors.red,
            );
          } else if (state.statusCode == 401) {
            toast(
              msg: "Token Expired.. please login again",
              color: Colors.red,
            );
            Navigator.pushNamedAndRemoveUntil(
              context,
              "/login_screen",
              (route) => false,
            );
          } else {
            toast(
              msg: "Error",
              color: Colors.red,
            );
          }
        } else {
          toast(
            msg: "Error",
            color: Colors.red,
          );
        }
      },
      builder: (context, state) {
        final cubit = BlocProvider.of<CreateTaskCubit>(context);
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0,
            scrolledUnderElevation: 0,
            backgroundColor: Colors.white,
            leading: IconButton(
              onPressed: () {
                context.read<GetTaskCubit>().getTasksList();
                Navigator.pop(context);
              },
              icon: Image.asset("assets/Arrow - Left00.png"),
            ),
            title: const Text(
              "Add new task",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ),
          body: ListView(
            physics: const ClampingScrollPhysics(),
            children: [
              SizedBox(
                height: 2.h,
              ),
              GestureDetector(
                onTap: () async {
                  await pickImage();
                },
                child: Image.asset(
                  "assets/Frame 1111.png",
                ),
              ),
              SizedBox(
                height: 1.5.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 4.w),
                child: const Text(
                  "Task title",
                ),
              ),
              SizedBox(
                height: 1.4.h,
              ),
              CustomTextFormField(
                controller: cubit.titleCon,
                hintText: "Enter title here",
              ),
              SizedBox(
                height: 1.4.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 4.w),
                child: const Text(
                  "Task Description",
                ),
              ),
              SizedBox(
                height: 1.4.h,
              ),
              CustomTextFormField(
                maxLines: 3,
                verticalSize: 8.5.h,
                controller: cubit.descCon,
                hintText: "Enter description here...",
              ),
              SizedBox(
                height: 1.4.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 4.w),
                child: const Text("Priority"),
              ),
              SizedBox(
                height: 1.4.h,
              ),
              PriorityButton(
                text: "medium",
                icon: Icons.flag_outlined,
                onSelected: (value) {
                  priority = value;
                },
                value1: 'medium',
                value2: 'high',
                value3: 'low',
              ),
              SizedBox(
                height: 1.4.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 4.w),
                child: const Text(
                  "Due date",
                ),
              ),
              SizedBox(
                height: 1.4.h,
              ),
              CustomTextFormField(
                controller: cubit.dateCon,
                hintText: "choose due date..",
                suffixIcon: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 4.w,
                    ),
                    Expanded(
                      child: Text(
                        cubit.selectedDate == null
                            ? "Choose due date..."
                            : "${cubit.selectedDate!.day}/${cubit.selectedDate!.month}/${cubit.selectedDate!.year}",
                        style:
                            TextStyle(fontSize: 18.sp, color: Colors.black54),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.calendar_today,
                          color: Color(0XFF5F33E1)),
                      onPressed: () {
                        cubit.selectDateV(context);
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              state is LoadingCreateTask
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Padding(
                      padding: EdgeInsets.symmetric(horizontal: 7.w),
                      child: CustomButton(
                        text: "Add task",
                        pressed: () async {
                          if (_base64Image != null) {
                            cubit.createTask(
                              title: cubit.titleCon.text,
                              desc: cubit.descCon.text,
                              priority:
                                  (priority.isNotEmpty) ? priority : "medium",
                              dueDate:
                                  cubit.selectedDate?.toIso8601String() ?? "",
                              image: _base64Image!,
                            );
                          } else if (priority.isEmpty || priority == null) {
                            toast(
                              msg: "Please select a priority level",
                              color: Colors.red,
                            );
                          } else {
                            toast(
                              msg: "Please select an image",
                              color: Colors.red,
                            );
                          }
                        },
                      ),
                    ),
              SizedBox(
                height: 4.h,
              ),
            ],
          ),
        );
      },
    );
  }
}

// selectedImage != null
// ? Image.file(
// selectedImage!,
// width: 200,
// height: 200,
// fit: BoxFit.cover,
// )
//     : const Text("لم يتم اختيار صورة بعد"),
