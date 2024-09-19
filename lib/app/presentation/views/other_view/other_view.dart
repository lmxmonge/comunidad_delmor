import 'package:flutter/material.dart';

class OtherView extends StatelessWidget {
  const OtherView({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text('Other'),
      ),
      body: Center(
        child: Text('Other View'),
      ),
    );
  }
}
