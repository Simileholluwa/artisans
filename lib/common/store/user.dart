import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../entities/user.dart';
import '../services/services.dart';
import '../values/values.dart';

class UserStore extends GetxController {
  static UserStore get to => Get.find();

  final _isLogin = false.obs;
  String token = '';
  final _profile = UserLoginResponseEntity().obs;
  late FirebaseAuth _auth;
  final _user = Rxn<User>();
  late Stream<User?> _authStateChanges;

  bool get isLogin => _isLogin.value;
  UserLoginResponseEntity get profile => _profile.value;
  bool get hasToken => token.isNotEmpty;
  Rxn<User> get user => _user;

  @override
  Future<void> onInit() async {
    super.onInit();
    token = StorageService.to.getString(storageUserTokenKey);
    var profileOffline = StorageService.to.getString(storageUserProfileKey);
    if (profileOffline.isNotEmpty) {
      _isLogin.value = true;
      _profile(UserLoginResponseEntity.fromJson(jsonDecode(profileOffline)));
    }
    _auth = FirebaseAuth.instance;
    _authStateChanges = _auth.authStateChanges();
    _authStateChanges.listen((User? user) {
      _user.value = user;
    });
  }

  Future<void> setToken(String value) async {
    await StorageService.to.setString(storageUserTokenKey, value);
    token = value;
  }

  Future<String> getProfile() async {
    if (token.isEmpty) return "";
   return StorageService.to.getString(storageUserProfileKey);
  }

  Future<void> saveProfile(UserLoginResponseEntity profile) async {
    _isLogin.value = true;
    StorageService.to.setString(storageUserProfileKey, jsonEncode(profile));
    setToken(profile.accessToken!);
  }

  Future<void> onLogout() async {
    await StorageService.to.remove(storageUserTokenKey);
    await StorageService.to.remove('userPasscode');
    await StorageService.to.remove(storageUserProfileKey);
    _isLogin.value = false;
    token = '';
    if (_user.value != null) {
      await FirebaseAuth.instance.signOut();
    }
  }
}
