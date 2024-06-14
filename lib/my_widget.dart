import 'package:flutter/material.dart';
import 'package:word_wizard/list_item.dart';

typedef void SelectedText(String text);

class MyWidget extends StatefulWidget {
  final SelectedText selectedTextCallBack;
  final Function(int) selectedTextIndexCallBack;
  final List<ListItem> liste;
  final Function(bool) selectedTextEnglishCallBack;

  const MyWidget(this.liste, this.selectedTextCallBack,
      this.selectedTextIndexCallBack, this.selectedTextEnglishCallBack,
      {super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  int? selectedIndex;
  @override
  Widget build(BuildContext context) {
    return Wrap(
      direction: Axis.vertical,
      children: List.generate(10, (index) {
        return InkWell(
          hoverColor: Colors.blue,
          onTap: widget.liste[index].enable
              ? () {
                  setState(() {
                    if (selectedIndex != null) {
                      widget.liste[selectedIndex!].color = Colors.white;
                    }
                    selectedIndex = index;
                    if (selectedIndex != null) {
                      widget.liste[selectedIndex!].color = Colors.blue;
                    }
                  });
                  widget.selectedTextEnglishCallBack(
                      widget.liste[index].isEnglish);
                  widget.selectedTextIndexCallBack(index);
                  widget.selectedTextCallBack(widget.liste[index].text);
                }
              : null,
          borderRadius: const BorderRadius.all(
            Radius.circular(18),
          ),
          child: AnimatedOpacity(
            duration: const Duration(seconds: 2),
            opacity: widget.liste[index].visible ? 1.0 : 0.0,
            child: Card(
              color: widget.liste[index].color,
              child: Container(
                width: 150,
                margin: const EdgeInsets.all(8.0),
                child: Text(
                  
                  widget.liste[index].text,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.black),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
