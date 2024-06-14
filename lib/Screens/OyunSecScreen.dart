import 'package:flutter/material.dart';
import 'package:word_wizard/Screens/KelimeBilgisiScreen.dart';
import 'package:word_wizard/Screens/KelimeOgren.dart';
import 'package:word_wizard/Screens/KelimeSecScreen.dart';
import 'package:word_wizard/Screens/my_home_page.dart';
import 'package:word_wizard/Screens/kelimeYaz.dart';
import 'package:word_wizard/oyun_widget.dart';

class OyunSecScreen extends StatelessWidget {
  int secilenKategoriIndex = 0;
  OyunSecScreen({super.key, required this.secilenKategoriIndex});

// KULLANICI ARAYÜZÜ
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Oyun Seçimi',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  oyun_widget(
                    title: "Kelime Bilgisi",
                    route: KelimeBilgisi(
                      secilenKategoriIndex: secilenKategoriIndex,
                    ),
                  ),
                  oyun_widget(
                    title: "Kelime Seç",
                    route: KelimeSecScreen(
                        secilenKategoriIndex: secilenKategoriIndex),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  oyun_widget(
                    title: "Kelime Eşleştir",
                    route: MyHomePage(secilenKategoriIndex),
                  ),
                  oyun_widget(
                    title: "Kelime Yaz",
                    route: Project1(KategoriIndex: secilenKategoriIndex),
                  ),
                ],
              ),
              oyun_widget(
                title: "Resim Seç",
                route: InputPage(secilenKategoriIndex),
              )
            ],
          ),
        ));
  }
}
