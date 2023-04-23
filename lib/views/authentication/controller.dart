import 'dart:io';
import 'package:artisans/common/entities/entities.dart';
import 'package:artisans/common/routes/routes.dart';
import 'package:artisans/common/store/store.dart';
import 'package:artisans/common/widgets/widgets.dart';
import 'package:artisans/views/authentication/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:path/path.dart';
import 'package:pinput/pinput.dart';
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
    state.pinController = TextEditingController();
  }

  @override
  void onClose() {
    state.phoneNumberController.dispose();
    state.countryController.dispose();
    state.emailController.dispose();
    state.fullNameController.dispose();
    state.ninController.dispose();
    state.username.clear();
    state.pinController.dispose();
    super.onClose();
  }

  @override
  void onReady() {
    super.onReady();
    state.auth = FirebaseAuth.instance;
    state.authStateChanges = state.auth.authStateChanges();
    state.authStateChanges.listen((User? user) {
      state.user.value = user;
    });
    getAllUsernames();
  }

  Future<void> getAllUsernames() async {
    try {
      return db.collection('users').get().then((QuerySnapshot snapshots) {
        if (snapshots.docs.isNotEmpty) {
          snapshots.docs.forEach((doc) {
            state.username.add(doc["artisanID"]);
          });
        }
      });
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  Future<QuerySnapshot<UserData>> findAField(
      String field, String fieldName) async {
    return db
        .collection('users')
        .withConverter(
          fromFirestore: UserData.fromFirestore,
          toFirestore: (UserData userData, options) => userData.toFirestore(),
        )
        .where(field, isEqualTo: fieldName)
        .get();
  }

  Future<bool?> findANullField(String field) async {
    try {
      return db
          .collection('users')
          .doc(state.user.value?.uid)
          .get()
          .then((DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          if (documentSnapshot.get(field) == null) {
            return true;
          } else {
            return false;
          }
        } else {
          return false;
        }
      });
    } catch (e) {
      return false;
    }
  }

  Future<void> addPrimaryData(
      String id, String email, String phoneNumber, String country) async {
    final data = UserData(
        id: id,
        email: email,
        phoneNumber: phoneNumber,
        country: country,
        photoUrl: null,
        artisanID: null,
        passCode: null,
    );
    await db
        .collection('users')
        .withConverter(
          fromFirestore: UserData.fromFirestore,
          toFirestore: (UserData userData, options) => userData.toFirestore(),
        )
        .doc(id)
        .set(data, SetOptions(merge: true));
  }

  Future<void> addSecondaryData(
    String artisanID,
  ) async {
    try {
      state.isLoading.value = true;
      FirebaseAuth auth = FirebaseAuth.instance;
      String id = auth.currentUser!.uid;
      String photoUrl = await uploadFile(id);

      final data = UserData(
        artisanID: artisanID,
        photoUrl: photoUrl,
      );

      await auth.currentUser!.updateDisplayName(artisanID);
      final docRef = db
          .collection('users')
          .withConverter(
            fromFirestore: UserData.fromFirestore,
            toFirestore: (UserData userData, options) => userData.toFirestore(),
          )
          .doc(id);
      await docRef.set(data, SetOptions(merge: true));

      UserLoginResponseEntity userProfile = UserLoginResponseEntity();
      userProfile.accessToken = auth.currentUser!.uid;
      userProfile.photoUrl = photoUrl;
      userProfile.email = auth.currentUser!.email;
      userProfile.displayName = artisanID;

      UserStore.to.saveProfile(userProfile);

      state.isLoading.value = false;
      toastMessage('Your profile photo has been uploaded.');
      Get.offAllNamed(AppRoutes.passcode);
    } catch (e) {
      state.isLoading.value = false;
      toastMessage('Unable to upload. Please try again.');
      return;
    }
  }

  Future<void> verifyOtp(
      String otp, String verificationId, String phoneNumber) async {
    try {
      state.isLoading.value = true;
      PhoneAuthCredential credentials = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: otp,
      );

      User? user =
          (await FirebaseAuth.instance.signInWithCredential(credentials)).user;

      var primaryBase = await findAField("phoneNumber", phoneNumber);
      bool photoIsNull = await findANullField('photoUrl') ?? false;
      bool passCodeIsNull = await findANullField('passCode') ?? false;

      if (user != null) {
        if (primaryBase.docs.isEmpty) {
          state.isLoading.value = false;
          Get.toNamed(AppRoutes.emailAddress);
        } else if (photoIsNull == true) {
          state.isLoading.value = false;
          Get.offAndToNamed(AppRoutes.artisanID);
        } else if(passCodeIsNull == false && ConfigStore.to.passcodeSet == false){
          state.isLoading.value = false;
          ConfigStore.to.savePasscodeSet();
          Get.offAllNamed(AppRoutes.unlock);
        } else {
          state.isLoading.value = false;
          Get.offAllNamed(AppRoutes.unlock);
        }
      }
      state.isLoading.value = false;
    } on FirebaseAuthException catch (e) {
      state.isLoading.value = false;
      toastMessage(e.code.replaceAll('-', ' ').capitalizeFirst!);
    } catch (e) {
      state.isLoading.value = false;
    }
  }

  Future<void> verifyAndLinkEmail(
      String email, bool navigate, AuthCredential credential) async {
    try {
      state.isLoading.value = true;
      FirebaseAuth auth = FirebaseAuth.instance;
      await auth.currentUser!.linkWithCredential(credential);
      await auth.currentUser!.updateEmail(email);
      await addPrimaryData(auth.currentUser!.uid, auth.currentUser!.email!,
          auth.currentUser!.phoneNumber!, state.countries.value.name);
      await auth.currentUser!.sendEmailVerification();

      toastMessage('Email verification link sent');
      if (navigate) {
        Get.offAndToNamed(AppRoutes.artisanID);
      }
      state.isLoading.value = false;
    } on FirebaseAuthException catch (e) {
      state.isLoading.value = false;
      if (e.code == "provider-already-linked") {
        toastMessage('A user with the phone number already exist');
      } else if (e.code == "email-already-exist") {
        toastMessage('A user with the email already exist');
      } else {
        toastMessage(e.code.replaceAll('-', ' ').capitalizeFirst!);
      }
    }
  }

  Future<void> phoneSignIn(String phoneNumber) async {
    try {
      state.isLoading.value = true;
      FirebaseAuth auth = FirebaseAuth.instance;
      await auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential phoneAuthCredential) async {
          state.pinController.setText(phoneAuthCredential.smsCode!);
          await auth.signInWithCredential(phoneAuthCredential);
        },
        verificationFailed: (FirebaseAuthException e) {
          state.isLoading.value = false;
          toastMessage(e.code.replaceAll('-', ' ').capitalizeFirst!);
        },
        codeSent: (verificationId, forceResendingToken) {
          state.isLoading.value = false;
          Get.to(
            () => OtpScreen(
              verificationId: verificationId,
            ),
            transition: Transition.rightToLeft,
          );
        },
        codeAutoRetrievalTimeout: (verificationId) {},
      );
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

  Future<String> uploadFile(String uid) async {
    var photoUrl = '';
    if (state.photo == null) {
      return '';
    }
    try {
      if (state.photo != null) {
        final fileName = basename(state.photo!.path);
        final destination = 'images/$uid/$fileName';
        state.task = FirebaseApi.uploadFile(destination, state.photo!);
        if (state.task == null) {
          return '';
        } else {
          try {
            final snapShot = await state.task!.whenComplete(() {});
            final urlDownload = await snapShot.ref.getDownloadURL();
            await FirebaseAuth.instance.currentUser!
                .updatePhotoURL(urlDownload);
            photoUrl = urlDownload;
          } on FirebaseException catch (e) {
            return '';
          } catch (e) {
            return '';
          }
        }
      }
    } catch (e) {
      return '';
    }
    return photoUrl;
  }

  void updateProfileImageAndName() async {
    await Sheet.updateDetailsDialog(
      title: "Add a profile image",
      content: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 20.0,
              left: 20,
              right: 20,
              bottom: 40,
            ),
            child: Center(
              child: Text(
                'Select an image that clearly shows your face. This makes you easily identifiable by potential customers or sellers.',
                style: GoogleFonts.poppins(
                  fontSize: 17,
                  fontWeight: FontWeight.w100,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          GetBuilder<AuthController>(
            builder: (_) {
              return Material(
                type: MaterialType.transparency,
                borderRadius: BorderRadius.circular(75),
                child: InkWell(
                  onTap: () {
                    imgFromGallery();
                  },
                  borderRadius: BorderRadius.circular(125),
                  child: Ink(
                    height: 250,
                    width: 250,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(Get.context!).cardColor,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(120),
                      child: state.photoPicked.isFalse
                          ? Image.network(
                              "",
                              fit: BoxFit.cover,
                              errorBuilder: (context, exception, starkTrace) {
                                return Icon(
                                  CupertinoIcons.person_alt_circle,
                                  size: 250,
                                  color: Theme.of(context).hintColor,
                                );
                              },
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                if (loadingProgress == null) {
                                  return child;
                                }
                                return Center(
                                  child: LoadingAnimationWidget.prograssiveDots(
                                    color: Colors.blue.shade800,
                                    size: 50,
                                  ),
                                );
                              },
                            )
                          : Image.file(
                              state.photo!,
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Obx(
              () => AppButton(
                onTap: state.isLoading.isTrue
                    ? () {}
                    : () {
                        if (state.photo != null &&
                            state.fullNameController.text.isNotEmpty) {
                          addSecondaryData(
                              state.fullNameController.text.trim().capitalize!);
                        } else {
                          toastMessage('Click on the icon to pick an image');
                        }
                      },
                icon: Icons.arrow_forward,
                text: 'Continue',
                textColor: Colors.white,
                iconColor: Colors.white,
                isLoading: state.isLoading.isFalse ? false : true,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
