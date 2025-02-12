import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:tasky/components/custom_button.dart';
import 'package:tasky/components/custom_text_form_field.dart';
import 'package:tasky/cubits/sign_up_cubit/sign_up_cubit.dart';
import 'package:tasky/screens/more_of_experice_level.dart';
import 'package:tasky/screens/more_of_phone_numbers.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignUpCubit, SignUpState>(
      listener: (context, state) {
        if (state is SignUpSuccessState) {
          Navigator.pushNamed(context, "/login_screen");
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
                controller: cubit.signUpDisplayCon,
                hintText: 'Name',
              ),
              CustomTextFormField(
                controller: cubit.signUpPhoneCon,
                hintText: 'Phone',
                prefixIcon: MoreOfPhoneNumber(
                  text: cubit.countryCode,
                  onSelected: (v) {
                    cubit.chooseCountryCode(v);
                  },
                ),
              ),
              CustomTextFormField(
                controller: cubit.signUpExpYerCon,
                hintText: 'Years of experience',
              ),
              CustomTextFormField(
                controller: cubit.signUpLevelCon,
                hintText: 'Choose experience Level',
                suffixIcon: IconButton(
                  onPressed: () {},
                  icon: MoreOfExpLevel(
                    text: "Choose experience Level",
                    onSelected: (value) {
                      cubit.signUpLevelCon.text = value;
                    },
                  ),
                ),
              ),
              CustomTextFormField(
                controller: cubit.signUpAddressCon,
                hintText: 'Address',
              ),
              CustomTextFormField(
                controller: cubit.signUpPasswordCon,
                hintText: 'Password',
                suffixIcon: IconButton(
                  onPressed: () {
                    cubit.togglePasswordVisibility();
                  },
                  icon: Icon(
                    cubit.signUpIconData,
                  ),
                ),
                obscureText: cubit.signUpShowPassword,
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
                            displayName: cubit.signUpDisplayCon.text,
                            phone:
                                "${cubit.countryCode}${cubit.signUpPhoneCon.text}",
                            experienceYears: cubit.signUpExpYerCon.text,
                            level: cubit.signUpLevelCon.text,
                            address: cubit.signUpAddressCon.text,
                            password: cubit.signUpPasswordCon.text,
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
