part of 'candidat_bloc.dart';

abstract class CandidatEvent extends Equatable {
  const CandidatEvent();
  @override
  List<Object> get props => [];
}

class StartLoadCandidat extends CandidatEvent {}

class UpdateCandidat extends CandidatEvent {
  final List<Candidat> candidats;

  UpdateCandidat(this.candidats);
  @override
  List<Object> get props => [this.candidats];
}
