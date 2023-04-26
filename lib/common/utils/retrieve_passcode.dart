import 'package:artisans/common/services/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<String>? retrievePasscode() {
  try {
    FirebaseAuth auth = FirebaseAuth.instance;
    String id = auth.currentUser!.uid;
    return FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .get().then((DocumentSnapshot documentSnapshot) {
      if(documentSnapshot.exists) {
        StorageService.to.setString('userPasscode', documentSnapshot.get('passCode'));
        return documentSnapshot.get('passCode');
        } else {
          return '';
        }
    });
  } catch (e) {
    return null;
  }
}