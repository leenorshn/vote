import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:vote/apis/candidat_api.dart';
import 'package:vote/models/candidat.dart';

part 'candidat_vice_event.dart';
part 'candidat_vice_state.dart';

class CandidatViceBloc extends Bloc<CandidatViceEvent, CandidatViceState> {
  final CandidatApi candidatApi;
  CandidatViceBloc(this.candidatApi) : super(CandidatViceInitial());

  StreamSubscription _subscription;

  @override
  Stream<CandidatViceState> mapEventToState(
    CandidatViceEvent event,
  ) async* {
    if (event is StartLoadCandidatVice) {
      _subscription?.cancel();
      try {
        _subscription = candidatApi.getCandidatVicePresident().listen((event) {
          add(UpdateCandidatVice(event));
        });
      } catch (ex) {
        yield CandidatViceLoadedFailure(ex.toString());
      }
    }
    if (event is UpdateCandidatVice) {
      yield CandidatViceLoadedSuccess(event.candidats);
    }
  }
}
