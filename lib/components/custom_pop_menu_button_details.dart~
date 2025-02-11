import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:todo/API/get_todos.dart';
import 'package:todo/cubits/edit_task_cubit/edit_task_cubit.dart';
import 'package:todo/custom/custom_button.dart';
import 'package:todo/custom/custom_text_form_field.dart';

class CustomPopMenuButtonDetails extends StatelessWidget {
  const CustomPopMenuButtonDetails({
    super.key,
    required this.pressed,
    required this.onTap,
    required this.data,
  });
  final void Function() pressed;
  final void Function() onTap;
  final GetTodos data;
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: const Icon(Icons.more_vert),
      onSelected: (value) {},
      itemBuilder: (BuildContext context) => [
        PopupMenuItem(
          onTap: () {
            final cubit = context.read<EditTaskCubit>();
            cubit.titleCon.text = data.title;
            cubit.descCon.text = data.description;
            showBottomSheet(
              backgroundColor: Colors.white,
              context: context,
              builder: (context) {
                return ListView(
                  children: [
                    CustomTextFormField(
                      controller: cubit.titleCon,
                      hintText: "Title",
                    ),
                    CustomTextFormField(
                      controller: cubit.descCon,
                      hintText: "Desc",
                      verticalSize: 8.5.h,
                      maxLines: 8,
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 7.w, vertical: 3.h),
                      child: CustomButton(
                        text: "Edit",
                        pressed: pressed,
                      ),
                    ),
                  ],
                );
              },
            );
          },
          value: 'edit',
          child: const Text('Edit', style: TextStyle(fontSize: 18)),
        ),
        PopupMenuItem(
          onTap: onTap,
          value: 'delete',
          child: const Text(
            'Delete',
            style: TextStyle(fontSize: 18, color: Colors.red),
          ),
        ),
      ],
    );
  }
}
