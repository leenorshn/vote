import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vote/apis/auth_api.dart';
import 'package:vote/apis/candidat_api.dart';
import 'package:vote/apis/vote_api.dart';
import 'package:vote/auth/auth_bloc.dart';
import 'package:vote/screens/candidat_screen.dart';
import 'package:vote/screens/choice_screen.dart';
import 'package:vote/screens/error_screen.dart';
import 'package:vote/screens/login_screen.dart';
import 'package:vote/screens/progress_screen.dart';
import 'package:vote/screens/resultant_screen.dart';
import 'package:vote/votes/vote_bloc.dart';

import 'screens/candidat_bloc/candidat_bloc.dart';
import 'screens/candidat_vice_screen.dart';
import 'screens/cp_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthBloc(AuthApi())..add(AppStart())),
        BlocProvider(
          create: (context) =>
              CandidatBloc(CandidatApi())..add(StartLoadCandidat()),
        ),
        BlocProvider(
          create: (context) => VoteBloc(VoteApi())..add(LoadVote()),
        ),
        // BlocProvider(create: (context) => AuthBloc(AuthApi())),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primaryColor: Colors.white,
          accentColor: Colors.blue,
          brightness: Brightness.light,
          scaffoldBackgroundColor: Colors.blueGrey[50],
          appBarTheme: AppBarTheme(
            brightness: Brightness.dark,
          ),
        ),
        home: SwitchScreen(),
        routes: {
          //"/": (context) => LoginScreen(),
          "choice": (context) => ChoiceScreen(),
          "candidat": (context) => CandidatScreen(),
          "vice-candidat": (context) => CandidatViceScreen(),
          "resultant": (context) => ResultScreen(),
          "CPscreen": (context) => CPScreen(),
        },
      ),
    );
  }
}

class SwitchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
      if (state is AuthSuccess) {
        return ChoiceScreen();
      } else if (state is AuthInProgress) {
        return ProgressScreen();
      } else if (state is AuthFailure) {
        return ErrorScreen(
          error: state.error,
        );
      } else {
        return LoginScreen();
      }
    });
  }
}
