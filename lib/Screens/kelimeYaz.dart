import 'package:flutter/material.dart';
import 'package:word_wizard/Models/kategoriler.dart';
import 'package:word_wizard/Models/kelime.dart';
import 'package:word_wizard/main.dart';

class Project1 extends StatefulWidget {
  Project1({super.key, required this.KategoriIndex});
  int KategoriIndex = 0;
  @override
  State<Project1> createState() => _Project1State();
}

bool isFirst = true;

String imagePath = "";

bool isButtonActive = true;

double progress = 0.1;

class _Project1State extends State<Project1> {
  Widget _stepIndicator() {
    return (LinearProgressIndicator(
      borderRadius: BorderRadius.circular(12.0),
      backgroundColor: Colors.grey[350],
      valueColor: const AlwaysStoppedAnimation(Colors.green),
      minHeight: 10,
      value: progress,
      
    ));
  }

void shrinkIndicator() {
  progress += 0.1;
}
void shrinkIndicatortwo(){
  progress -= 0.1;
}

  double initial = 0.1;

  final _textController = TextEditingController();

  String userInput = '';

  int gezenIndex = 0;

  void goForward() {
    gezenIndex++;
  }

  void goBack() {
    gezenIndex--;
  }

  String returnTurkish() {
    List<Kelime> otherWords =
        Kategoriler.kategoriler[widget.KategoriIndex].kelimeListesi;
    return otherWords[gezenIndex].turkce;
  }

  String returnEnglish() {
    List<Kelime> otherWords =
        Kategoriler.kategoriler[widget.KategoriIndex].kelimeListesi;
    return otherWords[gezenIndex].ingilizce;
  }

// void changeIt(){
// if (isFirst) {
//       fillList();
//       isFirst = false;
//     }
//     fillList();
// }

  Color? colour = Colors.white.withOpacity(0);

  List<Icon> scoreKeeper = [];

  int correctAnswers = 0, wrongAnswers = 0;

  int textFieldActive = 0;

  Color forwardArrayColor = Colors.black;

  Color backArrayColor = Colors.white.withOpacity(0);

  Color ColourBorder = Colors.yellow.shade600;

  void isVisible() {
    if (gezenIndex == 0) {
      forwardArrayColor = Colors.black;
    } else if (gezenIndex == 9) 
    {
    if(Kategoriler.kategoriler[widget.KategoriIndex].oyunlar[3]!=true){
      Kategoriler.kategoriler[widget.KategoriIndex].oyunlar[3]=true;
    }
      Navigator.pop(context);
    } else {
      backArrayColor = Colors.white.withOpacity(1);
      backArrayColor = Colors.black;
      forwardArrayColor = Colors.black;
    }
  }

  void checkIt() {
    setState(() {
      String correct = returnEnglish();
      if (userInput != correct) {
        
        print('renk degisti');
        scoreKeeper.add(
          const Icon(Icons.close, color: Color.fromARGB(255, 255, 255, 255)),
        );

        colour = const Color.fromARGB(255, 198, 56, 45).withRed(170);
        wrongAnswers++;
        ColourBorder = Colors.red;

        Kategoriler.kategoriler[widget.KategoriIndex].kelimeListesi[gezenIndex]
            .correction = 2;
        shrinkIndicator();
      } else {
        scoreKeeper.add(
          const Icon(Icons.check, color: Color.fromARGB(255, 255, 255, 255)),
        );

        colour = Color.fromARGB(255, 47, 106, 49).withGreen(220);
        correctAnswers++;
        ColourBorder = Colors.green;
        isButtonActive = true;
        Kategoriler.kategoriler[widget.KategoriIndex].kelimeListesi[gezenIndex]
            .correction = 1;
        shrinkIndicator();
      }
    });
  }

  void lightColor() {
    if (Kategoriler.kategoriler[widget.KategoriIndex].kelimeListesi[gezenIndex]
            .correction == 1) {
      colour = const Color.fromARGB(255, 47, 106, 49).withGreen(220);
      isButtonActive = false;
      textFieldActive = 1;
      ColourBorder = Color.fromARGB(255, 40, 185, 45);
    } else if (Kategoriler.kategoriler[widget.KategoriIndex]
            .kelimeListesi[gezenIndex].correction == 2) {
      colour = const Color.fromARGB(255, 198, 56, 45).withRed(170);
      isButtonActive = false;
      textFieldActive = 1;
      ColourBorder = Colors.red;
    } else if (Kategoriler.kategoriler[widget.KategoriIndex]
            .kelimeListesi[gezenIndex].correction == 0) {
      colour = colour;
      isButtonActive = true;
      ColourBorder = Colors.yellow.shade600;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              setState(() {
                Kategoriler.kategoriler[secilenIndex].oyunlar[3];
                Navigator.pop(context);
              });
            },
            icon: const Icon(Icons.arrow_back_ios_new)),
        backgroundColor: const Color.fromRGBO(96, 114, 116, 1),
        title: const Text('Find The Word'),
        
      ),
      body: Container(
       
        padding: const EdgeInsets.symmetric(vertical: 50.0, horizontal: 15.0),
        constraints: const BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _stepIndicator(),
              Expanded(child: SizedBox()),
              Expanded(
                flex: 7,
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          print('going back');
                          goBack();
                          returnEnglish();
                          returnTurkish();
                          colour = Colors.white.withOpacity(0);
                          lightColor();
                          isVisible();
                          shrinkIndicatortwo();
                        });
                      },
                      icon: const Icon(Icons.arrow_back_ios_new),
                      color: backArrayColor,
                    ),
                    Expanded(
                      flex: 6,
                      child: Container(
                        width: 280.0,
                        height: 300.0,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.scaleDown,
                            image: AssetImage(imagePath =
                                "assets/images/${Kategoriler.kategoriler[widget.KategoriIndex].kelimeListesi[gezenIndex].ingilizce}.jpg"),
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(23.0)),
                          color: Colors.white,
                          border: Border.all(color: ColourBorder),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          print('going forward');
                          goForward();
                          returnEnglish();
                          returnTurkish();
                          colour = Colors.white.withOpacity(0);
                          lightColor();
                          isVisible();
                          shrinkIndicator();
                        });
                      },
                      icon: const Icon(Icons.arrow_forward_ios),
                      color: forwardArrayColor,
                    ),
                  ],
                ),
              ),
              const Expanded(
                flex: 1,
                child: SizedBox(
                  height: 1.0,
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  returnTurkish(),
                  style: const TextStyle(
                    fontSize: 32.0,
                    
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  returnEnglish(),
                  style: TextStyle(
                    color: colour,
                    fontSize: 32.0,
                  ),
                ),
              ),
              const Expanded(
                flex: 1,
                child: SizedBox(
                  height: 1.0,
                ),
              ),
              Expanded(
                flex: 2,
                child: TextField(
                  onTapOutside: (event) {
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
                  cursorWidth: 5.0,
                  controller: _textController,
                  cursorColor: const Color.fromRGBO(96, 114, 116, 1),
                  decoration: InputDecoration(
                    errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red)),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromARGB(255, 58, 70, 71),
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    labelText: 'Enter your answer',
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _textController.clear();
                        });
                      },
                      icon: const Icon(
                        Icons.close,
                        color: Color.fromARGB(255, 54, 64, 65),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10),
                child: MaterialButton(
                  disabledColor: const Color.fromRGBO(222, 208, 182, 1),
                  onPressed: isButtonActive
                      ? () {
                          setState(() {
                            userInput = _textController.text;
                            _textController.clear();
                            checkIt();
                            isButtonActive = false;
                          });
                        }
                      : null,
                  height: 40.0,
                  minWidth: 140.0,
                  color: const Color.fromRGBO(178, 165, 155, 1),
                  child: const Text(
                    'Check',
                    style: TextStyle(color: Colors.white, fontSize: 25.0),
                  ),
                ),
              ),
              const Expanded(
                flex: 1,
                child: SizedBox(
                  height: 2.0,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 50, right: 50),
                padding: const EdgeInsets.only(left: 10, right: 10),
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(142, 142, 142, 0.782),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                ),
                child: Row(
                  children: scoreKeeper,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
