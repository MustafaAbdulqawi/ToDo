import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:todo/cubits/app_cubit/app_cubit.dart';
import 'package:todo/custom/custom_button.dart';
import 'package:todo/custom/custom_text_form_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

TextEditingController loginPasswordEditingController = TextEditingController();
TextEditingController loginPhoneEditingController = TextEditingController();
IconData iconData = Icons.visibility;
bool showPassword = false;

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Image.asset(
            "assets/ART.png",
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
            child: Text(
              "Login",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp),
            ),
          ),
          CustomTextFormField(
            controller: loginPhoneEditingController,
            hintText: "phone",
          ),
          CustomTextFormField(
            controller: loginPasswordEditingController,
            hintText: "password",
            obscureText: showPassword,
            suffixIcon: IconButton(
              onPressed: () {
                iconData = showPassword
                    ? Icons.visibility
                    : Icons.visibility_off_outlined;
                showPassword = !showPassword;
                setState(() {});
              },
              icon: Icon(
                iconData,
              ),
            ),
          ),
          SizedBox(
            height: 3.h,
          ),
          BlocConsumer<AppCubit, AppState>(
            listener: (context, state) {
              if (state is LoginLoadingState) {
                const CircularProgressIndicator();
              } else if (state is LoginErrorState) {
                toast(
                  msg: state.message,
                  color: Colors.red,
                );
              } else {
                toast(
                  msg: "تم التسجيل",
                  color: Colors.green,
                );
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  "/home_screen",
                  (route) => false,
                );
              }
            },
            builder: (context, state) {
              final cubit = BlocProvider.of<AppCubit>(context);
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 7.w),
                child: state is LoginLoadingState
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : CustomButton(
                        text: "Sign In",
                        pressed: () {
                          cubit
                              .login(
                            phone: loginPhoneEditingController.text,
                            password: loginPasswordEditingController.text,
                          )
                              .then(
                            (v) {
                              loginPhoneEditingController.clear();
                              loginPasswordEditingController.clear();
                            },
                          );
                        },
                      ),
              );
            },
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
