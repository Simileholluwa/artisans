import 'package:get/get.dart';

class InterestsModel{
  String image;
  String interestName;
  String subCategory;
  RxBool isSelected;

  InterestsModel({
   required this.image,
   required this.interestName,
    required this.isSelected,
    required this.subCategory,
});
}