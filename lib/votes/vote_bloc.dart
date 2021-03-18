import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:vote/apis/vote_api.dart';
import 'package:vote/models/vote.dart';

part 'vote_event.dart';
part 'vote_state.dart';

class VoteBloc extends Bloc<VoteEvent, VoteState> {
  final VoteApi voteApi;
  VoteBloc(this.voteApi) : super(VoteInitial());

  StreamSubscription _subscription;

  @override
  Stream<VoteState> mapEventToState(
    VoteEvent event,
  ) async* {
    if (event is LoadVote) {
      try {
        _subscription?.cancel();
        _subscription = voteApi.getAllVotesPresident().listen((event) {
          add(UpdateVote(event));
        });
      } catch (err) {
        yield VoteLoadedFailure();
      }
    }
    if (event is UpdateVote) {
      yield VoteLoadedSuccess(event.votes);
    }
    if (event is AddVote) {
      await voteApi.voter(event.matriculeUID);
      yield VoteInitial();
    }

    if (event is AddViceVote) {
      await voteApi.voterVicePresident(event.matriculeUID);
      yield VoteInitial();
    }
  }
}
