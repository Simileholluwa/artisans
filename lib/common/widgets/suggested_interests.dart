import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SuggestedInterests extends StatelessWidget {
  final String image;
  final String interestName;
  final RxBool isSelected;
  final String subCategory;
  final VoidCallback onTap;
  const SuggestedInterests({Key? key, required this.image, required this.interestName, required this.onTap, required this.isSelected, required this.subCategory}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => Material(
      type: MaterialType.transparency,
      borderRadius: BorderRadius.circular(15),
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: onTap,
        child: Ink(
          width: 70,
          decoration: BoxDecoration(
            color: isSelected.isFalse ? Theme.of(context).scaffoldBackgroundColor : Theme.of(context).highlightColor,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  isSelected.isFalse ?
                  AnimatedOpacity(
                    opacity: isSelected.isFalse ? 1: 0,
                    duration: const Duration(milliseconds: 1000),
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/$image'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ) :
                  AnimatedOpacity(
                    opacity: isSelected.isFalse ? 0 : 1,
                    duration: const Duration(milliseconds: 1000),
                    child : Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                          Icons.check,
                        size: 30,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(width: 20,),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(interestName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                          ),
                        ),
                        Text(subCategory,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.poppins(
                            color: Theme.of(context).hintColor
                          ),
                        ),
                      ],
                    ),
                  ),
                ]
            ),
          ),
        ),
      ),
    ),);
  }
}
