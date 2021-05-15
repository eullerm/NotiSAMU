import 'package:flutter/material.dart';

class TextPreview extends StatelessWidget {
  TextPreview(this.string,
      {this.string2, this.list, this.isList = false, this.function});

  final String string;
  final String string2;
  final List<String> list;
  final bool isList;
  final Function function;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                string,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              Icon(Icons.edit_outlined),
            ],
          ),
          isList
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
    return Row(
      children: <Widget>[
        Padding(padding: EdgeInsets.only(left: 8)),
        SizedBox(
          height: 8,
        ),
        Text(
          string,
          style: TextStyle(
            fontSize: 18,
          ),
          textAlign: TextAlign.start,
        ),
        SizedBox(
          height: 42,
        ),
      ],
    );
  }
}
