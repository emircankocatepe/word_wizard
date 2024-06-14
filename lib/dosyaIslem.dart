import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:word_wizard/Models/kategori.dart';
import 'package:path_provider/path_provider.dart';
import 'package:word_wizard/Models/kategoriler.dart';

class DosyaIslem {
  static Future<List<String>> readFromFile() async {
    final directory =
        Directory('${(await getApplicationDocumentsDirectory()).path}');

    if (await directory.exists()) {
      // Read from the local documents directory
      final file = File('${directory.path}/data.txt');
      if (await file.exists()) {
        String content = await file.readAsString();
        List<String> lines = LineSplitter.split(content).toList();
        return lines;
      }
    }

    // If the local directory or file does not exist, read from assets
    String content = await rootBundle.loadString('assets/kelimeler.txt');
    List<String> lines = LineSplitter.split(content).toList();
    return lines;
  }

  static Future<void> writeToFile() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/data.txt');
      file.writeAsStringSync("");
      List<Kategori> liste = Kategoriler.kategoriler;
      String content;
      for (var kategori in liste) {
        for (var i = 0; i < 10; i++) {
          content =
              "${kategori.kelimeListesi[i].turkce}-${kategori.kelimeListesi[i].ingilizce}-${kategori.kelimeListesi[i].ogrenildi}";
          if (i == 0) {
            content += "-${kategori.oyunlar}";
          }
          file.writeAsStringSync('$content\n', mode: FileMode.append);
        }
      }
    } catch (e) {
      print('Error writing to file: $e');
    }
  }

  static Future<void> deleteFile() async {
    final directory =
        Directory('${(await getApplicationDocumentsDirectory()).path}');
    final file = File('${directory.path}/data.txt');

    // Check if the file exists before attempting to delete
    if (file.existsSync()) {
      try {
        file.deleteSync();
        print('File deleted successfully.');
      } catch (e) {
        print('Error deleting file: $e');
      }
    } else {
      print('File not found. Unable to delete.');
    }
  }
}
