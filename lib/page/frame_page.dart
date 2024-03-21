import 'package:d_tv/page/home/home_page.dart';
import 'package:flutter/material.dart';

class FramePage extends StatelessWidget {
  const FramePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black,
      body: SizedBox.expand(
        child: HomePage(),
      ),
    );
  }
}
