import 'package:flutter/material.dart';

class NumberedContainer extends StatelessWidget {
  final bool? isActive;
  final String text;
  const NumberedContainer({Key? key, this.isActive = false, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      width: 20,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive == true ? Colors.pinkAccent : Theme.of(context).canvasColor,
      ),
      child: Center(
        child: Text(
          text,
          style: Theme.of(context).textTheme.labelLarge!.copyWith(
          color: isActive == true ? Colors.white : Colors.grey,
            fontSize: 12
          ),
        ),
      ),
    );
  }
}
