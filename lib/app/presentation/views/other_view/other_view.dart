import 'package:flutter/material.dart';

class OtherView extends StatelessWidget {
  const OtherView({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text('Other'),
      ),
      body: const Center(
        child: Text('Other View'),
      ),
    );
  }
}
