import 'package:elpo/modules/audio_translation.dart';
import 'package:elpo/modules/text2Sign.dart';
import 'package:elpo/modules/the_live_cam.dart';
import 'package:elpo/modules/translateSignLanguage.dart';
import 'package:elpo/shared/styles/colors.dart';
import 'package:flutter/material.dart';

import '../shared/components/components.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var screenWidht = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            child: ClipOval(
                child: Image.network("https://media.licdn.com/dms/image/D4D03AQF2DyHNjp_pxA/profile-displayphoto-shrink_400_400/0/1666910027998?e=1696464000&v=beta&t=rcIKq5AaKOwQNR6ImEfPDZSlbjZZDPvoBaP_RksuGeE")),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Discover the Beauty of Sign Language.",style: TextStyle(fontFamily: "NTF",fontSize: 35),),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => LiveTranslationPage()));
                    },
                    child: Container(
                      width: screenWidht / 1.75,
                      height: screenHeight / 6.2,
                      decoration: BoxDecoration(
                          color: lightGreyColor,
                          borderRadius: BorderRadius.circular(10)),
                      child: Image.asset(
                        "assets/images/live.jpg",
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SpeechTranslationPage()));
                    },
                    child: Container(
                      width: screenWidht / 3.3,
                      height: screenHeight / 6.2,
                      decoration: BoxDecoration(
                          color: lightGreyColor,
                          borderRadius: BorderRadius.circular(10)),
                      child: Image.asset(
                        "assets/images/audio.jpg",
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ImageTranslationPage()));
                    },
                    child: Container(
                      width: screenWidht / 3.3,
                      height: screenHeight / 6.2,
                      decoration: BoxDecoration(
                          color: lightGreyColor,
                          borderRadius: BorderRadius.circular(10)),
                      child: Image.asset(
                        "assets/images/upload.jpg",
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => textToSign()));
                    },
                    child: Container(
                      width: screenWidht / 1.75,
                      height: screenHeight / 6.2,
                      decoration: BoxDecoration(
                          color: lightGreyColor,
                          borderRadius: BorderRadius.circular(10)),
                      child: Image.asset(
                        "assets/images/book.jpg",
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20,),
              Text("Recently Signs",style: TextStyle(fontFamily: "NTF",fontSize: 25),),
              SizedBox(height: 10,),
              Container(
                height: screenHeight/3.3,
                child: ListView.builder(
                    itemCount: iconsList.length,
                    itemBuilder: (BuildContext context, int index){
                      return Container(
                        margin: EdgeInsets.symmetric(vertical: 5),
                        padding: EdgeInsets.all(10),
                        height: screenHeight/10,
                        decoration: BoxDecoration(
                          color: lightGreyColor,
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                color: whiteColor,
                                borderRadius: BorderRadius.circular(5)
                              ),
                              child: Icon(iconsList[index]),
                            ),
                            SizedBox(width: 10,),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(labels[index],style: TextStyle(fontFamily: "NTF",fontSize: 22),overflow: TextOverflow.ellipsis,),
                                  Text("from 3 min ago",style: TextStyle(fontFamily: "NTF",fontSize: 16,color: heavyGreyColor),),
                                ],
                              ),
                            ),
                            SizedBox(width: 10,),
                            IconButton(
                                onPressed: (){},
                                icon: Icon(Icons.delete),
                            ),
                          ],
                        ),
                      );
                    }
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
