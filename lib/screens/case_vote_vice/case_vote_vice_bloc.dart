import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:vote/apis/vote_api.dart';

part 'case_vote_vice_event.dart';
part 'case_vote_vice_state.dart';

class CaseVoteViceBloc extends Bloc<CaseVoteViceEvent, CaseVoteViceState> {
  final VoteApi voteApi;
  CaseVoteViceBloc(this.voteApi) : super(CaseVoteViceInitial());

  StreamSubscription _subscription;

  @override
  Stream<CaseVoteViceState> mapEventToState(
    CaseVoteViceEvent event,
  ) async* {
    if (event is LoadCaseViceVoteEvent) {
      _subscription?.cancel();
      yield CaseVoteViceProgress();
      try {
        _subscription =
            voteApi.hasVotesVicePresident().asStream().listen((event) {
          return add(UpdateCaseViceVoteEvent(event));
        });
      } catch (ex) {
        yield HasVoteViceFailure();
      }
    }

    if (event is UpdateCaseViceVoteEvent) {
      yield HasVoteViceSuccess(event.hasVote);
    }
  }
}
