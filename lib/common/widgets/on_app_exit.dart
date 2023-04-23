import 'package:artisans/common/widgets/toast_message.dart';
import 'package:flutter/cupertino.dart';

class OnAppExit extends StatelessWidget {
  final Widget child;
  const OnAppExit({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime _lastExitTime = DateTime.now();
    return WillPopScope(
        onWillPop: () async {
          if (DateTime.now().difference(_lastExitTime) >=
              const Duration(seconds: 2)) {
            toastMessage(
              'Press the back button again to exit app.',
            );
            _lastExitTime = DateTime.now();
            return false;
          } else {
            return true;
          }
        },
        child: child,
    );
  }
}
