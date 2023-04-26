import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';


void message(String message, {String title = 'Error', bool isError = true, bool isInfo = false }){
   Get.snackbar(
    title,
    message,
    titleText: Text(
      isError ? title : (isInfo ? 'Information' : 'Success'),
      style: GoogleFonts.poppins(
        fontSize: 20,
        fontWeight: FontWeight.normal
      ),
    ),
     messageText: Text(
       message,
       style: GoogleFonts.poppins(
         color: Theme.of(Get.context!).hintColor,
       ),
     ),
     backgroundColor: Theme.of(Get.context!).canvasColor,
     snackPosition: SnackPosition.TOP,
     duration: const Duration(seconds: 5),
     margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 20,),
     borderRadius: 0,
     snackStyle: SnackStyle.FLOATING,
     isDismissible: true,
     dismissDirection: DismissDirection.horizontal,
     leftBarIndicatorColor: isError ? Colors.red : (isInfo ? Colors.blue : Colors.green),
  );
}
