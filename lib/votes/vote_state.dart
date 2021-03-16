part of 'vote_bloc.dart';

abstract class VoteState extends Equatable {
  const VoteState();
  @override
  List<Object> get props => [];
}

class VoteInitial extends VoteState {
  @override
  List<Object> get props => [];
}

class VoteLoadedSuccess extends VoteState {
  final int votes;

  VoteLoadedSuccess(this.votes);

  @override
  List<Object> get props => [this.votes];
}

class VoteLoadedFailure extends VoteState {}
