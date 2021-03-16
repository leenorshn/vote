import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vote/apis/auth_api.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthApi authApi;
  AuthBloc(this.authApi) : super(AuthInitial());

  StreamSubscription _subscription;

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is AppStart) {
      _subscription?.cancel();
      try {
        yield AuthInProgress();
        _subscription = authApi.isLogin().listen((event) {
          add(AuthUpdated(event));
        });
      } catch (err) {
        yield AuthFailure(err);
      }
    }
    if (event is LoginEvent) {
      try {
        yield AuthInProgress();
        String tt = await authApi.login(event.matricule);
        //ar ss = await EtudiantApi().getCurrentStudent(tt);
        yield AuthSuccess();
      } catch (err) {
        if (err.toString().contains('[firebase_auth/user-not-found]')) {
          yield AuthFailure("Utilisateur inconnu");
        } else if (err
            .toString()
            .contains('[firebase_auth/network-request-failed]')) {
          yield AuthFailure(
              "Erreur reseau\n vous n'etes pas connecter a l'internet");
        } else {
          print(err.toString());
          yield AuthFailure("Erreur inconnue");
        }
      }
    }

    if (event is AuthUpdated) {
      //yield AuthInProgress();
      if (event.user != null) {
        //var ss = await EtudiantApi().getCurrentStudent(event.user.uid);
        yield AuthSuccess();
      } else {
        yield AuthFailure("Error de connexion ${event.user}");
        yield AuthInitial();
      }
    }
    if (event is LogoutEvent) {
      yield AuthInProgress();
      await authApi.logout();
      yield AuthInitial();
    }
  }
}
