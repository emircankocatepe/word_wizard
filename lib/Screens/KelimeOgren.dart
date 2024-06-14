import 'dart:math';
import 'package:flutter/material.dart';
import 'package:word_wizard/Models/kategoriler.dart';
import 'package:word_wizard/Models/kelime.dart';
import 'package:word_wizard/dosyaIslem.dart';

class InputPage extends StatefulWidget {
  int gelenIndex;
  InputPage(this.gelenIndex);
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  int index = 0;
  List<Kelime> dictinory = [];

  Color getcolor = Colors.white;
  Color getcolor2 = Colors.white;
  Color getcolor3 = Colors.white;
  Color getcolor4 = Colors.white;

  List<bool> dogruYanlis = [
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
  ];
  void showDialogs() {
    Widget okButton = TextButton(
      child: Text("Çıkış"),
      onPressed: () {
       // Navigator.pop(context);
      },
    );

    AlertDialog alert = AlertDialog(
      content: Text("Testin sonuna gelidiniz!"),
      actions: [
        okButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  int dogruIndex = 0;
  List<int> generetorNumber() {
    List<int> number = [];

    bool kontrol = true;
    if (!dogruYanlis.contains(true)) {
      kontrol = false;
    }
    while (kontrol) {
      int randomNumberTrue = Random().nextInt(10);
      if (dogruYanlis[randomNumberTrue]) {
        dogruYanlis[randomNumberTrue] = false;
        number.add(randomNumberTrue);
        kontrol = false;
      }
    }

    while (number.length < 4) {
      int randomNumber = Random().nextInt(10);
      if (!number.contains(randomNumber)) {
        number.add(randomNumber);
      }
    }
    return number;
  }

  int count = 0;
  @override
  void initState() {
    index = widget.gelenIndex;
    dictinory = Kategoriler.kategoriler[index].kelimeListesi;
    resault = generetorNumber();
    generetorIndex();

    super.initState();
  }

  List<int> resault = [];
  onTapFunc(int listNumber, Function(Color) updateColor) {
    setState(() {
      Color newColor;

      if (dictinory[resault[0]].turkce == dictinory[listNumber].turkce) {
        newColor = Colors.green;

        Future.delayed(Duration(seconds: 1), () {
          setState(() {
            count++;
            newColor = Colors.white;
            updateColor(newColor);
            resault = generetorNumber();
            generetorIndex();
          });
        });
        updateColor(newColor);
      } else {
        newColor = Colors.red;
        updateColor(newColor);
        Future.delayed(Duration(seconds: 1), () {
          setState(() {
            newColor = Colors.white;
            updateColor(newColor);
          });
        });
      }
    });
  }

  List<int> indexler = [];

  void generetorIndex() {
    indexler.clear();
    while (indexler.length < 4) {
      int number = Random().nextInt(4);
      if (indexler.contains(number) == false) {
        indexler.add(number);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Learning Words',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                  flex: 10,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                          flex: 40,
                          child: MyContainer(
                            
                            onpress: () =>
                                onTapFunc(resault[indexler[0]], (newColor) {
                              setState(() {
                                getcolor = newColor;
                                if (count == dictinory.length) {
                                 // showDialogs();
                                 if(Kategoriler.kategoriler[widget.gelenIndex].oyunlar[4]!=true)
                                 {Kategoriler.kategoriler[widget.gelenIndex].oyunlar[4]=true;}

                                 DosyaIslem.writeToFile();
                                 Navigator.pop(context);
                                }
                              });
                            }),
                            renk: getcolor,
                            child: Text(
                              '${dictinory[resault[indexler[0]]].ingilizce}',
                              style: const TextStyle(color: Colors.black,fontSize: 24),
                            ),
                          )),
                      Expanded(flex: 1, child: SizedBox()),
                      Expanded(
                          flex: 40,
                          child: MyContainer(
                            onpress: () =>
                                onTapFunc(resault[indexler[1]], (newColor) {
                              setState(() {
                                getcolor2 = newColor;
                                if (count == dictinory.length) {
                                  //showDialogs();
                                  if (Kategoriler.kategoriler[widget.gelenIndex].oyunlar[4]!=true) {
                                    Kategoriler.kategoriler[widget.gelenIndex].oyunlar[4]=true;
                                  }
                                  
                                  DosyaIslem.writeToFile();
                                  Navigator.pop(context);
                                }
                              });
                            }),
                            renk: getcolor2,
                            child: Text(
                              style: const TextStyle(color: Colors.black,fontSize: 24),
                              '${dictinory[resault[indexler[1]]].ingilizce}',
                            ),
                          )),
                    ],
                  )),
              Expanded(
                flex: 1,
                child: Center(
                  child: Text(
                    '${dictinory[resault[0]].turkce}',
                    style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Expanded(
                  flex: 10,
                  child: Row(
                    children: [
                      Expanded(
                          flex: 40,
                          child: MyContainer(
                            onpress: () =>
                                onTapFunc(resault[indexler[2]], (newColor) {
                              setState(() {
                                getcolor3 = newColor;
                                if (count == dictinory.length) {
                                  //showDialogs();
                                  if (Kategoriler.kategoriler[widget.gelenIndex].oyunlar[4]!=true) {
                                    Kategoriler.kategoriler[widget.gelenIndex].oyunlar[4]=true;
                                  }
                                  
                                  DosyaIslem.writeToFile();
                                  Navigator.pop(context);
                                }
                              });
                            }),
                            renk: getcolor3,
                            child: Text(
                              style: const TextStyle(color: Colors.black,fontSize: 24),
                              '${dictinory[resault[indexler[2]]].ingilizce}',
                            ),
                          )),
                      Expanded(flex: 1, child: SizedBox()),
                      Expanded(
                          flex: 40,
                          child: MyContainer(
                            onpress: () =>
                                onTapFunc(resault[indexler[3]], (newColor) {
                              setState(() {
                                getcolor4 = newColor;
                                if (count == dictinory.length) {
                                  //showDialogs();
                                  if (Kategoriler.kategoriler[widget.gelenIndex].oyunlar[4]!=true) {
                                    Kategoriler.kategoriler[widget.gelenIndex].oyunlar[4]=true;
                                  }
                                  DosyaIslem.writeToFile();
                                  Navigator.pop(context);
                                }
                              });
                            }),
                            renk: getcolor4,
                            child: Text(
                              
                              style: 
                              const TextStyle(
                                color: Colors.black,fontSize: 24),
                              
                              '${dictinory[resault[indexler[3]]].ingilizce}',
                            ),
                          )),
                    ],
                  )),
            ],
          )),
    );
  }
}

class MyContainer extends StatelessWidget {
  final Widget? child;
  final Color renk;
  final Function()? onpress;
  MyContainer({this.renk = Colors.white, this.child, this.onpress});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onpress,
      child: Container(
        alignment: Alignment.center,
        child: child,
        margin: EdgeInsets.all(30),
        decoration:
            BoxDecoration(borderRadius: BorderRadius.circular(10), color: renk),
      ),
    );
  }
}
