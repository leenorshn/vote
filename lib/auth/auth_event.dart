part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
  @override
  List<Object> get props => [];
}

class AppStart extends AuthEvent {}

class LoginEvent extends AuthEvent {
  final String matricule;

  LoginEvent(this.matricule);

  @override
  List<Object> get props => [this.matricule];
}

class AuthUpdated extends AuthEvent {
  final User user;

  AuthUpdated(this.user);

  @override
  List<Object> get props => [this.user];
}

class LogoutEvent extends AuthEvent {}
