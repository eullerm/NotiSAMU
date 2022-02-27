import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
    this.error = false,
  });

  final String field;
  final TextEditingController controller;
  final bool number;
  final Widget widget;
  final Function functionToCancel;
  final int maxLength;
  final int maxLines;
  final int minLines;
  bool error;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: [
            Text(
              field,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: (error != null && error) ? Color(0xFFF7444E) : Colors.black,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          children: <Widget>[
            number ? _keyboardNumber() : _keyboardName(),
            widget,
            _cancelButton(),
          ],
        ),
      ],
    );
  }

  _keyboardNumber() {
    return Expanded(
      child: TextFormField(
        controller: controller,
        maxLength: maxLength,
        maxLines: maxLines,
        minLines: minLines,
        keyboardType: TextInputType.number,
        inputFormatters: [
          new FilteringTextInputFormatter.allow(RegExp("[0-9]")),
        ],
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
    );
  }

  _keyboardName() {
    return Expanded(
      child: TextFormField(
        controller: controller,
        maxLength: maxLength,
        maxLines: maxLines,
        minLines: minLines,
        keyboardType: TextInputType.name,
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
