import 'package:flutter/material.dart';

class LoginOptions extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const LoginOptions({Key? key, required this.icon, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      borderRadius: BorderRadius.circular(15),
      child: InkWell(
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
            color: Colors.blue,
            size: 30,
          ),
        ),
      ),
    );
  }
}
