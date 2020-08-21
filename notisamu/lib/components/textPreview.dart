import 'package:flutter/material.dart';

class TextPreview extends StatelessWidget {
  TextPreview(this.string,
      {this.string2, this.list, this.itsList = false, this.function});

  final String string;
  final String string2;
  final List<String> list;
  final bool itsList;
  final Function function;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Column(
        children: <Widget>[
          Text(
            string,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
          itsList
              ? Column(
                  children: list
                      .map<Widget>((String i) => _secundaryText(i))
                      .toList())
              : _secundaryText(string2),
        ],
      ),
    );
  }

  _secundaryText(String string) {
    return Column(
      children: <Widget>[
        Text(
          string,
          style: TextStyle(
            fontSize: 20,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
