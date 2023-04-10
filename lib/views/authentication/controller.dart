import 'dart:io';
import 'package:artisans/common/entities/user.dart';
import 'package:artisans/common/routes/names.dart';
import 'package:artisans/common/widgets/toast_message.dart';
import 'package:artisans/views/authentication/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import '../../common/store/user.dart';
import '../../common/utils/upload.dart';

class AuthController extends GetxController {
  AuthController();
  final state = AuthState();
  final db = FirebaseFirestore.instance;

  @override
  void onInit() {
    super.onInit();
    state.phoneNumberController = TextEditingController();
    state.countryController = TextEditingController();
    state.emailController = TextEditingController();
    state.fullNameController = TextEditingController();
    state.ninController = TextEditingController();
  }

  @override
  void onClose() {
    state.phoneNumberController.dispose();
    state.countryController.dispose();
    state.emailController.dispose();
    state.fullNameController.dispose();
    state.ninController.dispose();
    super.onClose();
  }

  @override
  void onReady() {
    super.onReady();
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print("NO User");
      } else {
        print("There is user");
      }
    });
  }

  Future<void> addUserData(
    String? email,
    String displayName,
    String? photoUrl,
    String country,
    String? phoneNumber,
    String nin,
  ) async {
    try {
      state.isLoading.value = true;
      FirebaseAuth auth = FirebaseAuth.instance;
      final data = UserData(
        id: auth.currentUser!.uid,
        name: displayName,
        email: email ?? auth.currentUser?.email ?? "",
        phoneNumber: phoneNumber,
        photoUrl: photoUrl ?? auth.currentUser?.photoURL ?? "",
        addTime: Timestamp.now(),
        fcmToken: "",
        country: country,
        nin: nin,
      );

      uploadFile(auth.currentUser!.uid);

      await db
          .collection('users')
          .withConverter(
            fromFirestore: UserData.fromFirestore,
            toFirestore: (UserData userData, options) => userData.toFirestore(),
          )
          .add(data);

      UserLoginResponseEntity userProfile = UserLoginResponseEntity();
      userProfile.email = auth.currentUser?.email ?? "";
      userProfile.displayName = displayName;
      userProfile.accessToken = auth.currentUser!.uid;
      userProfile.photoUrl = photoUrl;

      UserStore.to.saveProfile(userProfile);
      Get.offAndToNamed(AppRoutes.interests);
      state.isLoading.value = false;
    } catch (e) {
      state.isLoading.value = false;
      toastMessage('An error occurred while sending your data');
    }
  }

  Future<void> verifyOtp(String otp, String verificationId) async {
    try {
      state.isLoading.value = true;
      PhoneAuthCredential credentials = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: otp,
      );
      User? user =
          (await FirebaseAuth.instance.signInWithCredential(credentials)).user;

      if (user != null) {
        String id = user.uid;

        var userBase = await db
            .collection('users')
            .withConverter(
              fromFirestore: UserData.fromFirestore,
              toFirestore: (UserData userData, options) =>
                  userData.toFirestore(),
            )
            .where("id", isEqualTo: id)
            .get();

        if (userBase.docs.isEmpty) {
          state.isLoading.value = false;
          Get.toNamed(AppRoutes.userDetails, arguments: {"photoUrl" : "", "isPhone": true});
        } else {
          state.isLoading.value = false;
          Get.toNamed(AppRoutes.interests);
        }
      }
    } on FirebaseAuthException catch (e) {
      toastMessage(e.code.replaceAll('-', ' ').capitalizeFirst!);
    }
  }

  Future<void> googleSignIn() async {
    try {
      state.isLoading.value = true;
      var user = await state.googleSignIn.signIn();
      if (user != null) {
        final gAuth = await user.authentication;
        final credentials = GoogleAuthProvider.credential(
          idToken: gAuth.idToken,
          accessToken: gAuth.accessToken,
        );

        User? currentUser =
            (await FirebaseAuth.instance.signInWithCredential(credentials))
                .user;

        String displayName = user.displayName ?? user.email;
        String id = currentUser!.uid;
        String photoUrl = user.photoUrl ?? "";

        state.fullNameController.text = displayName;

        var userBase = await db
            .collection('users')
            .withConverter(
              fromFirestore: UserData.fromFirestore,
              toFirestore: (UserData userData, options) =>
                  userData.toFirestore(),
            )
            .where("id", isEqualTo: id)
            .get();

        if (userBase.docs.isEmpty) {
          Get.toNamed(AppRoutes.userDetails, arguments: {
            "photoUrl": photoUrl, "isPhone": false
          });
          state.isLoading.value = false;
        } else {
          state.isLoading.value = false;
          Get.toNamed(AppRoutes.interests);
        }
      }
    } on FirebaseAuthException catch (e) {
      state.isLoading.value = false;
      toastMessage(e.code.replaceAll('-', ' ').capitalizeFirst!);
    } catch (e) {
      state.isLoading.value = false;
      if (kDebugMode) {
        print(e);
      }
      return;
    }
  }

  Future<void> phoneSignIn(String phoneNumber) async {
    try {
      state.isLoading.value = true;
      FirebaseAuth auth = FirebaseAuth.instance;
      await auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential phoneAuthCredential) async {
          await auth.signInWithCredential(phoneAuthCredential);
        },
        verificationFailed: (FirebaseAuthException e) {
          toastMessage(e.code.replaceAll('-', ' ').capitalizeFirst!);
        },
        codeSent: (verificationId, forceResendingToken) {
          Get.to(
            () => OtpScreen(
              verificationId: verificationId,
            ),
            transition: Transition.rightToLeft,
          );
        },
        codeAutoRetrievalTimeout: (verificationId) {},
      );
      state.isLoading.value = false;
    } on FirebaseAuthException catch (e) {
      state.isLoading.value = false;
      toastMessage(e.code.replaceAll('-', ' ').capitalizeFirst!);
    } catch (e) {
      state.isLoading.value = false;
      return;
    }
  }

  Future imgFromGallery() async {
    try {
      final pickedFile =
          await state.picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        state.photo = File(pickedFile.path);
        state.photoPicked.value = true;
        update();
      } else {
        state.photoPicked.value = false;
        return;
      }
    } catch (e) {
      return;
    }
  }

  Future uploadFile(String uid) async {
    if (state.photo == null) {
      return;
    }
    try {
      if (state.photo != null) {
        final fileName = basename(state.photo!.path);
        final destination = 'images/$uid/$fileName';
        state.task = FirebaseApi.uploadFile(destination, state.photo!);
        if (state.task == null) {
          return;
        } else {
          try {
            final snapShot = await state.task!.whenComplete(() {});
            final urlDownload = await snapShot.ref.getDownloadURL();
            await FirebaseAuth.instance.currentUser!
                .updatePhotoURL(urlDownload);
            state.urlDownload.value = urlDownload;
            update();
          } on FirebaseException catch (e) {
            return;
          } catch (e) {
            return;
          }
        }
        update();
      }
    } catch (e) {
      return;
    }
  }
}
