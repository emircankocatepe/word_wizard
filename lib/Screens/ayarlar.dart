import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:word_wizard/theme_provider.dart';

// GECE / GUNDUZ AYARI 
// KENDI EKRANINIZ GORE DEGISKEN EKLEYIN
// DEGISKENLERI FONKSIYONDA GECE / GUNDUZ MODUNA GORE DEGISTIRIN
// LIGHT = TRUE ISE EKRAN GECE MODUNDA.

bool light = false; // EKRAN GUNDUZ AYARINDA
Color backgroundColorr = Color.fromRGBO(250, 238, 209, 1); // DEFAULT ARKAPLAN RENGI
Color backgroundColorrDay =Color.fromRGBO(250, 238, 209, 1);
Color backgroundColorrNight = Color.fromRGBO(20, 29, 38, 1);
Color dividerColor = Colors.black; //  DEFAULT DIVIDER COLOR 
Color dividerColorDay = Colors.black;
Color dividerColorNight = Colors.white;
String themeAppText = 'Enable Dark Mode';
IconData themeIconn = Icons.sunny; // DEFAULT ICON (GUNES)
IconData themeIconnDay = Icons.sunny;
IconData themeIconnNight = Icons.mode_night_sharp;
Color colorofIcon = Colors.black;// DEFAULT ICON RENK (GUNDUZ)
Color colorofIconDay = Colors.black; 
Color colorofIconNight = Colors.white;
Color trTextColor = Color.fromRGBO(62, 75, 76, 1); //  DEFAULT EKRANDAKI TURKCE ANLAM RENK (GUNDUZ)
Color trTextColorDay = Color.fromRGBO(62, 75, 76, 1); 
Color trTextColorNight = Color.fromRGBO(214, 214, 214, 1);
Color appBarBackground = const Color.fromRGBO(96, 114, 116,1); // DEFAULT APPBAR RENGI 
Color appBarBackgroundDay = const Color.fromRGBO(96, 114, 116,1);
Color appBarBackgroundNight = Color.fromRGBO(36,52,71,1);

void changeColor(){
  if (light == true)  // SU AN GECE
  {
  trTextColor = trTextColorNight;
  backgroundColorr = backgroundColorrNight;
  dividerColor = dividerColorNight;
  themeAppText = 'Enable Day Mode';
  themeIconn = themeIconnNight;
  colorofIcon = colorofIconNight;
  appBarBackground =  appBarBackgroundNight;
  }
  else if (light == false) // SU AN GUNDUZ
  {
  trTextColor = trTextColorDay;
  backgroundColorr = backgroundColorrDay;
  dividerColor = dividerColorDay;
  themeAppText = 'Enable Dark Mode';
  themeIconn =themeIconnDay;
  colorofIcon = colorofIconDay;
  appBarBackground = appBarBackgroundDay;
  }
}

class AppTheme extends StatefulWidget {
  

  @override
  State<AppTheme> createState() => _AppThemeState();
}



class _AppThemeState extends State<AppTheme> {
  
  @override
  Widget build(BuildContext  
  
  context) {
    final provider =Provider.of<ThemeProvider>(context);
    return  Scaffold(
      /*appBar: AppBar(title: Text('App Theme'),
      backgroundColor: appBarBackground,
      
        leading:  Builder(
          builder: (context) {
            return IconButton(onPressed: (){
              
               Navigator.pop(context,backgroundColorr);

            },
               icon: const Icon(Icons.arrow_back_ios_new));
          }
        ),),*/
      
      body: Container(
        decoration: BoxDecoration(color: backgroundColorr),
        child: Column(
         mainAxisAlignment: MainAxisAlignment.start,
          
          children: [
           
            Row(
             
              children: [
                 Padding(
                  padding: EdgeInsets.fromLTRB(20.0, 10.0,0,0),
                  child: changedIcon(themeIcon: themeIconn,colorIcon: colorofIcon,),
                  
                ),
                Expanded(
                  child: Padding(
                    padding:  EdgeInsets.fromLTRB(25.0, 10.0,0,0),
                    child: Text(themeAppText,
                    
                    style: TextStyle(color: dividerColor,
                                     fontWeight: FontWeight.bold,
                    fontSize: 20.0),),
                    
                  ),
                  
                ),
                
                Padding(
                  padding:  EdgeInsets.fromLTRB(0, 10.0,25.0,0),
                  child: Switch(
                      
                      value: light,
                      activeColor: Colors.blueAccent,
                      inactiveThumbColor: dividerColor,
                      inactiveTrackColor: Colors.white,
                      onChanged: (value) {
                        setState(() {
                             light = value;
                              changeColor();
                              if(light==true)
                              {
                                provider.setThemeMode(Brightness.dark);
                              }
                              else{
                                provider.setThemeMode(Brightness.light);
                              }                           
                          });
                        
                        
                      },
                    ),
                ),
                
              ],
            ),
            Divider(height: Checkbox.width,thickness: 2,color: dividerColor.withOpacity(0.2),),
          ],
        ),
      ),
    );

  }
}

class changedIcon extends StatelessWidget {
 
 changedIcon({required this.themeIcon,required this.colorIcon});
final Color colorIcon;
final IconData themeIcon;
  @override
  Widget build(BuildContext context) {
    return Icon(themeIcon,color: colorIcon,);
  }
}
