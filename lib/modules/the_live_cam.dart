import 'dart:io';
import 'dart:ui';
import 'package:elpo/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter_tflite/flutter_tflite.dart' as t;

class LiveTranslationPage extends StatefulWidget {
  static const routeName = '/thecam';

  const LiveTranslationPage({Key? key}) : super(key: key);

  @override
  State<LiveTranslationPage> createState() => _LiveTranslationPageState();
}

class _LiveTranslationPageState extends State<LiveTranslationPage> {
  bool _isModelReady = false;
  late List<dynamic> _output = [];
  late CameraController _cameraController;
  late List<CameraDescription> cameras;

  @override
  void initState() {
    super.initState();
    loadModel().then((_) {
      setState(() {
        _isModelReady = true;
      });
    });
    initializeCamera();
  }

  Future<void> initializeCamera() async {
    try {
      cameras = await availableCameras();
      for (var camera in cameras) {
        if (camera.lensDirection == CameraLensDirection.front) {
          _cameraController = CameraController(camera, ResolutionPreset.medium);
          await _cameraController.initialize();
          break;
        }
      }

      if (!mounted) return;
      setState(() {});
    } catch (e) {
      print('Error initializing camera: $e');
    }
  }

  Future<void> loadModel() async {
    try {
      String modelPath = 'assets/x.tflite';
      String labelsPath = 'assets/labels.txt';

      await t.Tflite.loadModel(
        model: modelPath,
        labels: labelsPath,
        isAsset: true,
      );
    } catch (e) {
      print('Error loading model: $e');
    }
  }

  void runInferenceOnFrame(CameraImage image) async {
    if (!_isModelReady) {
      return;
    }

    try {
      var output = await t.Tflite.runModelOnFrame(
        bytesList: image.planes.map((plane) => plane.bytes).toList(),
        imageHeight: image.height,
        imageWidth: image.width,
        imageMean: 127.5,
        imageStd: 127.5,
        numResults: 2,
        threshold: 0.1,
        asynch: true,
      );
      print(output);
      setState(() {
        _output = output!;
      });
    } catch (e) {
      print('Error running inference: $e');
    }
  }

  void startImageStream() {
    if (!_isModelReady || !_cameraController.value.isInitialized) {
      return;
    }

    _cameraController.startImageStream((image) {
      runInferenceOnFrame(image);
    });
  }

  void stopImageStream() {
    _cameraController.stopImageStream();
  }

  @override
  Widget build(BuildContext context) {
    if (!_cameraController.value.isInitialized) {
      return Container();
    }

    final screenHeight = MediaQuery.of(context).size.height;
    final previewWidth = _cameraController.value.previewSize!.height;
    final previewHeight = _cameraController.value.previewSize!.width;
    final screenWidth = screenHeight * previewWidth / previewHeight;

    return Scaffold(
      body: Stack(
        //mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: screenHeight,
            width: screenWidth,
            margin: EdgeInsets.only(top: 5),
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.all(Radius.circular(15))),
            child: AspectRatio(
              aspectRatio: 1,
              child: CameraPreview(_cameraController),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                // ClipRRect is used to ensure the child's content is clipped within the container's rounded corners
                borderRadius: BorderRadius.circular(10),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  // Adjust the sigma values for the blur effect
                  child: Container(
                    color: Colors.black.withOpacity(0.2),
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      color: Colors.white,
                      icon: Icon(Icons.arrow_back_ios_new, size: 20),
                    ),
                  ),
                ),
              ),
            ),
          ),
          if(_cameraController.value.isStreamingImages)
            SafeArea(
              child: Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.red,
                            radius: 5,
                          ),
                          SizedBox(width: 5,),
                          Text("Recording",style: TextStyle(color: whiteColor),),
                        ],
                      ),
                    ),
                  ),
                ),
              )
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                (_output.isNotEmpty)
                    ? ClipRRect(
                        // ClipRRect is used to ensure the child's content is clipped within the container's rounded corners
                        borderRadius: BorderRadius.circular(10),
                        child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                            // Adjust the sigma values for the blur effect
                            child: Container(
                              padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                  color: Colors.black54,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              // color: Colors.black54,
                              child: _output.isEmpty
                                  ? Center(
                                      child: Text(
                                        "Please Start doing some action !",
                                        style: TextStyle(fontSize: 30),
                                      ),
                                    )
                                  : Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        for (var prediction in _output)
                                          Text(
                                            "Current Action : " +
                                                '${_output.first['label'].toString().substring(1)}',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontFamily: "SFPro",
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                      ],
                                    ),
                            )),
                      )
                    : Container(
                        margin: EdgeInsets.only(top: 20),
                        padding: EdgeInsets.all(15),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              "assets/img/pngimg.com - question_mark_PNG87.png",
                              height: 90,
                              width: 90,
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              "Please Start Doing Some Action ...",
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontFamily: "SFPro",
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ElevatedButton(
                      onPressed: () {
                        if (_cameraController.value.isStreamingImages) {
                          stopImageStream();
                        } else {
                          startImageStream();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40),
                        ),
                        padding: EdgeInsets.all(17),
                      ),
                      child: Icon(
                        _cameraController.value.isStreamingImages
                            ? Icons.stop
                            : Icons.play_arrow,
                        size: 30,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    stopImageStream();
    _cameraController.dispose();
    t.Tflite.close();
    super.dispose();
  }
}
