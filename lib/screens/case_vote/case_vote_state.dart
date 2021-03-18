part of 'case_vote_bloc.dart';

abstract class CaseVoteState extends Equatable {
  const CaseVoteState();
  @override
  List<Object> get props => [];
}

class CaseVoteInitial extends CaseVoteState {}

class CaseVoteProgress extends CaseVoteState {}

class HasVoteSuccess extends CaseVoteState {
  final bool hasVote;

  HasVoteSuccess(this.hasVote);

  @override
  List<Object> get props => [this.hasVote];
}

class HasVoteFailure extends CaseVoteState {}
