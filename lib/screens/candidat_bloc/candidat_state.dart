part of 'candidat_bloc.dart';

abstract class CandidatState extends Equatable {
  const CandidatState();
}

class CandidatInitial extends CandidatState {
  @override
  List<Object> get props => [];
}

class CandidatLoadedSuccess extends CandidatState {
  final List<Candidat> candidats;

  CandidatLoadedSuccess(this.candidats);
  @override
  List<Object> get props => [this.candidats];
}

class CandidatLoadedFailure extends CandidatState {
  final String error;

  CandidatLoadedFailure(this.error);
  @override
  List<Object> get props => [];
}
