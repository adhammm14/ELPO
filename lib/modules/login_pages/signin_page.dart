import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:elpo/modules/login_pages/sign_up1.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../shared/login_cubit/login_cubit.dart';
import '../../../shared/login_cubit/login_states.dart';
import '../../shared/styles/colors.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
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
                      Container(
                        padding: const EdgeInsets.all(20),
                        margin: const EdgeInsets.symmetric(horizontal: 15),
                        decoration: BoxDecoration(
                            color: whiteColor,
                            borderRadius: const BorderRadius.only(
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
                                  "SignIn",
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
                                  "SignIn to your account to start using app.",
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
                                  controller: emailController,
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
                                  controller: passController,
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
                              TextButton(
                                  onPressed: () {},
                                  child: Text(
                                    "Forgot Password?",
                                    style: TextStyle(
                                        color: greenColor,
                                        fontSize: 17,
                                        fontWeight: FontWeight.w600),
                                  )),
                              const SizedBox(
                                height: 10,
                              ),
                              ConditionalBuilder(
                                condition: state is! LoginLoadingState,
                                builder: (context) => InkWell(
                                  onTap: () {
                                    if (formKey.currentState!.validate()) {
                                      cubit.loginAccount(emailController, passController);
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
                                        "Login",
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
                                  "Or sign in with",
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
                              InkWell(
                                onTap: (){
                                  cubit.signInWithGoogle();
                                },
                                child: Container(
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
                                    "Don't have an account?",
                                    style: TextStyle(
                                        color: blackColor,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUpPage1()));
                                      },
                                      child: Text(
                                        "Create Account",
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
