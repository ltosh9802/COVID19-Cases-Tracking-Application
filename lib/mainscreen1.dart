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

    Areadetails dummytoday = new Areadetails(DateTime.now().toString(), '2087', '50', '150');
    areadetails.add(dummytoday);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("CoronaTracker"),),
      floatingActionButton: FloatingActionButton(onPressed: gettotalcases,child: Icon(Icons.refresh)),
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
                      leading:Text(DateFormat('dd-MM-yyy').format(DateTime.now().subtract(new Duration(days:0))).toString()),
                      title: Text('Confirmed: '+areadetails[0].confirmed+' Deaths: '+areadetails[0].deaths+' Recovered: '+areadetails[0].recovered, style: TextStyle(fontSize: 12),),
                      
                    ),

                    ListTile(
                      leading:Text(DateFormat('dd-MM-yyy').format(DateTime.now().subtract(new Duration(days:1))).toString()),
                      title: Text('Confirmed: '+'Deaths: '+'Recovered: ', style: TextStyle(fontSize: 12),),
                    ),
                    
                    ListTile(
                      leading:Text(DateFormat('dd-MM-yyy').format(DateTime.now().subtract(new Duration(days:2))).toString()),
                      title: Text('Confirmed: '+'Deaths: '+'Recovered: ', style: TextStyle(fontSize: 12),),
                    ),

                    ListTile(
                      leading:Text(DateFormat('dd-MM-yyy').format(DateTime.now().subtract(new Duration(days:3))).toString()),
                      title: Text('Confirmed: '+'Deaths: '+'Recovered: ', style: TextStyle(fontSize: 12),),
                    ),
                    ListTile(
                      leading:Text(DateFormat('dd-MM-yyy').format(DateTime.now().subtract(new Duration(days:0))).toString()),
                      title: Text('Confirmed: '+'Deaths: '+'Recovered: ', style: TextStyle(fontSize: 12),),
                      
                    ),
                    ListTile(
                      leading:Text(DateFormat('dd-MM-yyy').format(DateTime.now().subtract(new Duration(days:3))).toString()),
                      title: Text('Confirmed: '+'Deaths: '+'Recovered: ', style: TextStyle(fontSize: 12),),
                    ),
                    ListTile(
                      leading:Text(DateFormat('dd-MM-yyy').format(DateTime.now().subtract(new Duration(days:0))).toString()),
                      title: Text('Confirmed: '+'Deaths: '+'Recovered: ', style: TextStyle(fontSize: 12),),
                      
                    ),ListTile(
                      leading:Text(DateFormat('dd-MM-yyy').format(DateTime.now().subtract(new Duration(days:3))).toString()),
                      title: Text('Confirmed: '+'Deaths: '+'Recovered: ', style: TextStyle(fontSize: 12),),
                    ),
                    ListTile(
                      leading:Text(DateFormat('dd-MM-yyy').format(DateTime.now().subtract(new Duration(days:0))).toString()),
                      title: Text('Confirmed: '+'Deaths: '+'Recovered: ', style: TextStyle(fontSize: 12),),
                      
                    ),
                    
                ],
              ),
            )


          ],
        ),
      ),

    );
  }


  Future<String> gettotalcases() async{
    http.Response reslocal=await http.get('https://wuhan-coronavirus-api.laeyoung.endpoint.ainize.ai/jhu-edu/timeseries?iso2=IN');
    Future<String> result;
  
    if(reslocal.statusCode == 200){
      String data = reslocal.body;
      var yesterday = DateTime.now().subtract(new Duration(days:1)); 
      var stryesterday=(yesterday.month.toString()+'/'+ yesterday.day.toString()+'/20');

      int totalC = await jsonDecode(data)[0]['timeseries'][stryesterday]['confirmed'];    //0.timeseries.4/1/20
      result = totalC.toString() as Future<String>;
      
      print(totalC);
      
      setState(() {
        totalAreaCases=totalC.toString();        

      });
      print('Total Cases as of '+stryesterday+' = '+totalAreaCases);


    }
    else{
      print(reslocal.statusCode);
    }

    return result;


}}