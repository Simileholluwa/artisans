import 'package:fluttertoast/fluttertoast.dart';

Future<bool?> toastMessage(String msg) {
  return Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      timeInSecForIosWeb: 1,
      fontSize: 10,
    );
}
