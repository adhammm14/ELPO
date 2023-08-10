import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tflite/flutter_tflite.dart';

import '../shared/bloc/cubit.dart';
import '../shared/bloc/states.dart';

class ImageTranslationPage extends StatefulWidget {
  const ImageTranslationPage({super.key});

  @override
  State<ImageTranslationPage> createState() => _ImageTranslationPageState();
}

class _ImageTranslationPageState extends State<ImageTranslationPage> {
  @override
  void initState() {
    super.initState();
    Tflite.loadModel(
            model: "assets/model.tflite",
            labels: "assets/labels.txt",
            numThreads: 3,
            isAsset: true,
            useGpuDelegate: false)
        .then((_) => print(_))
        .catchError((onError) => print(onError));
  }

  @override
  void dispose() {
    super.dispose();
    Tflite.close();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TranslateCubit(),
      child: BlocBuilder<TranslateCubit, States>(builder: (context, states) {
        return Scaffold(
            floatingActionButton: TranslateCubit.GET(context).isloaded
                ? FloatingActionButton(
                    onPressed: () async {
                      TranslateCubit.GET(context).isloaded = false;
                      TranslateCubit.GET(context).emit(Update());
                      TranslateCubit.GET(context).predict().then((value) {
                        TranslateCubit.GET(context).isloaded = true;
                        TranslateCubit.GET(context).emit(Update());
                      });
                    },
                    backgroundColor: Colors.green[400],
                    child: Icon(
                      Icons.translate,
                      color: Colors.white,
                    ),
                  )
                : CircularProgressIndicator(),
            appBar: AppBar(
              title: Text("Translate Sign Language"),
              backgroundColor: Colors.green[400],
            ),
            body: Column(
              children: [
                Container(
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(20)),
                  width: MediaQuery.of(context).size.width - 50,
                  height: MediaQuery.of(context).size.height / 3,
                  child: Center(
                      child: TranslateCubit.GET(context).image == null
                          ? TranslateCubit.GET(context).images.isEmpty
                              ? const Text("Choose photos...",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold))
                              : TranslateCubit.GET(context)
                                  .displayImages(context)
                          : Image.file(
                              File(TranslateCubit.GET(context).image!.path))),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      height: 100,
                      width: 100,
                      child: ElevatedButton(
                        onPressed: () async {
                          await TranslateCubit.GET(context).shootImage().then(
                              (value) => TranslateCubit.GET(context)
                                  .emit(RefreshImages()));
                        },
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20))),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.green[400]),
                        ),
                        child: const Icon(
                          Icons.camera_alt_outlined,
                          size: 50,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 100,
                      height: 100,
                      child: ElevatedButton(
                        onPressed: () async {
                          await TranslateCubit.GET(context).pickImages().then(
                              (value) => TranslateCubit.GET(context)
                                  .emit(RefreshImages()));
                        },
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20))),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.green[400]),
                        ),
                        child: const Icon(
                          Icons.photo_library_rounded,
                          size: 50,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                    margin: const EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width - 50,
                    height: MediaQuery.of(context).size.height / 4,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.black, width: 2),
                    ),
                    child: TranslateCubit.GET(context).translated == ""
                        ? const Center(
                            child: Text("Nothing to show",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                          )
                        : SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Center(
                                child: Text(
                                  "${TranslateCubit.GET(context).translated}",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          )),
                IconButton(
                    onPressed: () async {
                      await Clipboard.setData(ClipboardData(
                              text: TranslateCubit.GET(context).translated))
                          .then((value) => ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text(
                                  "Copied to clipboard!",
                                  style: TextStyle(color: Colors.white),
                                ),
                                backgroundColor: Colors.green,
                              )));
                    },
                    icon: Icon(Icons.copy))
              ],
            ));
      }),
    );
  }
}
