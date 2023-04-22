import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../common/entities/entities.dart';

class InterestsState {
  RxList<InterestsModel> interests = [
    InterestsModel(
      image: 'clipper.png',
      interestName: 'Graphics & Design',
      isSelected: false.obs,
      subCategory:
          'Create logos, brand identities, posters, e-fliers, icons, illustrations, with visual impact',
    ),
    InterestsModel(
      image: 'Shoe.png',
      interestName: 'Character Animation',
      isSelected: false.obs,
      subCategory:
          'Bring concepts and ideas to life in film, television, gaming, and video',
    ),
    InterestsModel(
      image: 'Fashion.png',
      interestName: 'Photography',
      isSelected: false.obs,
      subCategory:
          'Capture memorable moments at events, in a studio, beautiful landscapes and nature',
    ),
    InterestsModel(
      image: 'Shoe.png',
      interestName: 'Network Administrator',
      isSelected: false.obs,
      subCategory:
          'Install, monitor, troubleshoot, and upgrade network infrastructure',
    ),
    InterestsModel(
      image: 'Shoe.png',
      interestName: 'Video games',
      isSelected: false.obs,
      subCategory: 'Create captivating video game experiences with skill and imagination',
    ),
    InterestsModel(
      image: 'Fashion.png',
      interestName: 'Web development',
      isSelected: false.obs,
      subCategory: 'Develop digital presence for individuals or businesses on the internet',
    ),
    InterestsModel(
      image: 'clipper.png',
      interestName: 'Mobile Development',
      isSelected: false.obs,
      subCategory: 'Create software applications that run on mobile devices',
    ),
    InterestsModel(
      image: 'Fashion.png',
      interestName: 'Mechanical Engineering CAD',
      isSelected: false.obs,
      subCategory: 'Technical drawings and specifications for engineering and manufacturing',
    ),
    InterestsModel(
      image: 'Shoe.png',
      interestName: 'Architectural Design CAD',
      isSelected: false.obs,
      subCategory: 'Prepare construction plans for buildings - mechanical, electrical, or structural',
    ),
    InterestsModel(
      image: 'clipper.png',
      interestName: 'System Administrator',
      isSelected: false.obs,
      subCategory:
          'Support multiuser computing environment and ensure optimal performance of IT services',
    ),
  ].obs;

  List<String> selectedInterests = [];

  late TabController tabController;
}
