import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../models/user_model.dart';
import '../../modules/home_page.dart';
import '../network/local/cache_helper.dart';
import 'login_states.dart';

class LoginCubit extends Cubit<LoginStates>{
  LoginCubit(this.context) : super(LoginInitialState());

  final BuildContext context;

  static LoginCubit get(context) => BlocProvider.of(context);

  var fullNameController = TextEditingController();
  var phoneController = TextEditingController();
  var gender = "Male";


  bool hidden = true;
  bool hidden2 = true;

  void changeGender(String g){
    gender = g;
    emit(ChangeGenderState());
  }

  void changePassHidden(){
    hidden = !hidden;
    emit(ChangeButtonIconState());
  }

  void changePassHidden2(){
    hidden2 = !hidden2;
    emit(ChangeButtonIconState());
  }

  Future<void> registerAccount(TextEditingController nameController, TextEditingController emailController, TextEditingController passController, TextEditingController phoneController, String genderController) async {
    emit(SignUpLoadingState());
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
        email: emailController.text,
        password: passController.text)
        .then((value) {
      print("User with email: ${value.user!.email} and id: ${value.user!.uid} Added Successfully");
      createAccount(uId: value.user!.uid, name: nameController.text, email: emailController.text, phone: phoneController.text,gender: genderController);
      emit(SignUpSuccessfullyState());
    }).catchError((error) {
      if (error is FirebaseAuthException && error.code == 'email-already-in-use') {
        // Display an AlertDialog for email already in use
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Email Already in Use'),
              content: Text('The provided email is already registered.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);// Close the AlertDialog
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
    });
  }

  Future<void> createAccount(
      {required String uId, required String name, required String email, required String phone, required String gender}) async {
    UserModel userModel = UserModel(
        uId: uId, name: name, email: email, phone: phone, gender: gender);

    await FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(userModel.toMap())
        .then((value) {
      CacheHelper.putStringData(key: "uId", value: uId);
      Navigator.push(context, MaterialPageRoute(builder: (context)=> HomePage()));
      emit(SignUpDataSuccessfullyState());
    }).catchError((error) {
      print("error: $error");
    });
  }

  Future<void> loginAccount(TextEditingController emailController,TextEditingController passController) async {
    emit(LoginLoadingState());
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passController.text
    ).then((value)
    {
      print("user with ${value.user!.email} Signin Successfully Success");
      emit(LoginSuccessfullyState());
      CacheHelper.putStringData(key: "uId", value: value.user!.uid);
      Navigator.push(context, MaterialPageRoute(builder: (context)=> HomePage()));
      emit(HomePageState());
    })
        .catchError((error){
          print(error);
          if (error is FirebaseAuthException && error.code == 'wrong-password') {
            // Display an AlertDialog for email already in use
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text('Wrong Email or Password'),
                  content: Text('Wrong Email or Password.'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        emit(LoginInitialState());
                      },
                      child: Text('OK'),
                    ),
                  ],
                );
              },
            );
          }
    });
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    if(googleUser!=null&&googleAuth!=null){
      createAccount(uId: FirebaseAuth.instance.currentUser!.uid, name: googleUser.displayName!, email: googleUser.email, phone: "", gender: gender);
      CacheHelper.putStringData(key: "uId", value: FirebaseAuth.instance.currentUser!.uid);
      Navigator.push(context, MaterialPageRoute(builder: (context)=> HomePage()));
    }
    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

}