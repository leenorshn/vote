part of 'case_vote_vice_bloc.dart';

abstract class CaseVoteViceEvent extends Equatable {
  const CaseVoteViceEvent();
  @override
  List<Object> get props => [];
}

class LoadCaseViceVoteEvent extends CaseVoteViceEvent {}

class UpdateCaseViceVoteEvent extends CaseVoteViceEvent {
  final bool hasVote;

  UpdateCaseViceVoteEvent(this.hasVote);

  @override
  List<Object> get props => [this.hasVote];
}
