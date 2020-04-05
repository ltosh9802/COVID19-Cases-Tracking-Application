import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; 
import 'package:intl/intl.dart';
import 'areadetails.dart';

class MainScreen extends StatefulWidget {

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  String totalWorldCases='';
  String totalAreaCases='';
  String totalAreaDeaths='';
  String totalAreaRecovered='';
  List<Areadetails> areadetails=[];


  @override
  void initState() {
    super.initState();

    areadetails.add(new Areadetails('date', 'confirmed', 'deaths', 'recovered'));
    areadetails.add(new Areadetails('date', 'confirmed', 'deaths', 'recovered'));
    areadetails.add(new Areadetails('date', 'confirmed', 'deaths', 'recovered'));
    areadetails.add(new Areadetails('date', 'confirmed', 'deaths', 'recovered'));
    areadetails.add(new Areadetails('date', 'confirmed', 'deaths', 'recovered'));
    areadetails.add(new Areadetails('date', 'confirmed', 'deaths', 'recovered'));
    areadetails.add(new Areadetails('date', 'confirmed', 'deaths', 'recovered'));
    

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("CoronaTracker"),),
      floatingActionButton: FloatingActionButton(onPressed: null,child: Icon(Icons.refresh)),
      body: Container(
        child: Column(
          children: <Widget>[
             Container(
              width: double.infinity,
              color: Colors.orange,
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text('WorldWide'),
                  Text('Confirmed: '+ totalAreaCases, style: TextStyle(fontSize: 14),),
                  Text('Deaths', style: TextStyle(fontSize: 14),),
                  Text('Recovered', style: TextStyle(fontSize: 14),),
                  
                ],
              ),
            ),
            
            SizedBox(
              height: 10,
            ),

            Container(
              width: double.infinity,
              color: Colors.green,
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text('India'),
                  Text('Confirmed: '+ totalAreaCases, style: TextStyle(fontSize: 14),),
                  Text('Deaths', style: TextStyle(fontSize: 14),),
                  Text('Recovered', style: TextStyle(fontSize: 14),),
                  
                ],
              ),
            ),

            SizedBox(
              height: 50,
            ),

            Expanded(
                child: ListView(
                  scrollDirection: Axis.vertical,
                  children: <Widget>[
                    ListTile(
                      leading:Text(DateFormat('dd-MM-yyy').format(DateTime.now().subtract(new Duration(days:1))).toString()),
                      title: Text('Confirmed: '+areadetails[0].confirmed+' Deaths: '+areadetails[0].deaths+' Recovered: '+areadetails[0].recovered, style: TextStyle(fontSize: 12),),
                      trailing: FlatButton(onPressed: ()=>gettotalcases(1), child: Icon(Icons.access_alarm)),
                    ),

                    ListTile(
                      leading:Text(DateFormat('dd-MM-yyy').format(DateTime.now().subtract(new Duration(days:2))).toString()),
                      title: Text('Confirmed: '+areadetails[1].confirmed+' Deaths: '+areadetails[1].deaths+' Recovered: '+areadetails[1].recovered, style: TextStyle(fontSize: 12),),
                      trailing: FlatButton(onPressed: ()=>gettotalcases(2), child: Icon(Icons.access_alarm)),
                    ),
                    
                    ListTile(
                      leading:Text(DateFormat('dd-MM-yyy').format(DateTime.now().subtract(new Duration(days:3))).toString()),
                      title: Text('Confirmed: '+areadetails[2].confirmed+' Deaths: '+areadetails[2].deaths+' Recovered: '+areadetails[2].recovered, style: TextStyle(fontSize: 12),),
                      trailing: FlatButton(onPressed: ()=>gettotalcases(3), child: Icon(Icons.access_alarm)),
                    ),
                    
                    
                    
                ],
              ),
            )


          ],
        ),
      ),

    );
  }


  void gettotalcases(int index) async{
    http.Response reslocal=await http.get('https://wuhan-coronavirus-api.laeyoung.endpoint.ainize.ai/jhu-edu/timeseries?iso2=IN');
    
    if(reslocal.statusCode == 200){
      String data = reslocal.body;
      var yesterday = DateTime.now().subtract(new Duration(days:index)); 
      var stryesterday=(yesterday.month.toString()+'/'+ yesterday.day.toString()+'/20');

      int totalC = jsonDecode(data)[0]['timeseries'][stryesterday]['confirmed'];    //0.timeseries.4/1/20
      int totalD = jsonDecode(data)[0]['timeseries'][stryesterday]['deaths'];    //0.timeseries.4/1/20
      int totalR = jsonDecode(data)[0]['timeseries'][stryesterday]['recovered'];    //0.timeseries.4/1/20
    


      print(totalC);
      
      Areadetails obj = new Areadetails(yesterday.toString(),totalC.toString(),totalD.toString(),totalR.toString());
      areadetails.add(obj);


      setState(() {
        areadetails[index-1].confirmed=totalC.toString();
        areadetails[index-1].deaths=totalD.toString();
        areadetails[index-1].recovered=totalR.toString();


      });


    }
    else{
      print(reslocal.statusCode);
    }


}}