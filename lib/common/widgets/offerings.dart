import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Offerings extends StatelessWidget {
  final String heading;
  final String subHeading;
  final String image;
  final bool? isFirst;
  final double opacity;
  const Offerings({Key? key, required this.heading, required this.subHeading, required this.image, this.isFirst = false, this.opacity = 0.0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: opacity,
      duration: const Duration(milliseconds: 500),
      child: Column(
        children: [
          isFirst == true ? Container() : const Divider(height: 40, endIndent: 10, indent: 80,),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(top:5,),
                height: 65,
                width: 65,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/$image'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      heading,
                      style: GoogleFonts.poppins(
                        fontSize: 23,
                        fontWeight: FontWeight.w500,
                        color: Colors.blue.shade700,
                      ),
                      maxLines: 1,
                    ),
                    Text(
                      subHeading,
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w300,
                      ),
                      maxLines: 3,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 3),
        ],
      ),
    );
  }
}
