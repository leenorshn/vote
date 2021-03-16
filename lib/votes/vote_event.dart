part of 'vote_bloc.dart';

abstract class VoteEvent extends Equatable {
  const VoteEvent();
  @override
  List<Object> get props => [];
}

class LoadVote extends VoteEvent {}

class UpdateVote extends VoteEvent {
  final int votes;

  UpdateVote(this.votes);

  @override
  List<Object> get props => [this.votes];
}

class AddVote extends VoteEvent {
  final String matriculeUID;

  AddVote(this.matriculeUID);

  @override
  List<Object> get props => [this.matriculeUID];
}
