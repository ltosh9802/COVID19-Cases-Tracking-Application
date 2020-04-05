import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'areadetails.dart';
import 'package:toast/toast.dart';
 
class MainScreen extends StatefulWidget {

  final country;

  MainScreen(this.country);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  
  String totalGlobalCases = '';
  String totalGlobalDeaths = '';
  String totalGlobalRecovered = '';

  String countryCode;
  String totalAreaCases = '';
  String totalAreaDeaths = '';
  String totalAreaRecovered = '';
  List<Areadetails> areadetails = [];

  var noOfDays;
  
  @override
  void initState() {
    super.initState();
    
  
    countryCode=widget.country;
    getTotalGlobalCases();
    getTotalLocalCases();
    final initialdate = DateTime(2020, 03, 01);
    final today = DateTime.now();
    noOfDays = today.difference(initialdate).inDays;
    
    print(noOfDays);
    int index = 1;
    for (int i = 0; i < noOfDays; i++) {
      getPerDayCases(index);

      index++;
    }
    


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
                backgroundColor: Color(0xffd9faff),

      appBar: AppBar(
          backgroundColor: Color(0xff00204a),
          title: Text('CoronaTracker'),
          actions: <Widget>[
            FlatButton(onPressed: getAll, child: Icon(Icons.refresh,color: Colors.white))
          ],
        ),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              color: Color(0xff005792),
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text('WorldWide',style: TextStyle(color: Colors.white),),
                  Text(
                    'CON ' + totalGlobalCases,
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                  Text(
                    'DEA ' + totalGlobalDeaths,
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                  Text(
                    'REC ' + totalGlobalRecovered,
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              color: Color(0xff00bbf0),
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(countryCode, style: TextStyle(fontSize: 14, color: Colors.white),),
                  Text('CON ' + totalAreaCases, style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                  Text('DEA ' + totalAreaDeaths, style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                  Text('REC ' + totalAreaRecovered, style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Expanded(
            
                child: Scrollbar(
                
                                  child: ListView.builder(
                      itemCount: noOfDays,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          color: Color(0xffd9faff),
                                                child: ListTile(                        
                            leading: Text(DateFormat('dd-MM-yyy').format(DateTime.now().subtract(new Duration(days: index + 1))).toString()),
                            title: Text('Confirmed: ' +areadetails[index].confirmed +'\nDeaths: ' +areadetails[index].deaths +'\nRecovered: ' +areadetails[index].recovered,style: TextStyle(fontSize: 15, color: Color(0xff00204a)),
                            ),
                            trailing: FlatButton(onPressed: () => getPerDayCases(index + 1),child: Icon(Icons.cloud_download,color: Color(0x9900204a),)),
                          ),
                        );
                      }),
                ))
          ],
        ),
      ),
    );
  }

  void getAll() async {
      totalGlobalCases = '';
      totalGlobalDeaths = '';
      totalGlobalRecovered = '';

      countryCode='';
      totalAreaCases = '';
       totalAreaDeaths = '';
       totalAreaRecovered = '';
      areadetails = [];
          countryCode=widget.country;

      getTotalGlobalCases();
    getTotalLocalCases();
    final initialdate = DateTime(2020, 03, 01);
    final today = DateTime.now();
    noOfDays = today.difference(initialdate).inDays;
    
    print(noOfDays);
    int index = 1;
    for (int i = 0; i < noOfDays; i++) {
      getPerDayCases(index);

      index++;
    }
    
    Toast.show("Refreshing the content. Please wait!", context, duration: 5, gravity:  Toast.BOTTOM);


  }


  void getTotalGlobalCases() async {
    http.Response restotal = await http.get(
        'https://wuhan-coronavirus-api.laeyoung.endpoint.ainize.ai/jhu-edu/brief');
    if (restotal.statusCode == 200) {
      String data = restotal.body;

      int GlobalC = jsonDecode(data)['confirmed']; //confirmed
      int GlobalD = jsonDecode(data)['deaths']; //0.timeseries.4/1/20
      int GlobalR = jsonDecode(data)['recovered']; //0.timeseries.4/1/20

      setState(() {
        totalGlobalCases = GlobalC.toString();
        totalGlobalDeaths = GlobalD.toString();
        totalGlobalRecovered = GlobalR.toString();
      });
    } else {
      print(restotal.statusCode);
    }
  }

  void getTotalLocalCases() async {
    http.Response restotal = await http.get(
        'https://wuhan-coronavirus-api.laeyoung.endpoint.ainize.ai/jhu-edu/latest?iso2='+countryCode);
    if (restotal.statusCode == 200) {
      String data = restotal.body;

      int LocalC = jsonDecode(data)[0]['confirmed']; //0.confirmed
      int LocalD = jsonDecode(data)[0]['deaths']; //0.timeseries.4/1/20
      int LocalR = jsonDecode(data)[0]['recovered']; //0.timeseries.4/1/20

      setState(() {
        totalAreaCases = LocalC.toString();
        totalAreaDeaths = LocalD.toString();
        totalAreaRecovered = LocalR.toString();
      });
    } else {
      print(restotal.statusCode);
    }

    


  }

  void getPerDayCases(int index) async {
    http.Response resday = await http.get(
        'https://wuhan-coronavirus-api.laeyoung.endpoint.ainize.ai/jhu-edu/timeseries?iso2='+countryCode);

    if (resday.statusCode == 200) {
      String data = resday.body;
      var yesterday = DateTime.now().subtract(new Duration(days: index));
      var stryesterday =
          (yesterday.month.toString() + '/' + yesterday.day.toString() + '/20');
      // print(stryesterday);

      int totalC = jsonDecode(data)[0]['timeseries'][stryesterday]['confirmed']; //0.timeseries.4/1/20
      int totalD = jsonDecode(data)[0]['timeseries'][stryesterday]['deaths']; //0.timeseries.4/1/20
      int totalR = jsonDecode(data)[0]['timeseries'][stryesterday]['recovered']; //0.timeseries.4/1/20

      Areadetails obj = new Areadetails(yesterday.toString(), totalC.toString(),totalD.toString(), totalR.toString());
      areadetails.add(obj);

      setState(() {
        areadetails[index - 1].confirmed = totalC.toString();
        areadetails[index - 1].deaths = totalD.toString();
        areadetails[index - 1].recovered = totalR.toString();
      });
    } else {
      print(resday.statusCode);
    }
  }
}
