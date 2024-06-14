//KelimeBilgisiSec Secreen
import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:word_wizard/Models/kategoriler.dart';
import 'package:word_wizard/Models/kelime.dart';
import 'package:word_wizard/Screens/gozdengecir.dart';
import 'package:word_wizard/dosyaIslem.dart';
import 'package:word_wizard/main.dart';

class KelimeBilgisi extends StatefulWidget {
  int secilenKategoriIndex = 0;
  KelimeBilgisi({required this.secilenKategoriIndex, super.key});

  @override
  State<KelimeBilgisi> createState() => stateKelimeBilgisi();
}

// ignore: camel_case_types
class stateKelimeBilgisi extends State<KelimeBilgisi> {
  bool isFirst = true;
  stateKelimeBilgisi();
  AudioPlayer audioPlayer = AudioPlayer();
  bool isPressed = false;
  bool isAnimating = false;
  String imagePath = "";
  String voicePath = "";
  int currentIndex = 0;
  int trindex = 0;
  int engindex = 0;
  int voiceindex = 0;
  int imageindex = 0;
  int ogren = 0;
  double _initial = 0.1;
  // ignore: unused_element

  Widget _stepIndicator() {
    return (LinearProgressIndicator(
      borderRadius: BorderRadius.circular(12.0),
      backgroundColor: Colors.grey[350],
      valueColor: const AlwaysStoppedAnimation(Colors.green),
      minHeight: 10.0,
      value: _initial,
    ));
  }

  String fillListtr() {
    String words = Kategoriler.kategoriler[widget.secilenKategoriIndex]
        .kelimeListesi[engindex].ingilizce;
    return words;
  }

  String fillListeng() {
    String words = Kategoriler
        .kategoriler[widget.secilenKategoriIndex].kelimeListesi[trindex].turkce;
    return words;
  }

  void playSound() async  {
    await audioPlayer.play(AssetSource(
        "audios/${Kategoriler.kategoriler[widget.secilenKategoriIndex].kelimeListesi[voiceindex].ingilizce}.m4a"));
  }


  void ogrenilenkelimeler(int i) {
    if(Kategoriler.kategoriler[widget.secilenKategoriIndex]
        .kelimeListesi[i].ogrenildi != true){
                Kategoriler.kategoriler[widget.secilenKategoriIndex]
                  .kelimeListesi[i].ogrenildi = true;
        }
      
  }

  @override
  Widget build(BuildContext context) {
    /*
    if (isFirst) {
      fillListtr();
      isFirst = false;
    }
    if (isFirst) {
      fillListeng();
      isFirst = false;
    }
    fillListeng();
    fillListtr();
    */
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: const Text(
                "Kelime Bilgisi",
                style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
              ),
            ),
            //backgroundColor: Colors.blueGrey,
            body: Column(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: _stepIndicator(),
                        ),
                      ),
                      /*
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.more_horiz,
                  color: Colors.blueAccent,
                  size: 35,
                ),
              ),
              */
                    ],
                  ),
                ),
                const Padding(padding: EdgeInsets.only(bottom: 15)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Visibility(
                        visible: currentIndex !=
                            0, // Eğer index 0 değilse görünür yap
                        child: IconButton(
                          onPressed: () {
                            setState(() {
                              if (currentIndex != 0) {
                                _initial -= 0.1;
                                currentIndex = (currentIndex - 1);
                                trindex -= 1;
                                engindex -= 1;
                                voiceindex -= 1;
                                imageindex -= 1;
                              } else {}
                            });
                          },
                          icon: const Icon(
                            Icons.arrow_back_ios_sharp,
                            color: Colors.grey,
                            size: 28,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 10,
                      child: Container(
                        width: 390,
                        height: 270,
                        margin: const EdgeInsets.only(
                            bottom: 50, left: 15, right: 15, top: 23),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(1.0),
                          borderRadius: BorderRadius.circular(30),
                          image: DecorationImage(
                              image: AssetImage(imagePath =
                                  "assets/images/${Kategoriler.kategoriler[widget.secilenKategoriIndex].kelimeListesi[imageindex].ingilizce}.jpg")),
                          boxShadow: [
                            BoxShadow(
                              color: const Color.fromARGB(201, 134, 137, 125)
                                  .withOpacity(0.3),
                              spreadRadius: 4,
                              blurRadius: 2,
                              offset: const Offset(0, 0),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: IconButton(
                        padding: const EdgeInsets.only(left: 0),
                        onPressed: () {
                          setState(() {
                            if(currentIndex==9)
                              Kategoriler.kategoriler[widget.secilenKategoriIndex].kelimeListesi[currentIndex].ogrenildi = true;
                            if (currentIndex < 9) {
                              // Değişiklik burada
                              _initial += 0.1;
                              ogrenilenkelimeler(currentIndex);
                              //currentIndex = (currentIndex + 1);
                              trindex += 1;
                              engindex += 1;
                              voiceindex += 1;
                              imageindex += 1;
                            } else {
                              Kategoriler.kategoriler[widget.secilenKategoriIndex].oyunlar[0] = true;
                              DosyaIslem.writeToFile();
                              Navigator.pop(context);
                            }
                            currentIndex++;
                          });
                        },
                        icon: const Icon(
                          Icons.arrow_forward_ios_sharp,
                          color: Colors.grey,
                          size: 28,
                        ),
                      ),
                    )
                  ],
                ),
                Text(
                  fillListtr(),
                  style: const TextStyle(
                    
                      fontSize: 30, fontWeight: FontWeight.bold),
                ),
                Container(
                  margin: const EdgeInsets.only(
                      bottom: 20, left: 50, right: 50, top: 35),
                  width: 360,
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(1.0),
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: const Color.fromARGB(201, 134, 137, 125)
                            .withOpacity(0.3),
                        spreadRadius: 4,
                        blurRadius: 2,
                        offset: const Offset(0, 0),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          flex: 9,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(fillListeng(),
                                  style: const TextStyle(
                                    color: Colors.black,
                                      fontSize: 25,
                                      fontWeight: FontWeight.w400)),
                            ],
                          )),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkResponse(
                        onTap: () {
                          setState(() {
                            isPressed = !isPressed;
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: Ink(
                            decoration: ShapeDecoration(
                              color: Colors.blue, // Buton rengi
                              shape: const CircleBorder(),
                              shadows: [
                                BoxShadow(
                                  color: isPressed
                                      ? Colors.green
                                      : const Color.fromARGB(0, 183, 173, 95),
                                  spreadRadius: 4,
                                  blurRadius: 5,
                                  offset: const Offset(0, 0),
                                ),
                              ],
                            ),
                            child: SizedBox(
                              width: 54.0,
                              height: 54.0,
                              child: IconButton(
                                icon: const Icon(Icons.mic),
                                color: Colors.white,
                                onPressed: () {
                                  playSound();
                                  setState(() {
                                    isPressed = !isPressed;
                                    Timer(const Duration(seconds: 2), () {
                                      setState(() {
                                        isPressed =
                                            false; // 3 saniye sonra gölgeyi kapat
                                      });
                                    });
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                      /*
              FloatingActionButton(
                  onPressed: () {
                    Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => GozdenGecir()),
                    );
                  },
                  child: const Icon(Icons.remove_red_eye_sharp)),
                  */
                    ],
                  ),
                )
              ],
            )));
  }
}
