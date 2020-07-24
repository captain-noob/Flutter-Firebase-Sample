import 'package:flutter/material.dart';
import 'package:flutter_firebase/service/auth.dart';
import 'package:flutter_firebase/shared/constants.dart';
import 'package:flutter_firebase/shared/loading.dart';

class Register extends StatefulWidget {

  final Function toogleView;
  Register({this.toogleView});

  @override
  _RegisterState createState() => new _RegisterState();
}

class _RegisterState extends State<Register> {


  final AuthService _auth = AuthService();
  final _formkey= GlobalKey<FormState>();
  bool loading = false;
  String email ="";
  String password="";
  String error ="";


  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Loading();
    } else {
      return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text("SIGN UP TO APP"),
        actions: <Widget>[
          FlatButton.icon(onPressed: (){
              widget.toogleView();
            } ,
              icon: Icon(Icons.person),
              label: Text("Sign in")
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Padding(padding: EdgeInsets.symmetric(vertical: 20,horizontal: 50),
            child: Form(
              key: _formkey,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 20,),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(hintText:"Email"),
                    validator: (val)=> val.isEmpty ? "Enter an Email" :null,
                    onChanged: (val){
                      setState(() {
                        email=val;
                      });
                    },
                  ),
                  SizedBox(height: 20,),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(hintText:"Password"),
                    validator: (val)=> val.length < 6 ? "Password Must Have 6+ Chars" :null,
                    obscureText: true,
                    onChanged: (val){
                      setState(() {
                        password=val;
                      });
                    },
                  ),
                  SizedBox(height: 20,),
                  RaisedButton(
                    onPressed: ()async{
                      if(_formkey.currentState.validate()){
                        setState(() {
                          loading=true;
                        });
                        dynamic result = await _auth.registerWithEmailandPassword(email, password);
                        if(result == null){
                          setState(() {
                            error = "Error in Creating Valid user";
                            loading=false;
                          });
                        }
                      }
                    },
                    color: Colors.pink[400],
                    child: Text("Register",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  Text(
                    error,
                    style: TextStyle(
                      color: Colors.redAccent,
                      fontSize: 14,
                    ),
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
    }
  }
}
