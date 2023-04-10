import 'package:cloud_firestore/cloud_firestore.dart';

class UserData {
  final String? id;
  final String? name;
  final String? email;
  final String? photoUrl;
  final String? fcmToken;
  final Timestamp? addTime;
  final String? phoneNumber;
  final String? country;
  final String? fullName;
  final String? nin;

  UserData({
    this.id,
    this.name,
    this.email,
    this.photoUrl,
    this.fcmToken,
    this.addTime,
    this.phoneNumber,
    this.country,
    this.fullName,
    this.nin,
  });

  factory UserData.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,
      ) {
    final data = snapshot.data();
    return UserData(
      id: data?['id'],
      name: data?['name'],
      email: data?['email'],
      photoUrl: data?['photoUrl'],
      fcmToken: data?['fcmToken'],
      addTime: data?['addTime'],
      phoneNumber: data?['phoneNUmber'],
      country: data?['country'],
      fullName: data?['fullName'],
      nin: data?['nin'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (id != null) "id": id,
      if (name != null) "name": name,
      if (email != null) "email": email,
      if (photoUrl != null) "photoUrl": photoUrl,
      if (fcmToken != null) "fcmToken": fcmToken,
      if (addTime != null) "addTime": addTime,
      if (phoneNumber != null) "phoneNumber" : phoneNumber,
      if (country != null) "country" : country,
      if (fullName != null) "firstname" : fullName,
      if (nin != null) "nin": nin,
    };
  }
}

class UserLoginResponseEntity {
  String? accessToken;
  String? displayName;
  String? email;
  String? photoUrl;

  UserLoginResponseEntity({
    this.accessToken,
    this.displayName,
    this.email,
    this.photoUrl,
  });

  factory UserLoginResponseEntity.fromJson(Map<String, dynamic> json) =>
      UserLoginResponseEntity(
        accessToken: json["access_token"],
        displayName: json["display_name"],
        email: json["email"],
        photoUrl: json["photoUrl"],
      );

  Map<String, dynamic> toJson() => {
        "access_token": accessToken,
        "display_name": displayName,
        "email": email,
        "photoUrl": photoUrl,
      };
}

class MeListItem {
  String? name;
  String? icon;
  String? explain;
  String? route;


  MeListItem({
    this.name,
    this.icon,
    this.explain,
    this.route,
  });

  factory MeListItem.fromJson(Map<String, dynamic> json) =>
      MeListItem(
        name: json["name"],
        icon: json["icon"],
        explain: json["explain"],
        route: json["route"],
      );
}
