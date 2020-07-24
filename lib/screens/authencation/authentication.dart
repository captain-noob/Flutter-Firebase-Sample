import 'package:flutter/material.dart';
import 'package:flutter_firebase/screens/authencation/sign_in.dart';
import 'package:flutter_firebase/screens/authencation/register.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => new _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignin = true;

  void toggleView(){
    setState(() {
      showSignin = !showSignin;
    });
  }

  @override
  Widget build(BuildContext context) {
   if(showSignin){
     return Signin(toogleView:toggleView);
   }else{
     return Register(toogleView:toggleView);
   }
  }
}
