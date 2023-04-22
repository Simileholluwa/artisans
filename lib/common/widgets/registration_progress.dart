import 'package:flutter/material.dart';

import 'numbered_container.dart';

class RegProgress extends StatelessWidget {
  final String text1;
  final String text2;
  final String text3;
  final String text4;
  final String text5;
  final bool? isActive1;
  final bool? isActive2;
  final bool? isActive3;
  final bool? isActive4;
  final bool? isActive5;
  const RegProgress({
    Key? key,
    this.text1 = "1",
    this.text2 = "2",
    this.text3 = "3",
    this.text4 = "4",
    this.text5 = "5",
    this.isActive1 = false,
    this.isActive2 = false,
    this.isActive4 = false,
    this.isActive3 = false,
    this.isActive5 = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        NumberedContainer(
          text: text1,
          isActive: isActive1,
        ),
        const SizedBox(
          width: 5,
        ),
        SizedBox(
            height: 2,
            child: VerticalDivider(
              thickness: 50,
              width: 50,
              color: isActive1 == true ? Colors.pinkAccent : Theme.of(context).dividerColor,
            )),
        const SizedBox(
          width: 5,
        ),
        NumberedContainer(
          text: text2,
          isActive: isActive2,
        ),
        const SizedBox(
          width: 5,
        ),
        SizedBox(
            height: 2,
            child: VerticalDivider(
              thickness: 50,
              width: 50,
              color: isActive2 == true ? Colors.pinkAccent : Theme.of(context).dividerColor,
            )),
        const SizedBox(
          width: 5,
        ),
        NumberedContainer(
          text: text3,
          isActive: isActive3,
        ),
        const SizedBox(
          width: 5,
        ),
        SizedBox(
            height: 2,
            child: VerticalDivider(
              thickness: 50,
              width: 50,
              color: isActive3 == true ? Colors.pinkAccent : Theme.of(context).dividerColor,
            )),
        const SizedBox(
          width: 5,
        ),
        NumberedContainer(
          text: text4,
          isActive: isActive4,
        ),
        const SizedBox(
          width: 5,
        ),
        SizedBox(
            height: 2,
            child: VerticalDivider(
              thickness: 50,
              width: 50,
              color: isActive4 == true ? Colors.pinkAccent : Theme.of(context).dividerColor,
            )),
        const SizedBox(
          width: 5,
        ),
        NumberedContainer(
          text: text5,
          isActive: isActive5,
        ),
      ],
    );
  }
}
