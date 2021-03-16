import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vote/models/candidat.dart';

import 'candidat_bloc/candidat_bloc.dart';
import 'candidat_screen.dart';

class CPScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Candidats president"),
        elevation: 0,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child:
            BlocBuilder<CandidatBloc, CandidatState>(builder: (context, state) {
          if (state is CandidatLoadedSuccess) {
            List<Candidat> candidats = [];
            candidats = state.candidats
                .where(
                    (element) => element.type == "CP" || element.type == "CPA")
                .toList();

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
