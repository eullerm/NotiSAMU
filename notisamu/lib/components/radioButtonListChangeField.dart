import 'package:flutter/material.dart';

class RadioButtonListChangeField extends StatelessWidget {
  RadioButtonListChangeField(this.list,
      {this.radioValue, this.radioButtonChanges, @required this.widget});

  final List<String> list;
  final String radioValue;
  final Function radioButtonChanges;
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Column(
            children: list.map<Widget>((String i) => _radioButton(i)).toList(),
          ),
        ),
        widget,
      ],
    );
  }

  _radioButton(String string) {
    return RadioListTile(
      title: Text(string),
      value: string,
      groupValue: radioValue,
      onChanged: radioButtonChanges,
    );
  }
}
