import 'package:flutter/material.dart';

class ProgressScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Encours ...",
              style: TextStyle(
                fontSize: 32,
                color: Colors.teal,
              ),
            ),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
