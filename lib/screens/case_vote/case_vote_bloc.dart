import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:vote/apis/vote_api.dart';

part 'case_vote_event.dart';
part 'case_vote_state.dart';

class CaseVoteBloc extends Bloc<CaseVoteEvent, CaseVoteState> {
  final VoteApi voteApi;
  CaseVoteBloc(this.voteApi) : super(CaseVoteInitial());

  StreamSubscription _subscription;

  @override
  Stream<CaseVoteState> mapEventToState(
    CaseVoteEvent event,
  ) async* {
    if (event is LoadCaseVoteEvent) {
      _subscription?.cancel();
      yield CaseVoteProgress();
      try {
        yield CaseVoteProgress();
        _subscription = voteApi.hasVotesPresident().asStream().listen((event) {
          return add(UpdateCaseVoteEvent(event));
        });
      } catch (ex) {
        yield HasVoteFailure();
      }
    }

    if (event is UpdateCaseVoteEvent) {
      yield HasVoteSuccess(event.hasVote);
    }
  }
}
