import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firebase/models/brew.dart';
import 'package:flutter_firebase/models/user.dart';

class DatabaseService{

  //collection reference
  final String uid;
  DatabaseService({this.uid});

  final CollectionReference brewsCollection = Firestore.instance
      .collection('brews');

  Future userUpdateData(String sugars , String name ,int strength) async {
    return await brewsCollection.document(uid).setData({
      'sugars': sugars,
      'name':name,
      'strength':strength,
    });
  }


  //get Brewlist from snapshot

  List<Brew> _brewListFromSnapShot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc) {
      return Brew(
        name: doc.data['name'] ?? "",
        strength: doc.data['strength'] ?? 0,
        sugars: doc.data['sugars'] ?? '0',
      );
    }).toList();
  }
  
  Stream<List<Brew>> get brews {
    return brewsCollection.snapshots()
        .map((_brewListFromSnapShot));
  }
  

  UserData _userDataFromSnapshot(DocumentSnapshot snapshot){
    return UserData(
      uid: uid,
      name: snapshot.data['name'],
      sugar: snapshot.data['sugars'],
      strength: snapshot.data['strength'],
    );
  }


  // get brew streams

  

  //get user doc  stream

  Stream<UserData> get userData{
    return brewsCollection.document(uid).snapshots()
        .map(_userDataFromSnapshot);
  }

}