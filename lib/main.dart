import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "SI calculator",
    home: SIForm(),
    theme: ThemeData(
        primaryColor: Colors.indigo,
        brightness: Brightness.dark,
        accentColor: Colors.indigo),
  ));
}

class SIForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SIFormState();
  }
}

class _SIFormState extends State {
  var _currencies = ['rupees', 'pounds', 'dollars'];
  var _currentItemSelected = '';
  String display_result = '';
  var _formkey = GlobalKey<FormState>();

  TextEditingController principalController = new TextEditingController();
  TextEditingController rateController = new TextEditingController();
  TextEditingController timeController = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _currentItemSelected = _currencies[0];
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    TextStyle textStyle = Theme.of(context).textTheme.title;
    return Scaffold(
      //resizeToAvoidBottomPadding: false,/*if i am not using column inside container*/
      appBar: AppBar(
        title: Text("SI calculator"),
      ),
      body: Form(
        key: _formkey,
        child: Padding(
            padding: EdgeInsets.all(10.0),
            child: ListView(
              children: <Widget>[
                getImage(),
                Padding(
                  padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    style: textStyle,
                    controller: principalController,
                    validator: (String val) {
                      if (val.isEmpty) {
                        return 'Please enter principle amount';
                      }
                    },
                    decoration: InputDecoration(
                        labelText: 'Principle',
                        labelStyle: textStyle,
                        errorStyle: TextStyle(
                            color: Colors.yellowAccent, fontSize: 15.0),
                        hintText: 'Enter principle like 12000',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    style: textStyle,
                    controller: rateController,
                    validator: (String val) {
                      if (val.isEmpty) {
                        return 'Please enter Rate';
                      }
                    },
                    decoration: InputDecoration(
                        labelText: 'Rate of Interest',
                        labelStyle: textStyle,
                        errorStyle: TextStyle(
                            color: Colors.yellowAccent, fontSize: 15.0),
                        hintText: 'In percent',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                  ),
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        style: textStyle,
                        controller: timeController,
                        validator: (String val) {
                          if (val.isEmpty) {
                            return 'Please enter time';
                          }
                        },
                        decoration: InputDecoration(
                            labelText: 'Term',
                            labelStyle: textStyle,
                            errorStyle: TextStyle(
                                color: Colors.yellowAccent, fontSize: 15.0),
                            hintText: 'Time in years',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                      ),
                    ),
                    Container(
                      width: 5.0,
                    ),
                    Expanded(
                      child: DropdownButton<String>(
                          items: _currencies.map((String dropDownStringItem) {
                            return DropdownMenuItem<String>(
                              value: dropDownStringItem,
                              child: Text(dropDownStringItem, style: textStyle),
                            );
                          }).toList(),
                          onChanged: (String newValueSelected) {
                            // Your code to execute, when a menu item is selected from drop down
                            _onDropDownItemSelected(newValueSelected);
                          },
                          value: _currentItemSelected),
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: RaisedButton(
                            textColor: Theme.of(context).accentColor,
                            color: Theme.of(context).primaryColorDark,
                            child: Text(
                              "Calculate",
                              textScaleFactor: 1.5,
                            ),
                            onPressed: () {
                              setState(() {
                                if (_formkey.currentState.validate()) {
                                  this.display_result =
                                      _calculateTotalReturns();
                                }
                              });
                            }),
                      ),
                      Expanded(
                        child: RaisedButton(
                            textColor: Theme.of(context).primaryColorDark,
                            color: Theme.of(context).primaryColorLight,
                            child: Text("Reset", textScaleFactor: 1.5),
                            onPressed: () {
                              setState(() {
                                _reset();
                              });
                            }),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(2.0),
                  child: Text(this.display_result, style: textStyle),
                )
              ],
            )),
      ),
    );
  }

  Widget getImage() {
    AssetImage assetImage = new AssetImage('assets/images/images.png');
    Image image = new Image(image: assetImage, width: 285.0, height: 285.0);
    return Container(child: image);
  }

  void _onDropDownItemSelected(String newValueSelected) {
    setState(() {
      this._currentItemSelected = newValueSelected;
    });
  }

  String _calculateTotalReturns() {
    double principle = double.parse(principalController.text);
    double rate = double.parse(rateController.text);
    double time = double.parse(timeController.text);

    double si = (principle * rate * time) / 100;
    double total_amt_payable = principle + si;
    String result =
        "After $time years, your investment worth is $total_amt_payable$_currentItemSelected";
    return result;
  }

  void _reset() {
    principalController.text = '';
    rateController.text = '';
    timeController.text = '';
    _currentItemSelected = _currencies[0];
  }
}
