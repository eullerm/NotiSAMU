import 'package:flutter/material.dart';

class TextPreview extends StatelessWidget {
  TextPreview(this.string,
      {this.string2,
      this.list,
      this.isList = false,
      this.function,
      this.isScrollable = false,
      this.scroll});

  final String string;
  final String string2;
  final List<String> list;
  final bool isList;
  final Function function;
  final bool isScrollable;
  ScrollController scroll;

  @override
  Widget build(BuildContext context) {
    scroll = ScrollController();
    return GestureDetector(
      onTap: function,
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                this.string,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              Icon(Icons.edit_outlined),
            ],
          ),
          Divider(
            height: 0,
            color: Colors.black,
          ),
          isList
              ? _listText(this.list, this.isScrollable)
              : _secundaryText(this.string2),
        ],
      ),
    );
  }

  _secundaryText(String string) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 8,
        ),
        Padding(
          padding: EdgeInsets.only(left: 8),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  string,
                  style: TextStyle(
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 8,
        ),
      ],
    );
  }

  _listText(List<String> list, bool isScrollable) {
    return isScrollable
        ? Flexible(
            child: Scrollbar(
              thickness: 8.0,
              radius: Radius.circular(50.0),
              isAlwaysShown: isScrollable,
              child: ListView(
                shrinkWrap: true,
                children:
                    list.map<Widget>((String i) => _secundaryText(i)).toList(),
              ),
            ),
          )
        : Column(
            children:
                list.map<Widget>((String i) => _secundaryText(i)).toList(),
          );
  }
}
