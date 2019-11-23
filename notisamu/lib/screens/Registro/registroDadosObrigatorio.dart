import 'package:flutter/material.dart';
import 'package:noti_samu/screens/Registro/categoriaIncidente.dart';

class Ocorrencia extends StatefulWidget {
  @override
  _OcorrenciaState createState() => _OcorrenciaState();
}

class _OcorrenciaState extends State<Ocorrencia> {
  
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
      debugPrint(_radioValue); //Debug the choice in console
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
        SizedBox(height: 20,),
        _numeroOcorrencia(),
        SizedBox(height: 40,),
        _localOcorrencia(),
        SizedBox(height: 40,),
        _dataOcorrencia(selectedDate),
        SizedBox(height: 40,),
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
            primaryColor: Colors.red, //color of the main banner
            accentColor:
                Colors.red, //color of circle indicating the selected date
            buttonTheme: ButtonThemeData(
                textTheme: ButtonTextTheme
                    .accent //color of the text in the button "OK/CANCEL"
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
            .push(MaterialPageRoute(builder: (context) => Categoria()));
      },
      label: Text('Continuar'),
      icon: Icon(Icons.skip_next),
      backgroundColor: Colors.redAccent,
    );
  }
}
