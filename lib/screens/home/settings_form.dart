import 'package:flutter/material.dart';
import 'package:flutter_firebase/models/user.dart';
import 'package:flutter_firebase/service/database.dart';
import 'package:flutter_firebase/shared/constants.dart';
import 'package:flutter_firebase/shared/loading.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => new _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {

  final _formkey =GlobalKey<FormState>();
  final List<String> sugar = ['0','1','2','3','4'];

  String _currentName;
  String _currentSugars;
  int _currentStrength;



  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid ).userData,
      builder: (context, snapshot) {
        if(snapshot.hasData){

          UserData userData=snapshot.data;
          return Form(
            key: _formkey,
            child: Column(
              children: <Widget>[

                Text(
                  "Update Your Settings",
                  style: TextStyle(fontSize: 18),
                ),

                SizedBox(height: 20,),

                TextFormField(
                  initialValue: userData.name,
                  decoration: textInputDecoration,
                  validator: (val) => val.isEmpty ? 'Please Enter a Name' :null,
                  onChanged: (val) =>  setState(() => _currentName=val),
                ),

                SizedBox(height: 20,),

                //dropdown

                DropdownButtonFormField(
                  decoration: textInputDecoration,
                  value: _currentSugars ?? userData.sugar,
                  items: sugar.map((e) {
                    return DropdownMenuItem(
                      value: e,
                      child: Text('$e Sugars'),
                    );
                  }).toList(),
                  onChanged: (val)  {
                    setState(() {
                      _currentSugars=val;
                    });
                  },
                ),

                SizedBox(height: 20,),

                //slider

                Slider(min: 100,
                  max: 900,
                  divisions: 8,
                  value: (_currentStrength??userData.strength).toDouble(),
                  activeColor: Colors.brown[_currentStrength??userData.strength],
                  inactiveColor: Colors.brown[_currentStrength??userData.strength],
                  onChanged: (val) {
                    setState(() {
                      _currentStrength=val.round();
                    });
                  },
                ),

                SizedBox(height: 20,),
                RaisedButton(onPressed: ()async{
                  if(_formkey.currentState.validate()){
                    await DatabaseService(uid: user.uid)
                        .userUpdateData(
                          _currentSugars?? userData.sugar,
                          _currentName?? userData.name,
                          _currentStrength ?? userData.strength,
                         );
                    Navigator.pop(context);
                  }
                },
                  color: Colors.pink[400],
                  child: Text("Update",
                    style: TextStyle(color: Colors.white),
                  ),
                ),



              ],
            ),
          );

        }else{
          return Loading();
        }
      },
    );
  }
}
