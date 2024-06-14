import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:word_wizard/Models/kategoriler.dart';
import 'package:word_wizard/Models/kelime.dart';
import 'package:word_wizard/dosyaIslem.dart';

final class KelimeSecScreen extends StatefulWidget {
  int secilenKategoriIndex = 0;
  KelimeSecScreen({super.key, required this.secilenKategoriIndex});

  @override
  State<KelimeSecScreen> createState() => KelimeSecScreenState();
}

final class KelimeSecScreenState extends State<KelimeSecScreen> {
// DEĞİŞKENLER

  List<Kelime> words = [];
  List<Question> seenQuestions = [];
  Kelime? correctWord;
  List<Kelime> options = [];
  String imagePath = "";
  Color buttonColor1 = Colors.blue;
  Color buttonColor2 = Colors.blue;
  int index = 0;

  void getWords() {
    words = Kategoriler.kategoriler[widget.secilenKategoriIndex].kelimeListesi;
  }

// RASTGELE KELİME ALMA FONKSİYONU
  Kelime? generateRandomWord() {
    if (words.isNotEmpty) {
      Kelime generatedAnsver = words[Random().nextInt(words.length)];
      words = List.from(words)..remove(generatedAnsver);
      return generatedAnsver;
    } else {
      return null;
    }
  }

// YANLIŞ SEÇENEKLERİ OLUŞTURMA FONKSİYONU
  Kelime generateUncorrectWord(Kelime correctAnsver) {
    List<Kelime> otherWords = List.from(
        Kategoriler.kategoriler[widget.secilenKategoriIndex].kelimeListesi)
      ..remove(correctAnsver);
    return otherWords[Random().nextInt(otherWords.length)];
  }

// SORU OLUŞTURMA FONKSİYONU
  void generateQuestion() {
    index += 1;
    correctWord = generateRandomWord();
    if (correctWord != null) {
      imagePath = "assets/images/${correctWord!.ingilizce}.jpg";
      options = [correctWord!, generateUncorrectWord(correctWord!)];
      var newQuestion = Question(word: correctWord, options: options);
      seenQuestions.add(newQuestion);
    } else {
      print("nul geldi");
    }
    options.shuffle();
  }

// SONRAKİ SORUYA GEÇME
  void nextQuestion() {
    if (index + 1 < seenQuestions.length) {
      index += 1;
      setState(() {
        correctWord = seenQuestions[index].word;
        imagePath = "assets/images/${correctWord!.ingilizce}.jpg";
        options = seenQuestions[index].options;
      });
    } else {
      setState(() {
        generateQuestion();
      });
    }
  }

// ÖNCEKİ SORUYA DÖNME
  void prevQuestion() {
    if (index > 0) {
      index -= 1;
      setState(() {
        correctWord = seenQuestions[index].word;
        imagePath = "assets/images/${correctWord!.ingilizce}.jpg";
        options = seenQuestions[index].options;
      });
    } else {
      print("önceki soru yok");
    }
  }

// CEVAP KONTROL FONKSİYONU
  bool checkAnswer(Kelime selectedWord) {
    if (selectedWord.ingilizce == correctWord!.ingilizce) {
      return true;
    } else {
      return false;
    }
  }

// RESET FONKSİYONU
  void resetGame() {
    getWords();
    seenQuestions = [];
    index = 0;
    nextQuestion();
  }

// ALERT FONKSİYONU

  showAlertDialog(BuildContext context) {
    Widget cancelButton = FilledButton(
      child: const Text(
        "Bitir",
        style: TextStyle(fontSize: 19),
      ),
      onPressed: () {
        Navigator.pop(context);
        Navigator.pop(context);
      },
    );
    Widget continueButton = FilledButton(
      child: const Text(
        "Tekrar Oyna",
        style: TextStyle(fontSize: 19),
      ),
      onPressed: () {
        resetGame();
        Navigator.pop(context);
      },
    );

    AlertDialog alert = AlertDialog(
      title: const Text(
        textAlign: TextAlign.center,
        "Tebrikler",
        style: TextStyle(fontSize: 22),
      ),
      content: const Text(
        textAlign: TextAlign.center,
        "Tüm kelimeleri tamamladınız. Tekrar oynamak ister misiniz",
      ),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  void initState() {
    super.initState();
    getWords();
    generateQuestion();
  }

// KULLANICI ARAYÜZÜ
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Kelime Seç',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
// PROGRESS
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: LinearProgressIndicator(
                minHeight: 10,
                borderRadius: BorderRadius.circular(12),
                backgroundColor: Colors.grey,
                valueColor: const AlwaysStoppedAnimation(Colors.blue),
                value: (index) / 10,
              ),
            ),

            const Spacer(),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Spacer(),
// GERİ
                IconButton(
                  onPressed: (() => prevQuestion()),
                  icon: const Icon(Icons.arrow_back_ios),
                  style: const ButtonStyle(
                    alignment: Alignment.centerLeft,
                  ),
                ),
// RESİM
                Container(
                  width: 250,
                  height: 250,
                  margin: const EdgeInsets.only(
                      bottom: 50, left: 15, right: 15, top: 23),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(1.0),
                    borderRadius: BorderRadius.circular(30),
                    image: DecorationImage(
                      image: AssetImage(imagePath),
                    ),
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

// İLERİ
                IconButton(
                  onPressed: () {
                    if (seenQuestions.length == 10) {
                      showAlertDialog(context);
                    } else {
                      nextQuestion();
                    }
                  },
                  icon: const Icon(Icons.arrow_forward_ios),
                  style: const ButtonStyle(
                    alignment: Alignment.centerRight,
                  ),
                ),
                const Spacer()
              ],
            ),
            const SizedBox(height: 20),
// SEÇENEKLER

            // 1. SEÇENEK BUTONU

            const Spacer(),
            SizedBox(
              width: 200,
              height: 50,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(buttonColor1),
                ),
                child: Text(
                  options.first.ingilizce,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 22,
                  ),
                ),
                onPressed: () {
                  if (checkAnswer(options.first)) {
                    setState(() {
                      buttonColor1 = Colors.green;
                      Future.delayed(
                        const Duration(seconds: 1),
                        () {
                          setState(() {
                            buttonColor1 = Colors.blue;
                            if (seenQuestions.length == 10) {
                              if (Kategoriler.kategoriler[widget.secilenKategoriIndex].oyunlar[1]!=true) {
                                    Kategoriler.kategoriler[widget.secilenKategoriIndex].oyunlar[1]=true;
                                  DosyaIslem.writeToFile;
                                  }
                                  
                              
                              showAlertDialog(context);
                            }
                            nextQuestion();
                          });
                        },
                      );
                    });
                  } else {
                    setState(() {
                      buttonColor1 = Colors.red;
                      Future.delayed(
                        const Duration(seconds: 1),
                        () {
                          setState(() {
                            buttonColor1 = Colors.blue;
                          });
                        },
                      );
                    });
                  }
                },
              ),
            ),
            const SizedBox(height: 10),
// 2. SEÇENEK BUTONU
            SizedBox(
              width: 200,
              height: 50,
              child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(buttonColor2),
                  ),
                  child: Text(
                    options.last.ingilizce,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 22,
                    ),
                  ),
                  onPressed: () {
                    if (checkAnswer(options.last)) {
                      setState(() {
                        buttonColor2 = Colors.green;
                        Future.delayed(
                          const Duration(seconds: 1),
                          () {
                            setState(() {
                              buttonColor2 = Colors.blue;
                              if (seenQuestions.length == 10) {
                                if (Kategoriler.kategoriler[widget.secilenKategoriIndex].oyunlar[1]!=true) {
                                    Kategoriler.kategoriler[widget.secilenKategoriIndex].oyunlar[1]=true;
                                  DosyaIslem.writeToFile;
                                  }
                                showAlertDialog(context);
                              }
                              nextQuestion();
                            });
                          },
                        );
                      });
                    } else {
                      setState(() {
                        buttonColor2 = Colors.red;
                        Future.delayed(
                          const Duration(seconds: 1),
                          () {
                            setState(() {
                              buttonColor2 = Colors.blue;
                            });
                          },
                        );
                      });
                    }
                  }),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}

class Question {
  Kelime? word;
  List<Kelime> options;

  Question({required this.word, required this.options});
}
