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
  Map<String, bool> _filter = {
    "Incidente com dano": false,
    "Incidente sem dano": false,
    "Circunstância notificável": false,
    "Quase erro": false,
    "Sem classificação": false,
  };

  Map<String, bool> _orderBy = {
    "Data de ocorrência": false,
    "Idade": false,
  };

  Map<String, bool> _menuFilter = {
    "Filtrar incidentes": false,
    "Ordenar por": false,
  };

  String _choiceFilter;
  String _choiceIncident;
  bool showMenu = false;
  bool showCheckboxFilter = false;
  bool showCheckboxOrder = false;

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
    String type2 =
        showCheckboxFilter ? "Filtro" : (showCheckboxOrder ? "Ordem" : "");

    return Container(
      child: Column(
        children: [
          _filtersOn(),
          Divider(
            color: Color(0xFF002C3E),
            height: 1,
          ),
          Flexible(
              child: Stack(
            children: [
              _listIncidents(),
              Positioned(
                top: 158,
                right: 0,
                left: 0,
                child: _checkboxAnimated(context, type2),
              ),
              Positioned(
                top: 0,
                right: 0,
                left: 0,
                child: _checkboxAnimated(context, type),
              ),
            ],
          ))
        ],
      ),
    );
  }

  _filtersOn() {
    String s1;
    String s2;
    if (_choiceFilter != null) {
      if (_choiceFilter.compareTo("Classificação") == 0) {
        s1 = _choiceFilter + ": ";
        s2 = _choiceIncident;
      } else {
        s1 = "Ordenado por: ";
        s2 = _choiceFilter;
      }
    }

    return Container(
      padding: EdgeInsets.only(top: 8.0, right: 16.0, left: 16.0),
      child: Column(
        children: [
          _choiceFilter != null
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _text(s1),
                    _text(s2),
                  ],
                )
              : Container(),
          Row(
            mainAxisAlignment: _choiceFilter != null
                ? MainAxisAlignment.spaceAround
                : MainAxisAlignment.end,
            children: [
              _showFilterButton(),
              _choiceFilter != null ? _removeFilterButton() : Container(),
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
            if (showMenu) {
              if (_menuFilter.values.elementAt(0)) {
                _filterButton();
              } else if (_menuFilter.values.elementAt(1)) {
                _orderButton();
              }
            } else {
              showCheckboxFilter = false;
              showCheckboxOrder = false;
            }
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
            _choiceFilter = null;
            _choiceIncident = null;
            _menuFilter.forEach((key, value) {
              _menuFilter[key] = false;
            });
            _filter.forEach((key, value) {
              _filter[key] = false;
            });
            _orderBy.forEach((key, value) {
              _orderBy[key] = false;
            });
            showMenu = false;
            showCheckboxFilter = false;
            showCheckboxOrder = false;
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
      child: StreamBuilder<QuerySnapshot>(
        stream: _order(
          _choiceFilter,
          this.widget.base,
          specif: _choiceIncident,
        ),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
    );
  }

  //Não está sendo usado
  _menu() {
    return IconButton(
        icon: Icon(Icons.menu),
        onPressed: () {
          setState(() {
            showMenu = !showMenu;
            if (showMenu) {
              if (_menuFilter.values.elementAt(0)) {
                _filterButton();
              } else if (_menuFilter.values.elementAt(1)) {
                _orderButton();
              }
            } else {
              showCheckboxFilter = false;
              showCheckboxOrder = false;
            }
          });
        });
  }

  _filterButton() {
    return setState(() {
      showCheckboxFilter = !showCheckboxFilter;
      if (showCheckboxFilter) showCheckboxOrder = false;
    });
  }

  _orderButton() {
    return setState(() {
      showCheckboxOrder = !showCheckboxOrder;
      if (showCheckboxOrder) showCheckboxFilter = false;
    });
  }

  _checkboxFilter(BuildContext context) {
    return Container(
      key: ValueKey<bool>(showCheckboxFilter),
      width: MediaQuery.of(this.context).size.width,
      padding: EdgeInsets.only(left: 16, right: 16),
      margin: EdgeInsets.only(right: 8, left: 8),
      decoration: BoxDecoration(
          //borderRadius: BorderRadius.all(Radius.circular(16.0)),
          color: Color(0xFFFFF8DC)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(children: [_text("Tipos de categorias:")]),
          Column(
            children: _filter.keys
                .map<Widget>((String key) => CheckboxListTile(
                      title: _text(key),
                      value: _filter[key],
                      onChanged: (bool change) {
                        setState(() {
                          _filter.forEach((k, v) {
                            _filter[k] = false; //reseta todo filtro
                          });
                          _orderBy.forEach((k, v) {
                            _orderBy[k] = false; //reseta toda ordem
                          });
                          _filter[key] = change;
                          if (change) {
                            //se change for true filtra por categoria e o tipo de incidente
                            _choiceFilter = "Classificação";
                            _choiceIncident = key;
                          } else if (_filter[_choiceIncident] == false) {
                            _choiceFilter = null;
                            _choiceIncident = null;
                          }
                        });
                      },
                    ))
                .toList(),
          )
        ],
      ),
    );
  }

  _checkboxOrder(BuildContext context) {
    return Container(
      key: ValueKey<bool>(showCheckboxOrder),
      width: MediaQuery.of(this.context).size.width,
      padding: EdgeInsets.only(left: 16, right: 16),
      margin: EdgeInsets.only(right: 8, left: 8),
      decoration: BoxDecoration(
          //borderRadius: BorderRadius.all(Radius.circular(16.0)),
          color: Color(0xFFFFF8DC)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(children: [_text("Formas de ordenação:")]),
          Column(
              children: _orderBy.keys
                  .map<Widget>((String key) => CheckboxListTile(
                        title: _text(key),
                        value: _orderBy[key],
                        onChanged: (bool change) {
                          setState(() {
                            _filter.forEach((k, v) {
                              _filter[k] = false; //reseta todo filtro
                            });
                            _orderBy.forEach((k, v) {
                              _orderBy[k] = false; // reseta toda ordem
                            });
                            _orderBy[key] = change;
                            if (change) // se change for true filtra pela ordem escolhida
                              _choiceFilter = key;
                            else if (_orderBy[_choiceFilter] == false)
                              _choiceFilter = null;
                          });
                        },
                      ))
                  .toList()),
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
              CloseButton(
                onPressed: () {
                  setState(() {
                    showMenu = false;
                    if (showMenu) {
                      if (_menuFilter.values.elementAt(0)) {
                        _filterButton();
                      } else if (_menuFilter.values.elementAt(1)) {
                        _orderButton();
                      }
                    } else {
                      showCheckboxFilter = false;
                      showCheckboxOrder = false;
                    }
                  });
                },
              )
            ],
          ),
          Column(
            children: _menuFilter.keys
                .map<Widget>((String key) => ExpansionPanelList(
                      //title: _text(key),
                      children: [_checkboxFilter(context)],
                      expansionCallback: (int index, bool change) {
                        print("Change: " + key + " " + change.toString());
                        setState(() {
                          _menuFilter.forEach((k, v) {
                            _menuFilter[k] = false; //reseta todo filtro
                          });
                          _menuFilter[key] = change;
                          if (change) {
                            if (_menuFilter.values.elementAt(0)) {
                              _filterButton();
                            } else if (_menuFilter.values.elementAt(1)) {
                              _orderButton();
                            }
                          } else {
                            showCheckboxFilter = false;
                            showCheckboxOrder = false;
                          }
                        });
                      },
                    ))
                .toList(),
          )
        ],
      ),
    );
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

      case "MenuOFF":
        _menuFilter.forEach((k, v) {
          _menuFilter[k] = false; //reseta todo filtro
        });
        checkbox = Container();
        break;

      case "Ordem":
        checkbox = showCheckboxOrder
            ? _checkboxOrder(context)
            : Container(
                key: ValueKey<bool>(showCheckboxOrder),
              );
        break;
      case "Filtro":
        checkbox = showCheckboxFilter
            ? _checkboxFilter(context)
            : Container(
                key: ValueKey<bool>(showCheckboxFilter),
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
    return Text(
      string,
      style: TextStyle(fontSize: 18),
    );
  }

  _order(String type, String base, {String specif}) {
    var dataBase;

    if (specif == "Sem classificação") {
      specif = "";
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

    switch (type) {
      case "Data da ocorrência":
        return dataBase.orderBy("occurrenceDate", descending: true).snapshots();
        break;
      case "Idade":
        return dataBase.orderBy("age").snapshots();
        break;
      case "Classificação":
        return dataBase
            .orderBy("createdAt", descending: true)
            .where("classification", isEqualTo: specif)
            .snapshots();
        break;
      default: //Ordena por data de criação
        return dataBase.orderBy("createdAt", descending: true).snapshots();
        break;
    }
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
}
