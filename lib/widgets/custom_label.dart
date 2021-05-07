import 'package:flutter/material.dart';


class CustomLabel extends StatelessWidget {

  final String route;
  final String primaryText;
  final String secondaryText;

  const CustomLabel({
    Key key, 
    @required this.route,
    @required this.primaryText, 
    @required this.secondaryText,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Text( this.primaryText, style: TextStyle( color: Colors.black54, fontSize: 15, fontWeight: FontWeight.w400)),
          SizedBox( height: 10 ),
          GestureDetector(
            child: Text( this.secondaryText, style: TextStyle( color: Colors.blue[600], fontSize: 18, fontWeight: FontWeight.bold)),
            onTap: (){
              Navigator.pushReplacementNamed(context, this.route );
            },
          )
        ]
      ),
    );
  }
}