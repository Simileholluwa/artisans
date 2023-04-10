import 'dart:io';
import 'package:country_picker/country_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';

class AuthState {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> formKeyUser = GlobalKey<FormState>();
  late TextEditingController phoneNumberController, countryController, emailController, fullNameController, ninController;
  File? photo;
  RxBool photoPicked = false.obs;
  final ImagePicker picker = ImagePicker();
  UploadTask? task;
  var urlDownload = ''.obs;
  RxString otpCode = ''.obs;
  RxBool isLoading = false.obs;
  //UserLoginResponseEntity user = UserLoginResponseEntity.fromJson(jsonDecode(StorageService.to.getString(STORAGE_USER_PROFILE_KEY)));

  Rx<Country> countries = Country(
      phoneCode: "234",
      countryCode: "NG",
      e164Sc: 0,
      geographic: true,
      level: 1,
      name: "Nigeria",
      example: "Nigeria",
      displayName: "Nigeria",
      displayNameNoCountryCode: "NG",
      e164Key: "",
  ).obs;

  GoogleSignIn googleSignIn = GoogleSignIn(
    scopes: <String>[
      'openid'
    ]
  );

}