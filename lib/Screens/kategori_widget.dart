import 'package:flutter/material.dart';
import 'package:word_wizard/Models/kategoriler.dart';
import 'package:word_wizard/Screens/KelimeBilgisiScreen.dart';
import 'package:word_wizard/Screens/OyunSecScreen.dart';
import 'package:word_wizard/dosyaIslem.dart';

class KategoriWidget extends StatefulWidget {
  @override
  State<KategoriWidget> createState() => _KategoriWidgetState();
  const KategoriWidget({super.key});
}

class _KategoriWidgetState extends State<KategoriWidget> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Kategoriler.kategoriDoldur();
      if (mounted) {
        setState(() {});
      }
    });
  }

  void kategoriGuncelle() {
    setState(() {
      for(var kategori in Kategoriler.kategoriler){
        kategori.ogrenilenKelime = kategori.ogrSayisiDondur();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
        /*   ElevatedButton(child: Text("Write to file"),onPressed: (){
            DosyaIslem.deleteFile();
            }
            ),
            ElevatedButton(child: Text("Progress Azalt"), onPressed: (){
              Kategoriler.progressAzalt();
            },),*/
          Expanded(
            child: Center(
              child: ListView.builder(
                itemCount: Kategoriler.kategoriler.length,
                itemBuilder: (context, index) => Container(
                  margin:
                      EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll( Color.fromARGB(255, 197, 171, 152),),),
                    
                    onPressed: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => OyunSecScreen(
                                  secilenKategoriIndex: index,
                                )),
                      );
                      kategoriGuncelle();
                    },
                    child: ListTile(
                      // tileColor: Colors.brown,
                      title: Container(
                        padding: EdgeInsets.all(5),
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/images/${Kategoriler.kategoriler[index].isim.toLowerCase()}.png',
                              width: 50,
                              height: 50,
                            ),
                            SizedBox(
                              width: 30,
                            ),
                            Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    Kategoriler.kategoriler[index].isim,
                                    style:
                                        const TextStyle(fontWeight: FontWeight.bold,color:   Colors.black,),
                                  ),
                                  Card(
                                    color: Color.fromRGBO(250, 238, 209, 1),
                                      child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Text(
                                        "${Kategoriler.kategoriler[index].ogrenilenKelime}/${Kategoriler.kategoriler[index].toplamKelime}",
                                        style:  const TextStyle(color: Colors.black),),
                                        Text('Kelimeler',
                                        style:  const TextStyle(color: Colors.black),)
                                      ],
                                    ),
                                  )),
                                  Container(
                                    height: 10,
                                    width: 199,
                                    child: LinearProgressIndicator(
                                      borderRadius: BorderRadius.circular(10),
                                      value: Kategoriler.kategoriler[index]
                                          .progressHesapla(),
                                      backgroundColor: const Color.fromRGBO(250, 238, 209, 1),
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          Colors.green),
                                    ),
                                  ),
                                ]),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
