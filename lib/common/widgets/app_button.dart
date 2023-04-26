import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class AppButton extends StatelessWidget {
  final VoidCallback onTap;
  final double? width;
  final double? height;
  final IconData icon;
  final String text;
  final bool addBorder;
  final Color? iconColor;
  final bool isLoading;
  const AppButton({
    Key? key,
    required this.onTap,
    this.width = double.maxFinite,
    this.height = 70,
    required this.icon,
    required this.text,
    this.addBorder = false,
    this.iconColor,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      borderRadius: BorderRadius.circular(15),
      child: InkWell(
        splashColor: Colors.white.withOpacity(.2),
        onTap: isLoading == false ? onTap : (){},
        borderRadius: BorderRadius.circular(15),
        child: Ink(
          height: height,
          width: width,
          decoration: BoxDecoration(
            color: isLoading == false ? Colors.pinkAccent : Theme.of(context).canvasColor,
            borderRadius: BorderRadius.circular(15),
            border: addBorder ? Border.all(color: Theme.of(context).primaryColor,) : null,
          ),
          child: isLoading == true ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LoadingAnimationWidget.prograssiveDots(color: Colors.pinkAccent, size: 70,),
            ],
          ) : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: iconColor,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                text,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
