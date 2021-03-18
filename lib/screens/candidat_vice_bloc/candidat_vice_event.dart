part of 'candidat_vice_bloc.dart';

abstract class CandidatViceEvent extends Equatable {
  const CandidatViceEvent();

  @override
  List<Object> get props => [];
}

class StartLoadCandidatVice extends CandidatViceEvent {}

class UpdateCandidatVice extends CandidatViceEvent {
  final List<Candidat> candidats;

  UpdateCandidatVice(this.candidats);
  @override
  List<Object> get props => [this.candidats];
}
