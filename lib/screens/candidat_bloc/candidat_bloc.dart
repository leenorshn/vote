import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:vote/apis/candidat_api.dart';
import 'package:vote/models/candidat.dart';

part 'candidat_event.dart';
part 'candidat_state.dart';

class CandidatBloc extends Bloc<CandidatEvent, CandidatState> {
  final CandidatApi candidatApi;
  CandidatBloc(this.candidatApi) : super(CandidatInitial());

  StreamSubscription _subscription;

  @override
  Stream<CandidatState> mapEventToState(
    CandidatEvent event,
  ) async* {
    if (event is StartLoadCandidat) {
      _subscription?.cancel();
      _subscription = candidatApi.getCandidatPresident().listen((event) {
        add(UpdateCandidat(event));
      });
    }
    if (event is UpdateCandidat) {
      yield CandidatLoadedSuccess(event.candidats);
    }
  }
}
