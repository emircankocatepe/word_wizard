import 'package:flutter/material.dart';

class oyun_widget extends StatelessWidget {
  oyun_widget({
    super.key,
    required this.title,
    required this.route,
  });

  String title;
  Widget route;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(23)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 3,
              blurRadius: 2,
              offset: Offset(0, 0),
            ),
          ]),
      width: 160.0,
      height: 160.0,
      child: ElevatedButton(
        clipBehavior: Clip.none,
        style: ButtonStyle(
          //renk buradan değişecek
          backgroundColor: MaterialStatePropertyAll(
            Color.fromARGB(255, 197, 171, 152),
          ),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => route),
          );
        },
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30.0,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
