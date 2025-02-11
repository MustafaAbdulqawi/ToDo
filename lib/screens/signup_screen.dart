import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:todo/cubits/sign_up_cubit/sign_up_cubit.dart';
import 'package:todo/custom/custom_button.dart';
import 'package:todo/custom/custom_text_form_field.dart';
import 'package:todo/screens/login_screen.dart';
import 'package:todo/screens/more_of_experice_level.dart';
import 'package:todo/screens/more_of_phone_numbers.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController signUpPhoneCon = TextEditingController();
  TextEditingController signUpPasswordCon = TextEditingController();
  TextEditingController signUpDisplayCon = TextEditingController();
  TextEditingController signUpExpYerCon = TextEditingController();
  TextEditingController signUpAddressCon = TextEditingController();
  TextEditingController signUpLevelCon = TextEditingController();
  IconData signUpIconData = Icons.visibility;
  bool signUpShowPassword = false;
  String countryCode = '+20';
  String selectLevel = "Junior";
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignUpCubit, SignUpState>(
      listener: (context, state) {
        if (state is SignUpLoadingState) {
          const CircularProgressIndicator(
            color: Color(0XFF5f33e1),
          );
        } else if (state is SignUpSuccessState) {
          toast(
            msg: "تم انشاء الحساب بنجاح",
            color: Colors.green,
          );
        } else if (state is SignUpErrorState) {
          toast(
            msg: state.message,
            color: Colors.red,
          );
        }
      },
      builder: (context, state) {
        final cubit = BlocProvider.of<SignUpCubit>(context);
        return Scaffold(
          body: ListView(
            children: [
              Image.asset(
                "assets/Frame 4.png",
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
                controller: signUpDisplayCon,
                hintText: 'Name',
              ),
              CustomTextFormField(
                controller: signUpPhoneCon,
                hintText: 'Phone',
                prefixIcon: MoreOfPhoneNumber(
                  text: countryCode,
                  onSelected: (v) {
                    setState(() {
                      countryCode = v;
                    });
                  },
                ),
              ),
              CustomTextFormField(
                controller: signUpExpYerCon,
                hintText: 'Years of experience',
              ),
              CustomTextFormField(
                controller: signUpLevelCon,
                hintText: 'Choose experience Level',
                suffixIcon: IconButton(
                  onPressed: () {},
                  icon: MoreOfExpLevel(
                    text: "Choose experience Level",
                    onSelected: (value) {
                      signUpLevelCon.text = value;
                    },
                  ),
                ),
              ),
              CustomTextFormField(
                controller: signUpAddressCon,
                hintText: 'Address',
              ),
              CustomTextFormField(
                controller: signUpPasswordCon,
                hintText: 'Password',
                suffixIcon: IconButton(
                  onPressed: () {
                    signUpIconData = signUpShowPassword
                        ? Icons.visibility
                        : Icons.visibility_off_outlined;
                    signUpShowPassword = !signUpShowPassword;
                    setState(() {});
                  },
                  icon: Icon(
                    signUpIconData,
                  ),
                ),
                obscureText: signUpShowPassword,
              ),
              SizedBox(
                height: 3.h,
              ),
              state is SignUpLoadingState
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: Color(0XFF5f33e1),
                      ),
                    )
                  : Padding(
                      padding: EdgeInsets.symmetric(horizontal: 7.w),
                      child: CustomButton(
                        text: "Sign Up",
                        pressed: () {
                          cubit.signUp(
                            displayName: signUpDisplayCon.text,
                            phone: "$countryCode${signUpPhoneCon.text}",
                            experienceYears: signUpExpYerCon.text,
                            level: signUpLevelCon.text,
                            address: signUpAddressCon.text,
                            password: signUpPasswordCon.text,
                          );
                        },
                      ),
                    ),
              SizedBox(
                height: 2.5.h,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Already have any account?",
                    style: TextStyle(color: Color(0XFF7F7F7F)),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      " Sign In",
                      style: TextStyle(
                        color: Color(0XFF5F33E1),
                        decoration: TextDecoration.underline,
                        decorationColor: Color(0XFF7F7F7F),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 3.h,
              ),
            ],
          ),
        );
      },
    );
  }
}
