import 'package:flutter/material.dart';
import 'package:flutter_firebase/service/auth.dart';
//import 'package:flutter_firebase/screens/authencation/register.dart';
import 'package:flutter_firebase/shared/constants.dart';
import 'package:flutter_firebase/shared/loading.dart';



class Signin extends StatefulWidget {

  final Function toogleView;
  Signin({this.toogleView});

  @override
  _SigninState createState() => new _SigninState();
}

class _SigninState extends State<Signin> {

  final AuthService _auth = AuthService();
  final _formkey = GlobalKey<FormState>();
  bool loading =false;


  String error ="";

  //input feild state

  String email ="";
  String password="";

  @override
  Widget build(BuildContext context) {
    if (loading == true) {
      return Loading();
    } else {
      return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text("SIGN IN TO APP"),
        actions: <Widget>[
          FlatButton.icon(onPressed: (){
            widget.toogleView();
          } ,
              icon: Icon(Icons.person),
              label: Text("Register")
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Padding(padding: EdgeInsets.symmetric(vertical: 20,horizontal: 50),
            child: Form(
              key:_formkey,
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
                          dynamic result = await _auth.signInWithEmailandPassword(email, password);
                          if(result == null){
                            setState(() {
                              error = "Check your Email And Password";
                              loading=false;
                            });
                          }
                        }
                      },
                      color: Colors.pink[400],
                      child: Text("Sign in",
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
