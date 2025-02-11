import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:todo/components/custom_button.dart';
import 'package:todo/components/custom_text_form_field.dart';
import 'package:todo/cubits/app_cubit/app_cubit.dart';
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AppCubit>();
    return Scaffold(
      body: BlocConsumer<AppCubit, AppState>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            Navigator.pushNamed(context, "/home_screen");
          }
        },
        builder: (context, state) {
          return ListView(
            children: [
              Image.asset(
                "assets/ART.png",
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
                child: Text(
                  "Login",
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp),
                ),
              ),
              CustomTextFormField(
                controller: cubit.loginPhoneEditingController,
                hintText: "phone",
              ),
              CustomTextFormField(
                controller: cubit.loginPasswordEditingController,
                hintText: "password",
                obscureText: cubit.showPassword,
                suffixIcon: IconButton(
                  onPressed: () {
                    cubit.showAndHideVisibility();
                  },
                  icon: Icon(
                    cubit.iconData,
                  ),
                ),
              ),
              SizedBox(
                height: 3.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 7.w),
                child: state is LoginLoadingState
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: Color(0XFF5f33e1),
                        ),
                      )
                    : CustomButton(
                        text: "Sign In",
                        pressed: () {
                          cubit.login(
                            phone: cubit.loginPhoneEditingController.text,
                            password: cubit.loginPasswordEditingController.text,
                          );
                        },
                      ),
              ),
              SizedBox(
                height: 2.1.h,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Didn't have any account?",
                    style: TextStyle(color: Color(0XFF7F7F7F)),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        "/sign_up_screen",
                      );
                    },
                    child: const Text(
                      " Sign Up here",
                      style: TextStyle(
                        color: Color(0XFF5F33E1),
                        decoration: TextDecoration.underline,
                        decorationColor: Color(0XFF7F7F7F),
                      ),
                    ),
                  ),
                ],
              )
            ],
          );
        },
      ),
    );
  }
}

toast({required String msg, required Color color}) {
  return Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: color,
      textColor: Colors.white,
      fontSize: 16.0);
}
