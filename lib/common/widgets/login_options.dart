import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoginOptions extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final bool isLoading;
  const LoginOptions(
      {Key? key,
      required this.icon,
      required this.onTap,
      this.isLoading = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      borderRadius: BorderRadius.circular(15),
      child: isLoading == false
          ? InkWell(
              splashColor: Colors.white.withOpacity(.2),
              onTap: onTap,
              borderRadius: BorderRadius.circular(15),
              child: Ink(
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                  color: Theme.of(context).canvasColor,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Icon(
                  icon,
                  color: Colors.blue.shade800,
                  size: 30,
                ),
              ),
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LoadingAnimationWidget.fourRotatingDots(
                    color: Theme.of(context).iconTheme.color!, size: 40,),
              ],
            ),
    );
  }
}
