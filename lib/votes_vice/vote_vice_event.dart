part of 'vote_vice_bloc.dart';

abstract class VoteViceEvent extends Equatable {
  const VoteViceEvent();

  @override
  List<Object> get props => [];
}

class LoadVoteVice extends VoteViceEvent {}

class UpdateVoteVice extends VoteViceEvent {
  final int votes;

  UpdateVoteVice(this.votes);

  @override
  List<Object> get props => [this.votes];
}
