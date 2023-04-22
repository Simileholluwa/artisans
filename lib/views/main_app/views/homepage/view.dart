import 'package:artisans/views/main_app/views/homepage/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends GetView<HomeController> {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Text('Home')),
          IconButton(onPressed: (){controller.logout();}, icon: Icon(Icons.logout)),
        ],
      ),
    );
  }
}
