import 'package:flutter/material.dart';
import 'package:noti_samu/screens/Relator/Registro/registroDadosObrigatorio.dart';
import 'package:noti_samu/screens/Relator/notificacao.dart';

class Paciente extends StatefulWidget {
  Notificacao notificacao;
  Paciente(this.notificacao);
  @override
  _PacienteState createState() => _PacienteState();
}

class _PacienteState extends State<Paciente> {
  
  String _radioValue;
  final paciente = TextEditingController();
  DateTime selectedDate = DateTime.now();

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
            _nomeDoPaciente(),
            SizedBox(
              height: 40,
            ),
            _dataNascimento(selectedDate),
            SizedBox(height: 40),
            _radioButtonSexo(),
          ],
        ),
      ),
    );
  }

  _nomeDoPaciente() {
    return TextFormField(
      controller: paciente,
      style: TextStyle(
        color: Colors.black,
        fontSize: 18,
      ),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32),
        ),
        hintText: "Nome do paciente(opcional)",
      ),
    );
  }

  Future<DateTime> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: new DateTime.now().subtract(Duration(days: 120 * 365)),
      lastDate: new DateTime.now().add(Duration(days: 367)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            primaryColor: Colors.red, 
            accentColor:
                Colors.red, 
            buttonTheme: ButtonThemeData(
                textTheme: ButtonTextTheme
                    .accent 
                ),
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

  _dataNascimento(selectedDate) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          "Data de nascimento:",
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        GestureDetector(
          onTap: () => _selectDate(context),
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
          onPressed: () => _selectDate(context),
        ),
      ],
    );
  }

  _radioButtonSexo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Sexo do paciente:',
          textAlign: TextAlign.left,
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        _radioButton('M'),
        _radioButton('F'),
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
        if(paciente.text.isEmpty) this.widget.notificacao.paciente = "Não informado";
        else this.widget.notificacao.paciente = paciente.text;
        this.widget.notificacao.nascimento = selectedDate;
        this.widget.notificacao.sexo = _radioValue;
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => Ocorrencia(widget.notificacao)));
      },
      label: Text('Continuar'),
      icon: Icon(Icons.skip_next),
      backgroundColor: Colors.redAccent,
    );
  }
}
