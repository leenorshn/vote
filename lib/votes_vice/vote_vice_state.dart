part of 'vote_vice_bloc.dart';

abstract class VoteViceState extends Equatable {
  const VoteViceState();
  @override
  List<Object> get props => [];
}

class VoteViceInitial extends VoteViceState {}

class VoteViceLoadedSuccess extends VoteViceState {
  final int votes;

  VoteViceLoadedSuccess(this.votes);

  @override
  List<Object> get props => [this.votes];
}

class VoteViceLoadedFailure extends VoteViceState {}
