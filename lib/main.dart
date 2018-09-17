import 'package:flutter/material.dart';

void main() => runApp(new MyApp());
const String title_app = 'Controle';
const String title_home_page = 'Controle de Horas';
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: title_app,
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: title_home_page),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _count = 0;
  DateTime entrada, saidaAlmoco, voltaAlmoco, saida;

  void _incrementCounter() {
    setState(() {
      _count ++;
      if (entrada == null && _count == 1) {
        entrada = DateTime.now();
      }
      if (saidaAlmoco == null && _count == 2) {
        saidaAlmoco = DateTime.now();
      }
      if (voltaAlmoco == null && _count == 3) {
        voltaAlmoco = DateTime.now();
      }
      if (saida == null&& _count == 4) {
        saida = DateTime.now();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(
              '${DateTime.now().day}/${DateTime.now().month.toString()}/${DateTime.now().year}',
              style: Theme.of(context).textTheme.display1,
            ),
            new Text(
              'Entrada : ${entrada?.toIso8601String()?.substring(11)?.split('.')}',
              style: Theme.of(context).textTheme.display1,
            ),
            new Text(
              'Saida Almoço : ${saidaAlmoco?.toIso8601String()?.substring(11)?.split('.')}',
              style: Theme.of(context).textTheme.display1,
            ),
            new Text(
              'Volta Almoço : ${voltaAlmoco?.toIso8601String()?.substring(11)?.split('.')}',
              style: Theme.of(context).textTheme.display1,
            ),
            new Text(
              'Saida : ${saida?.toIso8601String()?.substring(11)?.split('.')}',
              style: Theme.of(context).textTheme.display1,
            )
          ],
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: new Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
