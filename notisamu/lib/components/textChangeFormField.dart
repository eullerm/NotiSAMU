import 'package:flutter/material.dart';

class TextChangeFormField extends StatelessWidget {
  TextChangeFormField(
    this.field,
    this.controller, {
    this.number = false,
    this.widget,
    this.functionToCancel,
    this.maxLength = 50,
    this.maxLines = 1,
    this.minLines = 1,
  });

  final String field;
  final TextEditingController controller;
  final bool number;
  final Widget widget;
  final Function functionToCancel;
  final int maxLength;
  final int maxLines;
  final int minLines;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          field,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: TextFormField(
                controller: controller,
                maxLength: maxLength,
                maxLines: maxLines,
                minLines: minLines,
                keyboardType:
                    number ? TextInputType.number : TextInputType.name,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32),
                  ),
                ),
              ),
            ),
            widget,
            _cancelButton(),
          ],
        ),
      ],
    );
  }

  _cancelButton() {
    return SizedBox(
        width: 50,
        child: MaterialButton(
          onPressed: functionToCancel,
          child: Icon(
            Icons.cancel,
          ),
          padding: EdgeInsets.all(5.0),
          shape: CircleBorder(),
          color: Color(0xFFF7444E),
        ));
  }
}
