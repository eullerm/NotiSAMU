import 'package:flutter/material.dart';
import 'package:noti_samu/screens/Registro/registroPacienteOpcional.dart';

class Relator extends StatefulWidget {
  @override
  _RelatorState createState() => _RelatorState();
}

class _RelatorState extends State<Relator> {
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
      debugPrint(_radioValue); //Debug the choice in console
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text("Registro de dados opcionais"),
      ),
      body: _body(context),
      floatingActionButton: _buttonNext(),
    );
  }

  _body(context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: 20),
            _nomeDoNotificante(),
            SizedBox(height: 40),
            _radioButtonProfissao(),
          ],
        ),
      ),
    );
  }

  _nomeDoNotificante() {
    return TextFormField(
      style: TextStyle(
        color: Colors.black,
        fontSize: 18,
      ),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32),
        ),
        hintText: "Nome do notificante(opcional)",
      ),
    );
  }

  _radioButtonProfissao() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Profissão:',
          textAlign: TextAlign.left,
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        _radioButton('Enfermagem'),
        _radioButton('Técnico de enfermagem'),
        _radioButton('Médico'),
        _radioButton('Prefiro não mencionar'),
      ],
    );
  }

  _radioButton(String string) {
    return ListTile(
      title: Text(string),
      leading: Radio(
        value: string,
        groupValue: _radioValue,
        onChanged: radioButtonChanges,
      ),
    );
  }

  _buttonNext() {
    return FloatingActionButton.extended(
      onPressed: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => Paciente()));
      },
      label: Text('Continuar'),
      icon: Icon(Icons.skip_next),
      backgroundColor: Colors.redAccent,
    );
  }
}

//_horario() {
//  return TextFormField(
//    style: TextStyle(
//      color: Colors.black,
//      fontSize: 18,
//    ),
//    decoration: InputDecoration(
//      border: OutlineInputBorder(
//        borderRadius: BorderRadius.circular(32),
//      ),
//      hintText: "Nome do notificante(opcional).",
//    ),
//  );
//}
