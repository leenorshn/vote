part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();
  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthInProgress extends AuthState {}

class AuthSuccess extends AuthState {
  // final Etudiant etudiant;
  //
  // AuthSuccess(this.etudiant);
  // @override
  // List<Object> get props => [this.etudiant];
}

class AuthFailure extends AuthState {
  final String error;

  AuthFailure(this.error);
  @override
  List<Object> get props => [];
}
