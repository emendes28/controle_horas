import 'dayOfJob.dart';
import 'package:flutter/material.dart';
import 'fetchapi.dart';

class FrontPage extends StatefulWidget {
  FrontPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _FrontPageState createState() => _FrontPageState();
}

String title_home_page(day) => 'Controle de Horas - ${day}';
String returnFirebase = '';
class _FrontPageState extends State<FrontPage> {
  DayOfJob _diaDeTrabalho = DayOfJob(DateTime.now(), null, null, null, null);
  
  final TextStyle _biggerFont = const TextStyle(fontSize: 25.0);
  final TextStyle _smallFont = const TextStyle(fontSize: 18.0);
   
  @override
  Widget build(BuildContext context) {  
    return Scaffold(
      appBar: AppBar(
        title: Text(title_home_page(_diaDeTrabalho.dayFormatPtBr)),
      ),
      body: FutureBuilder<DayOfJob>(
            future: fetchDayOfJob(_diaDeTrabalho.jobDay),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return  Text("${snapshot.data}");
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }

              // By default, show a loading spinner
              return CircularProgressIndicator();
            },
          ),
    );
  }

  Widget _buildDayOfJob() {
    return Column (
      children: <Widget>[
        _buildEntry(_diaDeTrabalho, 'Entrada'),
        Text('--------Inicio Almoço---------'),
        _buildGoLauch(_diaDeTrabalho, 'Ida'),
        _buildReturnLauch(_diaDeTrabalho, 'Volta'),
        Text('--------Almoço Fim----------'),
        _buildEndDay(_diaDeTrabalho, 'Saida'),
        Text(returnFirebase)
      ],
    );
  }

  Widget _buildEntry(DayOfJob day, String text ) {
    final bool alreadyInformed = day.entry != null;
    String hour = day.hourFormatPtBr(day.entry);
      return ListTile(
        title: Text( 
          '${text}: ${hour}',
          style: _biggerFont,
        ),
        trailing: new Icon(   // Add the lines from here... 
          alreadyInformed ? Icons.access_time : Icons.add_circle,
          color: alreadyInformed ? Colors.red : null,
        ),   
        onTap: () {      // Add 9 lines from here...
          setState(() {
              day.entry  = DateTime.now();
              saveDayOfJob(day);
          });
        }
    );
  }
  
  Widget _buildGoLauch(DayOfJob day, String text ) {
    final bool alreadyInformed = day.goLauch != null;
    String hour = day.hourFormatPtBr(day.goLauch);
      return ListTile(
        title: Text( 
          '${text}: ${hour}',
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
              saveDayOfJob(day);
            }
          });
        }
    );
  }
  
  Widget _buildReturnLauch(DayOfJob day, String text ) {
    final bool alreadyInformed = day.returnLauch != null;
    String hour = day.hourFormatPtBr(day.returnLauch);
      return ListTile(
        title: Text( 
          '${text}: ${hour}',
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
              saveDayOfJob(day);
            }
          });
        }
    );
  }

  Widget _buildEndDay(DayOfJob day, String text ) {
    final bool alreadyInformed = day.endDay != null;
    String hour = day.hourFormatPtBr(day.endDay);
      return ListTile(
        title: Text( 
          '${text}: ${hour}',
          style: _biggerFont,
        ),
        trailing: new Icon(   // Add the lines from here... 
          alreadyInformed ? Icons.access_time : Icons.add_circle,
          color: alreadyInformed ? Colors.red : null,
        ),   
        onTap: () {      // Add 9 lines from here...
          setState(() {
            if (day.endDay == null) {
                 day.endDay = DateTime.now();
              saveDayOfJob(day);
            }
          });
        }
  
    );
  }

}
