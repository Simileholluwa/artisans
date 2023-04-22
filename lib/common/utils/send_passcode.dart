import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../entities/user.dart';
import '../routes/names.dart';
import '../store/config.dart';
import '../widgets/toast_message.dart';

Future<void> sendPasscode (String code) async {
  try {
    toastMessage('Setting up passcode...');
    FirebaseAuth auth = FirebaseAuth.instance;
    String id = auth.currentUser!.uid;
    final data = UserData(
      passCode: code,
    );
    final docRef = FirebaseFirestore.instance
        .collection('users')
        .withConverter(
      fromFirestore: UserData.fromFirestore,
      toFirestore: (UserData userData, options) => userData.toFirestore(),
    ).doc(id);
    await docRef.set(data, SetOptions(merge: true));
    toastMessage('Passcode set');
    ConfigStore.to.savePasscodeSet();
    Get.offAllNamed(AppRoutes.mainApp);
  } catch (e){
    toastMessage('Please try again');
    return;
  }
}