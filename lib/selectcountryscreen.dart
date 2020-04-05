import 'package:flutter/material.dart';
import 'mainscreen.dart';
import 'main.dart';

class SelectCountry extends StatefulWidget {
  @override
  _SelectCountryState createState() => _SelectCountryState();
}

class _SelectCountryState extends State<SelectCountry> {
  String icountry;

  List<DropdownMenuItem<String>> listc = [
    DropdownMenuItem(
      child: Text('Select'),
      value: 'Choose',
    ),
    DropdownMenuItem(
      child: Text('INDIA'),
      value: 'IN',
    ),
    DropdownMenuItem(
      child: Text('USA'),
      value: 'US',
    ),
    DropdownMenuItem(
      child: Text('IRAQ'),
      value: 'IQ',
    ),
    DropdownMenuItem(
      child: Text('IR'),
      value: 'IR',
    ),
    DropdownMenuItem(
      child: Text('ES'),
      value: 'ES',
    )
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      home: Scaffold(
        backgroundColor: Color(0xffd9faff),
        appBar: AppBar(
          backgroundColor: Color(0xff00204a),
          title: Text('CoronaTracker'),
        ),
        body: SingleChildScrollView(
        
                    child: Column(
            children: <Widget>[
  
              Container(
                child: Text("Choose your country: "),
                padding: EdgeInsets.only(top: 100),
              ),


              Container(
                
                padding:
                    EdgeInsets.only(top: 50, bottom: 10, left: 50, right: 50),
                child: DropdownButton<String>(
                  items: listc,
                  value: icountry,
                  hint: Text('Select'),
                  elevation: 8,
                  icon: Icon(Icons.arrow_drop_down),
                  onChanged: (String chosenvalue) {
                    setState(() {
                      this.icountry = chosenvalue;
                    }
                    );
                  },
                  // 
                ),
              ),
              
              Container(
                padding: EdgeInsets.all(20),
                child: Text("OR"),
                
              ),


              Container(
                padding: EdgeInsets.symmetric(horizontal: 100, vertical: 10),
                child: TextField(
                  onChanged: (value)=>icountry=value,
                  decoration: InputDecoration(helperText: "Press Done", labelText: "Enter country code :"),
                  cursorColor: Colors.purple,
                  maxLength: 3,
                  textAlign: TextAlign.center,
                  cursorWidth: 2,
                ),
              ),



              RaisedButton(
                color: Color(0xff00204a),
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) {
                  return MainScreen(icountry);
                })),
                child: Text("DONE",style: TextStyle(color: Colors.white),),
              ),


              Divider(
                thickness: 2,
                indent: 120,
                endIndent: 120,
                color: Colors.black,
              ),

            ],
          ),
        ),
      ),
    );
  }
}
