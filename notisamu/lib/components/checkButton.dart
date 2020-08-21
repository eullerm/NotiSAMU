import 'package:flutter/material.dart';

class CheckButton extends StatelessWidget {
  CheckButton({this.function});

  final Function function;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 50,
        child: MaterialButton(
          onPressed: function,
          child: Icon(
            Icons.check,
          ),
          padding: EdgeInsets.all(5.0),
          shape: CircleBorder(),
          color: Colors.green,
        ));
  }
}
