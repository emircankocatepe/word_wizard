import 'dart:async';

import 'package:flutter/material.dart';
import 'package:word_wizard/Models/kategoriler.dart';
import 'package:word_wizard/dosyaIslem.dart';
import 'package:word_wizard/index_text_bilgisi.dart';
import 'package:word_wizard/kelime_listesi.dart';
import 'package:word_wizard/my_widget.dart';

class MyHomePage extends StatefulWidget {
  final int secilenIndex;
  const MyHomePage(this.secilenIndex, {super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    KelimeListesi.mapOlustur(widget.secilenIndex);
    KelimeListesi.ingilizcelerOlustur();
    KelimeListesi.turkcelerOlustur();
    KelimeListesi.ingilizceBilgisiAta();
    super.initState();
  }

  double indicatorValue = 0.0;

  void indicatorArttir() {
    setState(() {
      indicatorValue = indicatorValue + 0.1;
      if (indicatorValue >= 0.99) {
        
        if(Kategoriler.kategoriler[widget.secilenIndex].oyunlar[2] != true){
Kategoriler.kategoriler[widget.secilenIndex].oyunlar[2] = true;
        DosyaIslem.writeToFile();
        }
        
        KelimeListesi.liste = {};
        Navigator.pop(context);
      }
    });
  }

  List<Veri> gelenVeriler = [];
  int i = 0;
  List<bool> gelenIngilizceDurumlari = [false, false];

  void ingilizceDurumuAta(bool ingilizceDurumu) {
    setState(() {
      i = i % 2;
      gelenIngilizceDurumlari[i] = ingilizceDurumu;
    });
  }

  List<int> indexler = [0, 0];

  void indexBul(int deger) {
    setState(() {
      i = i % 2;
      indexler[i] = deger;
    });
  }

  List<String> textler = ["", ""];

  List<Veri> templates = [];

  Veri veri = Veri(-1, "", false);

  void textAssign(String value) {
    setState(() {
      i = i % 2;
      textler[i] = value;
      gelenVeriler
          .add(Veri(indexler[i], textler[i], gelenIngilizceDurumlari[i]));

      if (gelenVeriler.length == 2) {
        veri = gelenVeriler.removeLast();
        templates.add(veri);
        templates.add(gelenVeriler.removeLast());

        if (templates[0].ingilizceBilgisi == true &&
            templates[1].ingilizceBilgisi == false) {
          karsilastir(templates[0].text, templates[0].index, templates[1].text,
              templates[1].index);
        } else if (templates[1].ingilizceBilgisi == true &&
            templates[0].ingilizceBilgisi == false) {
          karsilastir(templates[1].text, templates[1].index, templates[0].text,
              templates[0].index);
        } else {
          gelenVeriler.add(veri);
        }
        templates.removeLast();
        templates.removeLast();
      }
      i++;
    });
  }

  void karsilastir(
      String english, int englishIndex, String turkish, int turkishIndex) {
    String? correct = KelimeListesi.liste[english];

    if (turkish == correct) {
      KelimeListesi.ingilizcelerItems[englishIndex].color = Colors.green;
      KelimeListesi.ingilizcelerItems[englishIndex].visible = false;
      KelimeListesi.ingilizcelerItems[englishIndex].enable = false;

      KelimeListesi.turkcelerItems[turkishIndex].color = Colors.green;
      KelimeListesi.turkcelerItems[turkishIndex].visible = false;
      KelimeListesi.turkcelerItems[turkishIndex].enable = false;
      indicatorArttir();
    } else {
      KelimeListesi.ingilizcelerItems[englishIndex].color = Colors.red;
      KelimeListesi.turkcelerItems[turkishIndex].color = Colors.red;

      Timer(Duration(seconds: 2), () {
        setState(() {
          KelimeListesi.ingilizcelerItems[englishIndex].color = Colors.white;
          KelimeListesi.turkcelerItems[turkishIndex].color = Colors.white;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [],
            ),
            const Text(
              "Match the Word",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 25,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: LinearProgressIndicator(
                  borderRadius: BorderRadius.circular(12),
                  backgroundColor: Colors.grey,
                  valueColor: const AlwaysStoppedAnimation(Colors.blue),
                  value: indicatorValue,
                ),
              ),
            ),
            SizedBox(
              height: 100,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 20,
                ),
                MyWidget(KelimeListesi.ingilizcelerItems, textAssign, indexBul,
                    ingilizceDurumuAta),
                const Spacer(),
                MyWidget(KelimeListesi.turkcelerItems, textAssign, indexBul,
                    ingilizceDurumuAta),
                const SizedBox(
                  width: 20,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
