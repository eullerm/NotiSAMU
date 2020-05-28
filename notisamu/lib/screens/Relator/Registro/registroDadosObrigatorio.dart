import 'package:flutter/material.dart';
import 'package:noti_samu/screens/Relator/Registro/categoriaIncidente.dart';
import 'package:noti_samu/components/notificacao.dart';

class Ocorrencia extends StatefulWidget {
  Notificacao notificacao;
  Ocorrencia(this.notificacao);

  @override
  _OcorrenciaState createState() => _OcorrenciaState();
}

class _OcorrenciaState extends State<Ocorrencia> {
  final numeroDaOcorrencia = TextEditingController();
  final localDaOcorrencia = TextEditingController();

  DateTime selectedDate = DateTime.now();
  String _radioValue;

  @override
  void initState() {
    setState(() {
      _radioValue = null;
    });
    super.initState();
  }

  void radioButtonChanges(String value) {
    setState(() {
      _radioValue = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text("Registro de dados da ocorrência"),
      ),
      body: _body(context),
      floatingActionButton: _buttonNext(),
    );
  }

  _body(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(16),
      children: <Widget>[
        SizedBox(
          height: 20,
        ),
        _numeroOcorrencia(),
        SizedBox(
          height: 40,
        ),
        _localOcorrencia(),
        SizedBox(
          height: 40,
        ),
        _dataOcorrencia(selectedDate),
        SizedBox(
          height: 40,
        ),
        _periodoOcorrencia(),
      ],
    );
  }

  Future<DateTime> _selectDate(BuildContext context, int tempo) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: new DateTime.now().subtract(Duration(days: tempo)),
      lastDate: new DateTime.now().add(Duration(days: 367)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            primaryColor: Colors.red,
            accentColor: Colors.red,
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.accent),
          ),
          child: child,
        );
      },
    );
    if (picked != null &&
        picked != selectedDate &&
        picked.compareTo(DateTime.now()) <= 0)
      setState(
        () {
          selectedDate = picked;
          print(picked);
          return picked;
        },
      );
  }

  _dataOcorrencia(selectedDate) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          "Data da ocorrência:",
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        GestureDetector(
          onTap: () => _selectDate(context, 7),
          child: Text(
            "${selectedDate.day.toString()}/${selectedDate.month.toString()}/${selectedDate.year.toString()}",
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 18,
            ),
          ),
        ),
        IconButton(
          icon: Icon(Icons.date_range),
          onPressed: () => _selectDate(context, 7),
        ),
      ],
    );
  }

  _periodoOcorrencia() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Periodo da ocorrência:',
          textAlign: TextAlign.left,
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        _radioButton('Manhã'),
        _radioButton('Tarde'),
        _radioButton('Noite'),
      ],
    );
  }

  _localOcorrencia() {
    return TextFormField(
      controller: localDaOcorrencia,
      style: TextStyle(
        color: Colors.black,
        fontSize: 18,
      ),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32),
        ),
        hintText: "Local da ocorrência",
      ),
    );
  }

  _numeroOcorrencia() {
    return TextFormField(
      controller: numeroDaOcorrencia,
      keyboardType: TextInputType.number,
      style: TextStyle(
        color: Colors.black,
        fontSize: 18,
      ),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32),
        ),
        hintText: "Número da ocorrência",
      ),
    );
  }

  _radioButton(String string) {
    return RadioListTile(
      title: Text(string),
      value: string,
      groupValue: _radioValue,
      onChanged: radioButtonChanges,
    );
  }

  _buttonNext() {
    return FloatingActionButton.extended(
      onPressed: () {
        this.widget.notificacao.setOccurrenceNumber(numeroDaOcorrencia.text);
        this.widget.notificacao.setLocal(localDaOcorrencia.text);
        this.widget.notificacao.setDate(selectedDate);
        this.widget.notificacao.setPeriod(_radioValue);

        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => Categoria(this.widget.notificacao)));
      },
      label: Text('Continuar'),
      icon: Icon(Icons.skip_next),
      backgroundColor: Colors.redAccent,
    );
  }
}
