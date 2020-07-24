import 'package:flutter/material.dart';
import 'package:flutter_firebase/models/user.dart';
import 'package:flutter_firebase/screens/home/home.dart';
import 'package:flutter_firebase/screens/authencation/authentication.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);
    print(user);
    // return auth or home
    if(user==null){
      return Authenticate();
    }else{
      return Home();
    }
  }
}
