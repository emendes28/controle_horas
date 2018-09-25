import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() => runApp(MyApp());
const String title_app = 'Controle';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title_app,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FrontPage(),
    );
  }
}

class DayOfJob {
    
    DateTime jobDay; 
    DateTime entry; 
    DateTime goLauch; 
    DateTime returnLauch; 
    DateTime endDay;

    DayOfJob(this.jobDay, this.entry, this.goLauch, this.returnLauch, this.endDay);

    DayOfJob.fromJson(Map<String, dynamic> json)
          : jobDay = json['jobDay'], 
            entry = json['entry'], 
            goLauch = json['goLauch'], 
            returnLauch = json['returnLauch'], 
            endDay = json['endDay'];
    Map<String, dynamic> toJson() => 
    {
        'jobDay' : jobDay,
        'entry' : entry,
        'goLauch' : goLauch,
        'returnLauch' : returnLauch,
        'endDay' : endDay,
    };

    String get dayFormatPtBr =>
      '${jobDay.day}/${jobDay.month.toString()}/${jobDay.year}';

    String hourFormatPtBr(DateTime period) =>
        period != null ? 
          '${_getFormatedNumber(period.hour)}:${_getFormatedNumber(period.minute)}:${_getFormatedNumber(period.second)}' 
          : 'nenhum registro encontrado';

      
  String _getFormatedNumber(int numbe) {
    if (numbe < 11 ) {
      return '0${numbe}';
    }
    return '${numbe}';
  }
}

class FrontPage extends StatefulWidget {
  FrontPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _FrontPageState createState() => _FrontPageState();
}


String title_home_page(day) => 'Controle de Horas - ${day}';
class _FrontPageState extends State<FrontPage> {
  final DayOfJob _diaDeTrabalho = DayOfJob(DateTime.now(), null, null, null, null);
  
  final TextStyle _biggerFont = const TextStyle(fontSize: 35.0);
  final TextStyle _smallFont = const TextStyle(fontSize: 18.0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title_home_page(_diaDeTrabalho.dayFormatPtBr)),
      ),
      body: new StreamBuilder(
          stream: Firestore.instance.collection('horas_setembro').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return const Text('Loading...');
            return new ListView.builder(
              itemCount: snapshot.data.documents.length,
              padding: const EdgeInsets.only(top: 10.0),
              itemExtent: 25.0,
              itemBuilder: (context, index) {
                DocumentSnapshot ds = snapshot.data.ddocuments[index];
                return _buildDayOfJob(ds);
              }
            );
          }),
    );
  }

  Widget _buildDayOfJob( DocumentSnapshot ds) {
    return Column (
      children: <Widget>[
        _buildEntry(_diaDeTrabalho, 'Entrada : '),
        Text('--------Inicio Almoço---------'),
        _buildGoLauch(_diaDeTrabalho, 'Ida : '),
        _buildReturnLauch(_diaDeTrabalho, 'Volta : '),
        Text('--------Almoço Fim----------'),
        _buildEndDay(_diaDeTrabalho, 'Saida : ', ds)
      ],
    );
  }

  Widget _buildEntry(DayOfJob day, String text) {
    final bool alreadyInformed = day.entry != null;
    String hour = day.hourFormatPtBr(day.entry);
      return ListTile(
        title: Text( 
          '${text} - ${hour}',
          style: _biggerFont,
        ),
        trailing: new Icon(   // Add the lines from here... 
          alreadyInformed ? Icons.access_time : Icons.add_circle,
          color: alreadyInformed ? Colors.red : null,
        ),   
        onTap: () {      // Add 9 lines from here...
          setState(() {
            if (day.entry == null) {
              day.entry  = DateTime.now();
            }
          });
        }
    );
  }
  
  Widget _buildGoLauch(DayOfJob day, String text) {
    final bool alreadyInformed = day.goLauch != null;
    String hour = day.hourFormatPtBr(day.goLauch);
      return ListTile(
        title: Text( 
          '${text} - ${hour}',
          style: _biggerFont,
        ),
        trailing: new Icon(   // Add the lines from here... 
          alreadyInformed ? Icons.access_time : Icons.add_circle,
          color: alreadyInformed ? Colors.red : null,
        ),   
        onTap: () {      // Add 9 lines from here...
          setState(() {
            if (day.goLauch == null) {
              day.goLauch  = DateTime.now();
            }
          });
        }
    );
  }
  
  Widget _buildReturnLauch(DayOfJob day, String text) {
    final bool alreadyInformed = day.returnLauch != null;
    String hour = day.hourFormatPtBr(day.returnLauch);
      return ListTile(
        title: Text( 
          '${text} - ${hour}',
          style: _biggerFont,
        ),
        trailing: new Icon(   // Add the lines from here... 
          alreadyInformed ? Icons.access_time : Icons.add_circle,
          color: alreadyInformed ? Colors.red : null,
        ),   
        onTap: () {      // Add 9 lines from here...
          setState(() {
            if (day.returnLauch == null) {
              day.returnLauch  = DateTime.now();
            }
          });
        }
    );
  }

  Widget _buildEndDay(DayOfJob day, String text, DocumentSnapshot ds) {
    final bool alreadyInformed = day.endDay != null;
    String hour = day.hourFormatPtBr(day.endDay);
      return ListTile(
        title: Text( 
          '${text} - ${hour}',
          style: _biggerFont,
        ),
        trailing: new Icon(   // Add the lines from here... 
          alreadyInformed ? Icons.access_time : Icons.add_circle,
          color: alreadyInformed ? Colors.red : null,
        ),   
        onTap: () {      // Add 9 lines from here...
          setState(() {
            if (day.endDay == null) {
              Firestore.instance.runTransaction((transaction) async {
                  DocumentSnapshot freshSnap = await transaction.get(ds.reference);
                  await transaction.update(freshSnap.reference, day.toJson());
                });
            }
          });
        }
    );
  }
}