import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vote/models/candidat.dart';
import 'package:vote/screens/candidat_bloc/candidat_bloc.dart';
import 'package:vote/votes/vote_bloc.dart';

import 'candidat_screen.dart';
import 'candidat_vice_bloc/candidat_vice_bloc.dart';

class CandidatViceScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Candidats vice-president"),
        elevation: 0,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: BlocBuilder<CandidatViceBloc, CandidatViceState>(
            builder: (context, state) {
          if (state is CandidatViceLoadedSuccess) {
            List<Candidat> candidats = [];
            candidats = state.candidats;
            // .where((element) => element.type == "VICE_PRESIDENT")
            // .toList();

            if (candidats.length == 0) {
              return Center(
                child: Text("Aucun candidat"),
              );
            }

            return ListView.builder(
              itemCount: candidats.length,
              padding: EdgeInsets.only(top: 16, bottom: 72),
              itemBuilder: (context, index) {
                return CandidatTileCard(
                  imageUrl: candidats[index].avatar,
                  name: candidats[index].name,
                  numero: candidats[index].numero,
                  slogan: candidats[index].slogan,
                  onTap: () {
                    BlocProvider.of<VoteBloc>(context)
                      ..add(AddViceVote(candidats[index].id));
                    Navigator.of(context).pop();
                    BlocProvider.of<VoteBloc>(context)..add(LoadVote());
                  },
                );
              },
            );
          }
          if (state is CandidatLoadedFailure) {
            return Center(
              child: Text("Error"),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        }),
      ),
    );
  }
}
