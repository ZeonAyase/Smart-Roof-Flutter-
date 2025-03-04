import 'package:flutter/material.dart';

class UndefinedPage extends StatelessWidget {
  final String name;

  const UndefinedPage({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Route for $name is not defined'),
      ),
    );
  }
}