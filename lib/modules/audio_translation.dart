import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import './text2Sign.dart';
import 'package:speech_to_text/speech_to_text.dart';

class SpeechTranslationPage extends StatefulWidget {
  // const SpeechRecognitionScreen({super.key});
  static const routename = '/speech';

  @override
  State<SpeechTranslationPage> createState() =>
      _SpeechTranslationPageState();
}

class _SpeechTranslationPageState extends State<SpeechTranslationPage> {
  bool _speechEnabled = false;
  bool _isDone = false;
  bool _hasChanged = false;
  @override
  void initState() {
    super.initState();
    _initSpeech();
  }

  void _initSpeech() async {
    _speechEnabled = await speechToText.initialize();
    setState(() {});
  }

  void _startListening() async {
    await speechToText.listen(onResult: (result) {
      setState(() {
        representedText = result.recognizedWords;
      });
    });
  }

  var isnotListening = true;
  String representedText =
      "Start recording so we can understand your speech :)";
  SpeechToText speechToText = SpeechToText();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: AvatarGlow(
        endRadius: 95.0,
        animate: isnotListening, //bool
        duration: const Duration(milliseconds: 2000),
        glowColor: Theme.of(context).primaryColor,
        repeat: true,
        repeatPauseDuration: const Duration(milliseconds: 100),
        showTwoGlows: true,
        child: GestureDetector(
          child: CircleAvatar(
              backgroundColor: Theme.of(context).primaryColor,
              radius: isnotListening ? 35 : 60,
              foregroundColor: Colors.white,
              child: isnotListening ? Icon(Icons.mic) : Icon(Icons.mic_none)),
          onTapDown: (details) async {
            if (isnotListening) {
              _initSpeech();
              if (_speechEnabled) {
                setState(() {
                  isnotListening = false;
                });
                _startListening();
              }
            }
          },
          onTapUp: (details) {
            setState(() {
              isnotListening = true;
              _isDone = true;
              if (representedText ==
                      "Start recording so we can understand your speech :)" ||
                  representedText == "" ||
                  representedText == "Record again ...") {
                representedText =
                    "Please record again because we couldn't catch your speech";
                _hasChanged = false;
              } else {
                _hasChanged = true;
              }
            });
            speechToText.stop();
          },
        ),
      ),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: size.height * 0.5,
              child: Stack(children: [
                Container(
                  //width: double.infinity,
                  //height: size.height * 0.4 - 20,
                  width: size.width,
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(35),
                          bottomRight: Radius.circular(35))),
                  child: Container(
                    margin:
                        const EdgeInsets.only(top: 130, left: 20, bottom: 20),
                    padding: const EdgeInsets.only(right: 20),
                    child: Text(
                      // to be replaced with output from speech
                      representedText,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: 29,
                          fontFamily: "SFPro",
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
              ]),
            ),
            if (_isDone)
              Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(vertical: 5),
                  padding: EdgeInsets.all(10),
                  child: Text(
                    "Do you want to repeat your record?",
                    style: TextStyle(
                        fontSize: 23,
                        fontFamily: "SFPro",
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor),
                  )),
            if (_isDone) // Show "Yes" and "No" buttons if recording is done
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _isDone = false;
                        _speechEnabled = true;
                        representedText = "Record again ...";
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            10), // Set the desired border radius here
                      ),
                    ),
                    child: Text('Yes'),
                  ),
                  SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: () {
                      // Reset the recording to start again
                      //Navigator.of(context).pushNamed(routeName);
                      if (_hasChanged) {
                        Navigator.of(context).pushNamed(textToSign.routename,
                            arguments: representedText);
                        setState(() {
                          _isDone = false;
                          representedText =
                              "Start recording so we can understand your speech :)";
                        });
                      } else {
                        Null;
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            10), // Set the desired border radius here
                      ),
                    ),
                    child: Text('No'),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
