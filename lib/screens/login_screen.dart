import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vote/auth/auth_bloc.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _name;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Text(
                  "UAC-VOTE",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text("Bienvenu"),
              ],
            ),
            TextField(
              onChanged: (v) {
                setState(() {
                  _name = v;
                });
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey,
                    width: 2.5,
                  ),
                ),
                labelText: "Matricule de l'etudiant",
                labelStyle: TextStyle(color: Colors.grey[500]),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(
                  vertical: 15,
                  horizontal: 56,
                ),
              ),
              onPressed: () {
                if (_name != null) {
                  BlocProvider.of<AuthBloc>(context)
                    ..add(
                      LoginEvent(_name),
                    );
                }
                // Navigator.of(context).pushNamed("choice");
              },
              child: Text("Connexion"),
            ),
          ],
        ),
      ),
    );
  }
}
