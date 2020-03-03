import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "Exploring Widg",
    home: SIForm(),
    theme: ThemeData(
      primaryColor:Colors.lightBlue,
      accentColor:Colors.amberAccent
    ),
  ));
}

class SIForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SIFormState();
  }
}

class _SIFormState extends State<SIForm> {
  
  var _currencies = ['Rupees', 'dollars'];
  var _currentItemSelected="Rupees";
  final _minimumpad = 5.0;

  var dipText='';

  TextEditingController principalControl=TextEditingController();
  TextEditingController roiControl=TextEditingController();
  TextEditingController termControl=TextEditingController();

  @override
  Widget build(BuildContext context) {

    TextStyle textStyle=Theme.of(context).textTheme.title;
    return Scaffold(
      // resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          title: Text("Stateful app"),
        ),
        body: Form(
          // margin: EdgeInsets.all(_minimumpad * 2),
          child: ListView(children: <Widget>[
            getImageAsset(),
            myTxtFild("Principle",textStyle,principalControl),
            myTxtFild("Rate of Interest",textStyle,roiControl),
            Row(
              children: <Widget>[
                // txtFildNopad('tem'),
                Expanded(child: txtFildNopad("term")),
                Expanded(child: myDrop()),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: _minimumpad, bottom: _minimumpad),
              child:
                  Row(children: <Widget>[mybtn("Calculate"),myText(" ", textStyle), mybtn("Reset")]),
            ),

            myText(dipText,textStyle)

          ]),
        ));
  }

  Widget getImageAsset() {
    AssetImage asseti = AssetImage("images/s1.png");
    Image imag = Image(
      image: asseti,
      width: 125.0,
      height: 125.0,
    );

    return Container(
      child: imag,
      margin: EdgeInsets.all(_minimumpad * 10.0),
    );
  }

  Widget myTxtFild(String lbltxt,TextStyle stl,TextEditingController ctr) {
    return Padding(
        padding: EdgeInsets.only(top: _minimumpad, bottom: _minimumpad,left:_minimumpad,right:_minimumpad),
        child: TextField(
          style: stl,
          controller: ctr,
            decoration: InputDecoration(
          labelText: lbltxt,
          hintText: "Enter",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
        )));
  }

  Widget txtFildNopad(String lbltxt) {
    return TextField(
      controller: termControl,
        decoration: InputDecoration(
      labelText: lbltxt,
      hintText: "Enter",
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
    ));
  }

  Widget myDrop() {
    return DropdownButton<String>(
      items: _currencies.map((String value) {
        return DropdownMenuItem<String>(
          child: Text(value),
        );
      }).toList(),
      value: null,
      onChanged: (String newValSelect) {
        _onDropDownItemSelected(newValSelect);
      },
    );
  }

  Widget mybtn(String act) {
    return Expanded(child: RaisedButton(
      color: Colors.lightBlue,
      child: Text(act), onPressed: () {
        setState(() {
          this.dipText=_calcReturn();
        });
      }));
  }

  Widget myText(String any,TextStyle stl){
    return Padding(padding: EdgeInsets.all(_minimumpad*2),
    child: Text(any,
    style:stl),);
  }
  void _onDropDownItemSelected(String newValSelect){
    setState(() {
      this._currentItemSelected=newValSelect;
    });
  }

  String _calcReturn(){
    double principal=double.parse(principalControl.text);
    double roi=double.parse(roiControl.text);
    double term = double.parse(termControl.text);

    double totalamnt=principal+(principal*roi*term)/100;

    String result='After $term it will be $totalamnt $_currentItemSelected';
    return result;
  }
}
