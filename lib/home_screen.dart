import 'dart:io';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

List decodedText = [];

bool showSpinner = false;

var speakString;

bool isPlaying = false;

class _HomeScreenState extends State<HomeScreen> {

  Future _speak() async {
    FlutterTts flutterTts = FlutterTts();
    setState(() {
      isPlaying = true;
    });
    if (decodedText.isEmpty){
      await flutterTts.speak('Make sure you\'ve selected a clear image for us to interpret.');
    }
    else if (decodedText.isNotEmpty){
      await flutterTts.speak(decodedText.toString());
    }
  }

  @override
  void dispose() {
    FlutterTts flutterTts = FlutterTts();
    super.dispose();
    flutterTts.stop();
  }

  Future _stop() async{
    setState(() {
      isPlaying = false;
    });
    FlutterTts flutterTts = FlutterTts();
    await flutterTts.stop();
  }

  File pickedImage;

  Future pickImage() async {
    setState(() {
      showSpinner = true;
    });
    var tempStore = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      pickedImage = tempStore;
    });
    if (pickedImage != null){
      readText();
    }
  }

  Future readText() async {
    FirebaseVisionImage ourImage = FirebaseVisionImage.fromFile(pickedImage);
    TextRecognizer recognizeText = FirebaseVision.instance.textRecognizer();
    VisionText readText = await recognizeText.processImage(ourImage);

    for (TextBlock block in readText.blocks){
      setState(() {
        decodedText.add(block.text);
      });
//      for (TextLine line in block.lines){
//        for (TextElement word in line.elements){
//          print(word.text);
//        }
//      }
    }
    setState(() {
      showSpinner = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigoAccent,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width * 2,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(
                        Radius.circular(25),
                      ),
                      child: Container(
                        margin: EdgeInsets.all(10),
                        width: double.infinity,
                        height: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(25),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black45,
                                offset: Offset(2, 1),
                                blurRadius: 8,
                              ),
                            ]),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(25),
                          child: Container(
                            child: Center(
                              child: Stack(
                                children: <Widget>[
                                  Center(
                                    child: pickedImage != null
                                        ? Padding(
                                      padding: EdgeInsets.all(25),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(25),
                                            child: Image.file(pickedImage, fit: BoxFit.contain,),
                                          ),
                                        )
                                        : Text('Pick An Image!'),
                                  ),
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Padding(
                                      padding: EdgeInsets.all(8),
                                      child: ClipOval(
                                        child: Material(
                                          color: Colors.indigoAccent,
                                          child: InkWell(
                                            child: SizedBox(
                                                width: 40,
                                                height: 40,
                                                child: Icon(
                                                  Icons.delete,
                                                  size: 25,
                                                  color: Colors.white,
                                                )),
                                            onTap: () {
                                              setState(() {
                                                decodedText.clear();
                                                isPlaying == false ? _speak : _stop;
                                              });
                                              setState(() {
                                                pickedImage = null;
                                              });
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: Padding(
                                      padding: EdgeInsets.all(8),
                                      child: ClipOval(
                                        child: Material(
                                          color: Colors.indigoAccent,
                                          child: InkWell(
                                            child: SizedBox(
                                                width: 40,
                                                height: 40,
                                                child: Icon(
                                                  Icons.add,
                                                  size: 25,
                                                  color: Colors.white,
                                                )),
                                            onTap: () {
                                              pickImage();
                                              setState(() {
                                                decodedText.clear();
                                              });
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(
                        Radius.circular(25),
                      ),
                      child: Container(
                        margin: EdgeInsets.all(10),
                        width: double.infinity,
                        height: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(25),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black45,
                                offset: Offset(2, 1),
                                blurRadius: 8,
                              ),
                            ]),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(25),
                          child: Container(
                            child: Center(
                              child: Stack(
                                children: <Widget>[
                                  Center(
                                    child: decodedText.isNotEmpty ? ListView.builder(
                                      scrollDirection: Axis.vertical,
                                        itemCount: decodedText.length,
                                        itemBuilder: (context, index) {
                                          return Center(child: Padding(child: Text(decodedText[index]), padding: EdgeInsets.symmetric(horizontal: 15),));
                                        }) : Center(child: Text('Make sure you\'ve selected a clear image for us to interpret', textAlign: TextAlign.center,),),
                                  ),
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Padding(
                                      padding: EdgeInsets.all(8),
                                      child: ClipOval(
                                        child: Material(
                                          color: Colors.indigoAccent,
                                          child: InkWell(
                                            child: SizedBox(
                                                width: 40,
                                                height: 40,
                                                child: Icon(
                                                  Icons.content_copy,
                                                  size: 25,
                                                  color: Colors.white,
                                                )),
                                            onTap: () {
                                              Clipboard.setData(ClipboardData(text: decodedText.toString()));
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: Padding(
                                      padding: EdgeInsets.all(8),
                                      child: ClipOval(
                                        child: Material(
                                          color: Colors.indigoAccent,
                                          child: InkWell(
                                            child: SizedBox(
                                                width: 40,
                                                height: 40,
                                                child: Icon(
                                                  Icons.music_note,
                                                  size: 25,
                                                  color: Colors.white,
                                                )),
                                            onTap: isPlaying == false ? _speak : _stop,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
