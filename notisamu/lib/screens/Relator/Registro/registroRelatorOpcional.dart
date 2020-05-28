import 'package:flutter/material.dart';
import 'package:noti_samu/screens/Relator/Registro/registroPacienteOpcional.dart';
import 'package:noti_samu/components/notificacao.dart';
import 'package:noti_samu/login.dart';

class Relator extends StatefulWidget {
  @override
  _RelatorState createState() => _RelatorState();
}

class _RelatorState extends State<Relator> {
  Notificacao notificacao = Notificacao();
  String _radioValue;
  final notificante = TextEditingController();

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
      debugPrint(_radioValue);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text("Registro de dados opcionais"),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => Login()));
          },
        ),
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
      controller: notificante,
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
        _radioButton('Enfermeira(o)'),
        _radioButton('Técnico de enfermagem'),
        _radioButton('Médica(o)'),
        _radioButton('Não informar'),
      ],
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
        if (notificante.text.isEmpty)
          this.notificacao.setNotifying("Nao informado");
        else
          this.notificacao.setNotifying(notificante.text);
        this.notificacao.setProfission(_radioValue);
        
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => Paciente(notificacao)));
      },
      label: Text('Continuar'),
      icon: Icon(Icons.skip_next),
      backgroundColor: Colors.redAccent,
    );
  }
}
