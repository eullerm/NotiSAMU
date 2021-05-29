import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:noti_samu/components/cardNotify.dart';
import 'package:noti_samu/screens/Admin/detailsNotice.dart';
import 'package:noti_samu/services/baseAuth.dart';
import 'package:page_transition/page_transition.dart';

class Feed extends StatefulWidget {
  Feed(this.base, this.auth);

  final String base;
  final BaseAuth auth;

  @override
  _FeedState createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  Map<String, List<String>> _menuFilter = {
    "Filtrar incidentes": [
      "Incidente com dano",
      "Incidente sem dano",
      "Circunstância notificável",
      "Quase erro",
      "Sem classificação",
    ],
    "Ordenar por": [
      "Data de ocorrência",
      "Idade",
    ],
  };

  List<String> _filters = [];

  String _radioFilter;
  String _radioOrder;
  bool showMenu = false;

  bool admin;

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
            this.widget.auth.signOut();
            Navigator.pop(context);
          },
        ),
        actions: <Widget>[
          //_menu(), //Não está sendo usado
        ],
      ),
      body: _body(context),
    );
  }

  _body(BuildContext context) {
    String type = showMenu ? "Menu" : "MenuOFF";

    return Container(
      child: Column(
        children: [
          _filtersOn(),
          Divider(
            color: Color(0xFF002C3E),
            height: 1,
          ),
          Flexible(
            flex: 1,
            child: Stack(
              children: [
                _listIncidents(),
                _checkboxAnimated(context, type),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _filtersOn() {
    return Container(
      padding: EdgeInsets.only(top: 8.0, right: 16.0, left: 16.0),
      child: Column(
        children: [
          _radioFilter != null
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _text("Classificação: "),
                    _text(_radioFilter),
                  ],
                )
              : Container(),
          _radioOrder != null
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _text("Ordenado por: "),
                    _text(_radioOrder),
                  ],
                )
              : Container(),
          Row(
            mainAxisAlignment: _radioFilter != null || _radioOrder != null
                ? MainAxisAlignment.spaceAround
                : MainAxisAlignment.end,
            children: [
              _showFilterButton(),
              _radioFilter != null || _radioOrder != null
                  ? _removeFilterButton()
                  : Container(),
            ],
          ),
        ],
      ),
    );
  }

  _showFilterButton() {
    return ButtonTheme(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Color(0xFF002C3E),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
        ),
        onPressed: () {
          setState(() {
            showMenu = !showMenu;
          });
        },
        child: Text(
          "Filtrar",
          style: TextStyle(
            fontSize: 18,
          ),
        ),
      ),
    );
  }

  _removeFilterButton() {
    return ButtonTheme(
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          primary: Color(0xFF002C3E),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
        ),
        onPressed: () {
          setState(() {
            _radioFilter = null;
            _radioOrder = null;
            _filters = [];
          });
        },
        child: Text(
          "Remover filtros",
          style: TextStyle(
            fontSize: 18,
          ),
        ),
      ),
    );
  }

  _listIncidents() {
    return Container(
      padding: EdgeInsets.only(left: 5, right: 5),
      alignment: FractionalOffset.center,
      child: Stack(
        children: [
          StreamBuilder<QuerySnapshot>(
            stream: _order(
              _filters,
              this.widget.base,
            ),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              print("Snapshot ${snapshot.data}");
              if (snapshot.hasError) _snapshotError(snapshot);

              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                  break;

                case ConnectionState.none:
                  return _snapshotEmpty();
                  break;

                case ConnectionState.active:
                  return Center(
                    child: ListView(
                      children: _listNotify(snapshot),
                    ),
                  );
                  break;

                default:
                  return _snapshotEmpty();
                  break;
              }
            },
          ),
        ],
      ),
    );
  }

  _checkboxMenu(BuildContext context) {
    return Container(
      key: ValueKey<bool>(showMenu),
      width: MediaQuery.of(this.context).size.width,
      padding: EdgeInsets.only(left: 16, right: 16),
      margin: EdgeInsets.only(right: 8, left: 8),
      decoration: BoxDecoration(
          //borderRadius: BorderRadius.all(Radius.circular(16.0)),
          color: Color(0xFFFFF8DC)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _closedButton(),
            ],
          ),
          Column(
            children: _menuFilter.keys
                .map<Widget>((String key) => ExpansionTile(
                      title: _text(key),
                      children: <Widget>[
                        _buildExpandableContent(key, _menuFilter[key]),
                      ],
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }

  _buildExpandableContent(String value, List<String> l) {
    switch (value) {
      case "Filtrar incidentes":
        return Column(
          children: l
              .map<Widget>(
                (String key) => RadioListTile(
                  title: _text(key),
                  activeColor: Color(0xFF648D56),
                  value: key,
                  groupValue: _radioFilter,
                  onChanged: (value) {
                    setState(() {
                      _radioFilter = value;
                      if (!_filters.contains("Classificação")) {
                        _filters.add("Classificação");
                      }
                    });
                  },
                  toggleable: true,
                ),
              )
              .toList(),
        );
        break;
      case "Ordenar por":
        return Column(
          children: l
              .map<Widget>(
                (String key) => RadioListTile(
                  title: _text(key),
                  activeColor: Color(0xFF648D56),
                  value: key,
                  groupValue: _radioOrder,
                  onChanged: (value) {
                    setState(() {
                      if (!_filters.contains(_radioOrder)) _radioOrder = value;
                    });
                  },
                  toggleable: true,
                ),
              )
              .toList(),
        );
        break;
      default:
    }
  }

  _checkboxAnimated(BuildContext context, String type) {
    Widget checkbox;
    double x = 0.0;
    double y = -1.0;
    switch (type) {
      case "Menu":
        checkbox = showMenu
            ? _checkboxMenu(context)
            : Container(
                key: ValueKey<bool>(showMenu),
              );
        break;
      default:
        checkbox = Container();
        break;
    }

    return AnimatedSwitcher(
      duration: Duration(milliseconds: 200),
      transitionBuilder: (Widget child, Animation<double> animation) {
        return SlideTransition(
          position: Tween(begin: Offset(x, y), end: Offset(0.0, 0.0))
              .animate(animation),
          child: child,
        );
      },
      child: checkbox,
    );
  }

  _text(String string) {
    return Flexible(
      flex: 1,
      child: Text(
        string,
        style: TextStyle(fontSize: 18),
      ),
    );
  }

  _order(List<String> type, String base) {
    var dataBase;
    String f;
    if (_radioFilter == "Sem classificação") {
      f = "";
    } else {
      f = _radioFilter;
    }

    if (base.compareTo("geral") == 0) {
      dataBase = Firestore.instance.collection('notification');
      admin = true;
    } else {
      dataBase = Firestore.instance
          .collection('notification')
          .where("base", isEqualTo: base);
      admin = false;
    }

    if (type.isNotEmpty) {
      if (type.contains("Ordenar por")) {
        if (_radioOrder.compareTo("Data da ocorrência") == 0) {
          dataBase = dataBase.orderBy("occurrenceDate", descending: true);
        } else if (_radioOrder.compareTo("Idade") == 0) {
          dataBase = dataBase.orderBy("age");
        }
      }

      if (type.contains("Classificação")) {
        dataBase = dataBase
            .orderBy("createdAt", descending: true)
            .where("classification", isEqualTo: f);
      }
    } else {
      dataBase = dataBase.orderBy("createdAt", descending: true);
    }
    return dataBase.snapshots();
  }

  _listNotify(AsyncSnapshot snapshot) {
    return snapshot.data.documents.map<Widget>((DocumentSnapshot doc) {
      return GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              PageTransition(
                  duration: Duration(milliseconds: 200),
                  type: PageTransitionType.rightToLeft,
                  child: DetailsNotice(doc, admin)));
        },
        child: CardNotify(doc),
      );
    }).toList();
  }

  _snapshotError(AsyncSnapshot snapshot) {
    return Container(
      child: Center(
        child: _text('Erro: ${snapshot.error}'),
      ),
    );
  }

  _snapshotEmpty() {
    return Center(
      child: Text(
        "Nenhuma notificação foi encontrada.",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 18,
        ),
      ),
    );
  }

  _closedButton() {
    return CloseButton(
      onPressed: () {
        setState(() {
          showMenu = false;
        });
      },
    );
  }
}
