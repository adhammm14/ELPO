import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:elpo/modules/login_pages/signin_page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../shared/login_cubit/login_cubit.dart';
import '../../shared/login_cubit/login_states.dart';
import '../../shared/styles/colors.dart';

class SignUpPage2 extends StatefulWidget {
  TextEditingController EmailController;
  TextEditingController PasswordController;
  SignUpPage2(this.EmailController,this.PasswordController,{super.key});

  @override
  State<SignUpPage2> createState() => _SignUpPage2State(EmailController!,PasswordController!);
}

class _SignUpPage2State extends State<SignUpPage2> {
  TextEditingController EmailController;
  TextEditingController PasswordController;
  _SignUpPage2State(this.EmailController,this.PasswordController);
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
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 3),
                                decoration: BoxDecoration(
                                    color: lightGreyColor,
                                    borderRadius: BorderRadius.circular(15)),
                                child: TextFormField(
                                  controller: cubit.fullNameController,
                                  cursorColor: heavyGreyColor,
                                  decoration: InputDecoration(
                                    hintText: "Name",
                                    hintStyle: TextStyle(
                                        color: heavyGreyColor, fontSize: 18),
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty ||
                                        !value.contains(new RegExp(r'[a-z]')) ||
                                        value.contains(new RegExp(r'[0-9]'))) {
                                      return "Please Enter Valid Name";
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Container(
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 3),
                                decoration: BoxDecoration(
                                    color: lightGreyColor,
                                    borderRadius: BorderRadius.circular(15)),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 60,
                                      child: Row(
                                        children: [
                                          SvgPicture.asset("assets/icons/egypt.svg",width: 20,),
                                          SizedBox(width: 5,),
                                          Text("+20",style: TextStyle(color: heavyGreyColor,fontSize: 17),),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: TextFormField(
                                        controller: cubit.phoneController,
                                        cursorColor: heavyGreyColor,
                                        decoration: InputDecoration(
                                          hintText: "Phone Number",
                                          hintStyle: TextStyle(
                                              color: heavyGreyColor, fontSize: 18),
                                          border: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                        ),
                                        validator: (value) {
                                          if (value!.isEmpty ||
                                              value.length < 10 ||
                                              !value.contains(
                                                  RegExp(r'[0-9]'))) {
                                            return "Please Enter Valid Phone Number";
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      cubit.changeGender("Male");
                                    },
                                    child: Container(
                                      width: 150,
                                      height: 80,
                                      padding: EdgeInsets.all(15),
                                      decoration: BoxDecoration(
                                        color: lightGreyColor,
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(color: cubit.gender=="Male" ? greenColor : Colors.transparent,width: 2)
                                      ),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SvgPicture.asset(
                                              "assets/icons/male.svg",
                                            width: 30,
                                            color: greenColor,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            "Male",
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      cubit.changeGender("Female");
                                    },
                                    child: Container(
                                      width: 150,
                                      height: 80,
                                      padding: EdgeInsets.all(15),
                                      decoration: BoxDecoration(
                                        color: lightGreyColor,
                                        borderRadius: BorderRadius.circular(10), border: Border.all(color: cubit.gender=="Female" ? greenColor : Colors.transparent,width: 2),
                                      ),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SvgPicture.asset(
                                            "assets/icons/female.svg",
                                            width: 30,
                                            color: greenColor,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            "Female",
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 130,
                              ),
                              Center(
                                child: Text(
                                  "By clicking, you agree to our terms and conditions and acknowledge that you have read our privacy policy.",
                                  style: TextStyle(
                                    color: heavyGreyColor,
                                    fontSize: 13,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              ConditionalBuilder(
                                condition: state is! LoginLoadingState,
                                builder: (context) => InkWell(
                                  onTap: () {
                                    if (formKey.currentState!.validate()) {
                                      cubit.registerAccount(cubit.fullNameController,EmailController,PasswordController,cubit.phoneController,cubit.gender);
                                      print("SignUp done!");
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
                                        "Create Account",
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
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    LoginPage()));
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
