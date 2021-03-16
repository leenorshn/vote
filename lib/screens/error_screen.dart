import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vote/auth/auth_bloc.dart';

class ErrorScreen extends StatelessWidget {
  final String error;

  const ErrorScreen({Key key, this.error}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("Alert !"),
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SvgPicture.asset(
              "images/error.svg",
              height: 160,
              width: 130,
            ),
            Text(
              "$error",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                BlocProvider.of<AuthBloc>(context)..add(AppStart());
              },
              child: Text("Fermer"),
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
              ),
            )
          ],
        ),
      ),
    );
  }
}
