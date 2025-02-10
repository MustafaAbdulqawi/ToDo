import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:todo/cubits/create_task_cubit/create_task_cubit.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  File? _image;
  String? _base64Image;

  Future<File?> compressImage(File imageFile) async {
    final tempDir = await getTemporaryDirectory();
    final targetPath = path.join(tempDir.path, "compressed_${DateTime.now().millisecondsSinceEpoch}.jpg");

    final compressedImage = await FlutterImageCompress.compressAndGetFile(
      imageFile.absolute.path,
      targetPath,
      quality: 70, // تقليل الجودة إلى 70%
      minWidth: 600, // تقليل الأبعاد إلى 600x600
      minHeight: 600,
    );

    return compressedImage != null ? File(compressedImage.path) : null;
  }

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      File originalImage = File(pickedFile.path);

      // ضغط الصورة
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
    return Scaffold(
      appBar: AppBar(
        title: const Text("Test Screen"),
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _image != null
                  ? Image.file(
                _image!,
                width: 200,
                height: 200,
                fit: BoxFit.cover,
              )
                  : const Text("لا توجد صورة مختارة"),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  await pickImage();
                  if (_base64Image != null) {
                    context.read<CreateTaskCubit>().createTask(
                      image: _base64Image!,
                      title: "anything",
                      desc: "anythingg",
                      priority: "medium",
                      dueDate: "10/10/2024",
                    );
                  }
                },
                child: const Text('اختر صورة من المعرض'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
