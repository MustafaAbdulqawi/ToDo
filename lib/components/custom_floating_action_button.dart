import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/cubits/create_task_cubit/create_task_cubit.dart';

class CustomFloatingActionButton extends StatelessWidget {
  const CustomFloatingActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      shape: const CircleBorder(),
      backgroundColor: const Color(0XFF5f33e1),
      onPressed: () {
        final cubit = BlocProvider.of<CreateTaskCubit>(context);
        cubit.titleCon.clear();
        cubit.descCon.clear();
        cubit.dateCon.clear();
        Navigator.pushNamed(
          context,
          "/add_task",
        );
      },
      child: const Icon(
        Icons.add,
        color: Colors.white,
        size: 25,
      ),
    );
  }
}
