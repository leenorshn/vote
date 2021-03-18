part of 'case_vote_vice_bloc.dart';

abstract class CaseVoteViceState extends Equatable {
  const CaseVoteViceState();
  @override
  List<Object> get props => [];
}

class CaseVoteViceInitial extends CaseVoteViceState {}

class CaseVoteViceProgress extends CaseVoteViceState {}

class HasVoteViceSuccess extends CaseVoteViceState {
  final bool hasVote;

  HasVoteViceSuccess(this.hasVote);

  @override
  List<Object> get props => [this.hasVote];
}

class HasVoteViceFailure extends CaseVoteViceState {}
