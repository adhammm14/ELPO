import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:elpo/shared/bloc/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tflite/flutter_tflite.dart';
import 'package:image_picker/image_picker.dart';

class TranslateCubit extends Cubit<States> {
  TranslateCubit() : super(initialState());

  static TranslateCubit GET(context) => BlocProvider.of(context);

  List<XFile> images = [];
  XFile? image;
  String translated = "";
  bool isloaded = true;

  Future pickImages() async {
    image = null;
    images.clear();
    await ImagePicker()
        .pickMultiImage()
        .then((value) => value.forEach((element) => images.add(element)));
  }

  Widget displayImages(BuildContext context) {
    return CarouselSlider(
        items: images
            .map((e) => SizedBox(
                  child: Image.file(
                    File(e.path),
                  ),
                ))
            .toList(),
        options:
            CarouselOptions(viewportFraction: 1, enableInfiniteScroll: false));
  }

  Future shootImage() async {
    images.clear();
    image = await ImagePicker().pickImage(source: ImageSource.camera);
  }

  Future predict() async {
    translated = "";
    if (images.isNotEmpty) {
      for (var img in images) {
        var predict = await Tflite.runModelOnImage(
            path: img.path, imageMean: 127.5, imageStd: 127.5);
        translated += " ${predict![0]["label"]}";
      }
    } else {
      var predict = await Tflite.runModelOnImage(
          path: image!.path, imageMean: 127.5, imageStd: 127.5);
      translated = predict![0]["label"];
    }
  }

  Future predictImage() async {
    // ML model with API
    FormData formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(image!.path, filename: "image"),
    });
    await Dio()
        .post("http://192.168.1.6:8000/", data: formData)
        .then((value) => translated = value.data["prediction"]);
  }
}
