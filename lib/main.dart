import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:word_wizard/Screens/ayarlar.dart';
import 'package:word_wizard/Screens/gozdengecir.dart';
import 'package:word_wizard/Screens/kategori_widget.dart';
import 'package:word_wizard/theme_provider.dart';

void main() {
  runApp(   
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: MainApp()
    ),
  );
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

List<Widget> sayfalar = [KategoriWidget(),GozdenGecir(),AppTheme()];
int secilenIndex = 0;

class _MainAppState extends State<MainApp> {

  Widget build(BuildContext context) {
    final provider=Provider.of<ThemeProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: provider.theme==Brightness.light?ThemeData(
        scaffoldBackgroundColor: const  Color.fromRGBO(250, 238, 209, 1),
        appBarTheme:AppBarTheme(
          titleTextStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.black,
          ),
          color: const Color.fromRGBO(96, 114, 116, 1),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: Colors.black,
          backgroundColor: Color.fromRGBO(113, 160, 164, 1),
        ),
      ):ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(
              "Word Wizard",
              style: TextStyle(
                fontWeight:FontWeight.bold),
            )
          )
        ),
        body: sayfalar[secilenIndex],
        bottomNavigationBar: BottomNavigationBar(items: [
          BottomNavigationBarItem(icon: Icon(Icons.home),label: 'Ana Sayfa'),
          BottomNavigationBarItem(icon: Icon(Icons.rocket),label: 'Gözden Geçir'),
          BottomNavigationBarItem(icon: Icon(Icons.settings),label: 'Ayarlar'),
          ],
          currentIndex: secilenIndex,
          onTap: (value) => setState(() {
            secilenIndex=value;
          }),
        ),
        )
    );
  }
}