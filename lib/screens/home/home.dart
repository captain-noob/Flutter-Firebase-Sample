import 'package:flutter/material.dart';
import 'package:flutter_firebase/service/auth.dart';
import 'package:provider/provider.dart';
import 'package:flutter_firebase/service/database.dart';
import 'package:flutter_firebase/screens/home/brew_list.dart';
import 'package:flutter_firebase/models/brew.dart';
import 'package:flutter_firebase/screens/home/settings_form.dart';


class Home extends StatelessWidget {
  final AuthService _auth = AuthService();


  @override
  Widget build(BuildContext context) {
    void _showSettingsPannel(){
      showModalBottomSheet(context: context, builder: (context){
        return Container(
          child: Padding(padding: EdgeInsets.symmetric(vertical: 20,horizontal: 60),
            child: SettingsForm(),
          ), 
        );
      }
      ,);}
    return StreamProvider<List<Brew>>.value(
      value: DatabaseService().brews,
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text("Brew crew"),
          backgroundColor: Colors.brown[400],
          elevation: 0,
          actions: <Widget>[
            FlatButton.icon(
              onPressed: () => _showSettingsPannel(),
              // ignore: not_enough_positional_arguments
              icon: Icon(
                Icons.settings,
              ),
              label: Text("Settings"),
            ),

            FlatButton.icon(
                onPressed: () async{
                  await _auth.signOut();
                  },
                icon: Icon(Icons.person),
                label: Text("Logout")
              ),

          ],
        ),
    body: Container(
          decoration: BoxDecoration(color: Colors.brown[300]),
          child: BrewList()
      ),
      ),
    );
  }
}
