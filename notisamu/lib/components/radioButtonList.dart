import 'package:flutter/material.dart';

class RadioButtonList extends StatefulWidget {
  RadioButtonList(this.list, {this.radioValue, this.radioButtonChanges});

  final List<String> list;
  String radioValue;
  final Function radioButtonChanges;

  @override
  _RadioButtonListState createState() => _RadioButtonListState();
}

class _RadioButtonListState extends State<RadioButtonList> {
  @override
  Widget build(BuildContext context) {
    return Column(
        children: this
            .widget
            .list
            .map<Widget>((String i) => _radioButton(i))
            .toList());
  }

  _radioButton(String string) {
    return RadioListTile(
      title: Text(string),
      value: string,
      groupValue: this.widget.radioValue,
      onChanged: this.widget.radioButtonChanges,
    );
  }
}
