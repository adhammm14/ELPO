import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import '../models/SignLanguage.dart';

class textToSign extends StatelessWidget {
  static const routename = '/text2sign';

  @override
  Widget build(BuildContext context) {
    final SignLanguageSymbolList symbolList = SignLanguageSymbolList();
    final String recognizedSentence =
        ModalRoute.of(context)?.settings.arguments as String;

    //final String recognizedSentence = "i want to say thank you";
    List<SignLanguageSymbol> matchedSymbols = symbolList.searchSymbols(
        recognizedSentence); // testing the screen only "Replace the string with recognizedSentence "

    // Split the recognized sentence into words
    List<String> words = recognizedSentence.split(' ');

    return Scaffold(
      appBar: AppBar(
        // title: Text('Text to Sign'),
        elevation: 0,
        backgroundColor: Colors.grey[100],
        iconTheme: IconThemeData(color: Colors.deepOrange),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.4,
              margin: EdgeInsets.only(
                top: 60,
              ),
              child: Swiper(
                itemCount: matchedSymbols.length,
                itemBuilder: (context, index) {
                  final symbol = matchedSymbols[index];
                  return Column(
                    children: [
                      Text(
                        "Your Translated Sentence",
                        style: TextStyle(
                            fontSize: 23,
                            fontFamily: "SFPro",
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10, bottom: 5),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: Offset(0, 3),
                            ),
                          ],
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          child: Image.asset(
                            fit: BoxFit.fill,
                            symbol.image,
                            height: 200,
                            width: 200,
                          ),
                        ),
                      ),
                      Container(
                        child: Text(
                          symbol.title,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  );
                },
                pagination: SwiperPagination(
                  builder: DotSwiperPaginationBuilder(
                    color: Colors.grey,
                    activeColor: Theme.of(context).primaryColor,
                    size: 10,
                    activeSize: 12,
                    space: 5,
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.only(top: 10),
              child: Text(
                recognizedSentence,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 23,
                    fontFamily: "SFPro",
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[500]),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Theme.of(context).primaryColor,
              ),
              width: double.infinity,
              child: MaterialButton(
                onPressed: () {},
                child: const Text(
                  'Go To Dictionary',
                  style: const TextStyle(
                      color: Colors.white,
                      fontFamily: "SFPro",
                      fontWeight: FontWeight.bold,
                      fontSize: 14),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
