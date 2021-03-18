import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:vote/apis/vote_api.dart';

part 'vote_vice_event.dart';
part 'vote_vice_state.dart';

class VoteViceBloc extends Bloc<VoteViceEvent, VoteViceState> {
  final VoteApi voteApi;
  VoteViceBloc(this.voteApi) : super(VoteViceInitial());

  StreamSubscription _subscription;

  @override
  Stream<VoteViceState> mapEventToState(
    VoteViceEvent event,
  ) async* {
    if (event is LoadVoteVice) {
      try {
        _subscription?.cancel();
        _subscription = voteApi.getAllVotesVicePresident().listen((event) {
          add(UpdateVoteVice(event));
        });
      } catch (err) {
        yield VoteViceLoadedFailure();
      }
    }
    if (event is UpdateVoteVice) {
      yield VoteViceLoadedSuccess(event.votes);
    }
  }
}
