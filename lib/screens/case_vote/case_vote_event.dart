part of 'case_vote_bloc.dart';

abstract class CaseVoteEvent extends Equatable {
  const CaseVoteEvent();

  @override
  List<Object> get props => [];
}

class LoadCaseVoteEvent extends CaseVoteEvent {}

class UpdateCaseVoteEvent extends CaseVoteEvent {
  final bool hasVote;

  UpdateCaseVoteEvent(this.hasVote);

  @override
  List<Object> get props => [this.hasVote];
}
