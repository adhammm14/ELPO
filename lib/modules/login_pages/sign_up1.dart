import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:elpo/modules/login_pages/sign_up2.dart';
import 'package:elpo/modules/login_pages/signin_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../shared/login_cubit/login_cubit.dart';
import '../../shared/login_cubit/login_states.dart';
import '../../shared/styles/colors.dart';

class SignUpPage1 extends StatelessWidget {
  SignUpPage1({super.key});

  var EmailController = TextEditingController();
  var PasswordController = TextEditingController();
  var ConfirmPasswordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => LoginCubit(context),
      child: BlocConsumer<LoginCubit, LoginStates>(
          listener: (context, state) {},
          builder: (context, state) {
            LoginCubit cubit = LoginCubit.get(context);
            return Scaffold(
              resizeToAvoidBottomInset: false,
              body: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [green1, green4])),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Text(
                        "ELPO Sign",
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 40.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(20),
                        margin: const EdgeInsets.symmetric(horizontal: 15),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                        ),
                        child: Form(
                          key: formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Center(
                                child: Text(
                                  "Create Account",
                                  style: TextStyle(
                                      fontSize: 35,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Center(
                                child: Text(
                                  "Create your account today. Join us and enjoy using Elpo app.",
                                  style: TextStyle(
                                    color: heavyGreyColor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 3),
                                decoration: BoxDecoration(
                                    color: lightGreyColor,
                                    borderRadius: BorderRadius.circular(15)),
                                child: TextFormField(
                                  controller: EmailController,
                                  cursorColor: heavyGreyColor,
                                  decoration: InputDecoration(
                                    hintText: "Email",
                                    hintStyle: TextStyle(
                                        color: heavyGreyColor, fontSize: 18),
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty ||
                                        !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,}$')
                                            .hasMatch(value)) {
                                      return "Please Enter Valid Email";
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 3),
                                decoration: BoxDecoration(
                                    color: lightGreyColor,
                                    borderRadius: BorderRadius.circular(15)),
                                child: TextFormField(
                                  controller: PasswordController,
                                  cursorColor: heavyGreyColor,
                                  obscureText: cubit.hidden,
                                  decoration: InputDecoration(
                                    hintText: "Password",
                                    hintStyle: TextStyle(
                                        color: heavyGreyColor, fontSize: 18),
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    suffixIcon: Padding(
                                      padding:
                                      const EdgeInsets.only(right: 10.0),
                                      child: InkWell(
                                        onTap: () {
                                          cubit.changePassHidden();
                                        },
                                        child: cubit.hidden
                                            ? SvgPicture.asset(
                                          "assets/icons/eye-closed.svg",
                                        )
                                            : SvgPicture.asset(
                                          "assets/icons/eye-opened.svg",
                                        ),
                                      ),
                                    ),
                                    suffixIconConstraints: const BoxConstraints(
                                        minWidth: 35,
                                        maxHeight: 40,
                                        minHeight: 35,
                                        maxWidth: 40),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty || value.length < 8) {
                                      return "Please Enter More than 8 Characters";
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 3),
                                decoration: BoxDecoration(
                                    color: lightGreyColor,
                                    borderRadius: BorderRadius.circular(15)),
                                child: TextFormField(
                                  controller: ConfirmPasswordController,
                                  cursorColor: heavyGreyColor,
                                  obscureText: cubit.hidden2,
                                  decoration: InputDecoration(
                                    hintText: "Confirm Password",
                                    hintStyle: TextStyle(
                                        color: heavyGreyColor, fontSize: 18),
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    suffixIcon: Padding(
                                      padding:
                                      const EdgeInsets.only(right: 10.0),
                                      child: InkWell(
                                        onTap: () {
                                          cubit.changePassHidden2();
                                        },
                                        child: cubit.hidden2
                                            ? SvgPicture.asset(
                                          "assets/icons/eye-closed.svg",
                                        )
                                            : SvgPicture.asset(
                                          "assets/icons/eye-opened.svg",
                                        ),
                                      ),
                                    ),
                                    suffixIconConstraints: const BoxConstraints(
                                        minWidth: 35,
                                        maxHeight: 40,
                                        minHeight: 35,
                                        maxWidth: 40),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty || value.length < 8) {
                                      return "Please Enter More than 8 Characters";
                                    }
                                    if (value != PasswordController.text) {
                                      return 'Passwords are not identical';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              ConditionalBuilder(
                                condition: state is! LoginLoadingState,
                                builder: (context) => InkWell(
                                  onTap: () {
                                    if (formKey.currentState!.validate()) {
                                      print("email: ${EmailController.text}, pass:${PasswordController.text}");
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUpPage2(EmailController,PasswordController)));
                                    }
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: greenColor,
                                      boxShadow: [
                                        BoxShadow(
                                            color: greenColor,
                                            offset: const Offset(2, 2),
                                            blurRadius: 5),
                                      ],
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Continue",
                                        style: TextStyle(
                                            color: blackColor,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ),
                                ),
                                fallback: (context) => Center(
                                  child: CircularProgressIndicator(
                                    color: greenColor,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Center(
                                child: Text(
                                  "Or continue with",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: heavyGreyColor,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Container(
                                width: double.infinity,
                                height: 50,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(
                                        color: heavyGreyColor, width: 1)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      "assets/icons/google.svg",
                                      width: 25,
                                      color: blackColor,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "Continue with Google",
                                      style: TextStyle(
                                          color: blackColor,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                width: double.infinity,
                                height: 50,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(
                                        color: heavyGreyColor, width: 1)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      "assets/icons/facebook.svg",
                                      width: 25,
                                      color: blackColor,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "Continue with Facebook",
                                      style: TextStyle(
                                          color: blackColor,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Have account?",
                                    style: TextStyle(
                                        color: blackColor,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));
                                      },
                                      child: Text(
                                        "Sign In",
                                        style: TextStyle(
                                            color: greenColor,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600),
                                      )),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }),
    );
  }
}
