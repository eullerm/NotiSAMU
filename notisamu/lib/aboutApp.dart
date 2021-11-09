import 'package:flutter/material.dart';

class AboutApp extends StatefulWidget {
  const AboutApp({Key key}) : super(key: key);

  @override
  _AboutAppState createState() => _AboutAppState();
}

class _AboutAppState extends State<AboutApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFF7444E),
        title: Text("NotiSAMU"),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: _body(context),
    );
  }

  _body(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    print("size: " + size.toString());
    return Container(
      padding: EdgeInsets.all(16),
      width: size.width,
      child: ListView(
        children: <Widget>[
          _about(),
          SizedBox(height: 15),
          _version(),
          _termsAndConditions(),
          _privacy(),
        ],
      ),
    );
  }

  _about() {
    return RichText(
        softWrap: true,
        textAlign: TextAlign.justify,
        text: TextSpan(
          children: <TextSpan>[
            TextSpan(
              text:
                  "O aplicativo tem como objetivo reunir informações sobre incidentes ocorridos durante o atendimento ambulatorial de emergência e analisar os dados para compreender o quadro dos problemas, como indisponibilidade de medicamentos, de equipamentos e erros humanos, para assim poder agir para melhorar o atendimento.",
              style: TextStyle(fontSize: 15, color: Colors.black),
            ),
          ],
        ));
  }

  _version() {
    return Theme(
      data: ThemeData(colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Color(0xFF78BCC4))),
      child: ExpansionTile(
        title: Text("Versão"),
        expandedAlignment: Alignment.topLeft,
        children: <Widget>[
          RichText(
            softWrap: true,
            textAlign: TextAlign.justify,
            text: TextSpan(
              children: <TextSpan>[
                TextSpan(
                  text: "Aplicativo em versão de teste.",
                  style: TextStyle(fontSize: 15, color: Colors.black),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }

  _termsAndConditions() {
    return Theme(
      data: ThemeData(colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Color(0xFF78BCC4))),
      child: ExpansionTile(
        title: Text("Termos e condições"),
        expandedAlignment: Alignment.topLeft,
        children: <Widget>[
          RichText(
            softWrap: true,
            textAlign: TextAlign.justify,
            text: TextSpan(
              children: <TextSpan>[
                TextSpan(
                  text: "--",
                  style: TextStyle(fontSize: 15, color: Colors.black),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }

  _privacy() {
    return Theme(
      data: ThemeData(colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Color(0xFF78BCC4))),
      child: ExpansionTile(
        title: Text("Política de privacidade"),
        expandedAlignment: Alignment.topLeft,
        children: <Widget>[
          RichText(
            softWrap: true,
            textAlign: TextAlign.justify,
            text: TextSpan(
              children: <TextSpan>[
                TextSpan(
                  text:
                      "O uso do aplicativo pode ser feito de forma anônima e informações como nome e número da ocorrência só são coletadas caso fornecidas pelo usuário.",
                  style: TextStyle(fontSize: 15, color: Colors.black),
                ),
              ],
            ),
          ),
          RichText(
            softWrap: true,
            textAlign: TextAlign.justify,
            text: TextSpan(
              children: <TextSpan>[
                TextSpan(
                  text: "Apenas as informações fornecidas pelo usuário são coletadas ao final do uso do aplicativo.",
                  style: TextStyle(fontSize: 15, color: Colors.black),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
