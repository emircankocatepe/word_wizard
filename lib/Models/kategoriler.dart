import 'package:word_wizard/dosyaIslem.dart';
import 'package:word_wizard/Models/kategori.dart';
import 'package:word_wizard/Models/kelime.dart';

class Kategoriler {
  static List<Kategori> kategoriler = [
    Kategori("HAYVANLAR", 0.0, 0, 10),
    Kategori("MESLEKLER", 0.0, 0, 10),
    Kategori("ARACLAR", 0.0, 0, 10),
    Kategori("SPORLAR", 0.0, 0, 10),
    Kategori("MEYVE", 0.0, 0, 10),
    Kategori("ESYA", 0.0, 0, 10),
  ];
  /*List<Kelime> kelimeListesi = [
    Kelime("kopek","dog",true),
  ];*/

  static Future<void> kategoriDoldur() async {
    List<String> dosyadanOkunan = await DosyaIslem.readFromFile();
    var j = 0;
    for (var kategori in kategoriler) {
      kategori.ogrenilenKelime = 0;
      for (var i = 0; i < 10; i++) {
        var liste = dosyadanOkunan[j++].split('-');
        if (i == 0) {
          List<String> boolStrings =
              liste[3].replaceAll('[', '').replaceAll(']', '').split(',');

          List<bool> boolList =
              boolStrings.map((e) => e.trim() == 'true').toList();
          print('Category: ${kategori.isim}, boolList: $boolList');
          kategori.oyunlar = boolList;
        }
        var yeniKelime = Kelime(liste[0], liste[1], bool.parse(liste[2]));
        if (bool.parse(liste[2])) kategori.ogrenilenKelime++;
        kategori.kelimeListesi.add(yeniKelime);
        print(yeniKelime.turkce);
      }
    }
  }

  static progressAzalt() {
    for (var kategori in kategoriler) {
      /*  if(kategori.progress>=0.2)
        kategori.progress -= 0.2;
    }*/
      kategori.kelimeListesi[0].ogrenildi = true;
      print(
          "${kategori.isim} ${kategori.ogrenilenKelime}/${kategori.toplamKelime}\n${kategori.kelimeListesi[0].turkce}\n${kategori.oyunlar}\n");
    }
  }

  static List<Kelime> ogrenilenDondur() {
    List<Kelime> ogrenilenler = [];
    for (var kategori in kategoriler) {
      for (var kelime in kategori.kelimeListesi) {
        if (kelime.ogrenildi) {
          ogrenilenler.add(kelime);
        }
      }
    }
    return ogrenilenler;
  }
}
