import 'package:flutter/material.dart';
import 'package:noti_samu/components/notification.dart';
import 'package:noti_samu/screens/notifying/dataPreview/specificDataPreview.dart';

class MandatoryData extends StatefulWidget {
  Notify notification;
  MandatoryData(this.notification);

  @override
  _MandatoryDataState createState() => _MandatoryDataState();
}

class _MandatoryDataState extends State<MandatoryData> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text("Revisão de dados"),
      ),
      body: _body(context),
      floatingActionButton: _buttonNext(),
    );
  }

  _body(context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              _occurrenceNumber(),
              SizedBox(height: 20),
              _local(),
              SizedBox(height: 20),
              _date(),
              SizedBox(height: 20),
              _period(),
              SizedBox(height: 20),
              _category(),
            ],
          ),
        ),
      ),
    );
  }

  _buttonNext() {
    return FloatingActionButton.extended(
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => SpecificData(widget.notification)));
      },
      label: Text('Continuar'),
      icon: Icon(Icons.skip_next),
      backgroundColor: Colors.redAccent,
    );
  }

  _occurrenceNumber() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          "Número da ocorrência:",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
        GestureDetector(
          onTap: () => print("!"),
          child: Text(
            this.widget.notification.occurrenceNumber,
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ),
      ],
    );
  }

  _local() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          "Local da ocorrência:",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
        GestureDetector(
          onTap: () => print("!"),
          child: Text(
            this.widget.notification.local,
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ),
      ],
    );
  }

  _date() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          "Data da ocorrência:",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
        GestureDetector(
          onTap: () => print("!"),
          child: Text(
            """${this.widget.notification.occurrenceDate.day.toString()}/${this.widget.notification.occurrenceDate.month.toString()}/${this.widget.notification.occurrenceDate.year.toString()}""",
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ),
      ],
    );
  }

  _period() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          "Periodo da ocorrência:",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
        GestureDetector(
          onTap: () => print("!"),
          child: Text(
            this.widget.notification.period,
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ),
      ],
    );
  }

  _category() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          "Categorias:",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
        GestureDetector(
          onTap: () => print("!"),
          child: Column(
            children: this
                .widget
                .notification
                .category
                .map<Widget>((data) => _text(data))
                .toList(),
          ),
        ),
      ],
    );
  }

  _text(string) {
    return Text(
      string,
      textAlign: TextAlign.left,
      style: TextStyle(
        fontSize: 20,
      ),
    );
  }
}
