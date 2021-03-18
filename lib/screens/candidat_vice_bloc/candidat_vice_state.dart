part of 'candidat_vice_bloc.dart';

abstract class CandidatViceState extends Equatable {
  const CandidatViceState();

  @override
  List<Object> get props => [];
}

class CandidatViceInitial extends CandidatViceState {}

class CandidatViceLoadedSuccess extends CandidatViceState {
  final List<Candidat> candidats;

  CandidatViceLoadedSuccess(this.candidats);
  @override
  List<Object> get props => [this.candidats];
}

class CandidatViceLoadedFailure extends CandidatViceState {
  final String error;

  CandidatViceLoadedFailure(this.error);
  @override
  List<Object> get props => [this.error];
}
