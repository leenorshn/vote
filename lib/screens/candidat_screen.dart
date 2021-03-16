import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vote/models/candidat.dart';
import 'package:vote/screens/candidat_bloc/candidat_bloc.dart';
import 'package:vote/votes/vote_bloc.dart';

class CandidatScreen extends StatelessWidget {
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
                .where((element) => element.type == "PRESIDENT")
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
                  matricule: candidats[index].id,
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

class CandidatTileCard extends StatelessWidget {
  final String imageUrl;
  final String numero;
  final String slogan;
  final String name;
  final String matricule;
  const CandidatTileCard({
    this.name,
    this.imageUrl,
    this.matricule,
    this.numero,
    this.slogan,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Stack(
        children: [
          Column(
            children: [
              Image.network(
                "$imageUrl",
                height: 220,
                width: double.infinity,
                fit: BoxFit.cover,
                scale: 0.2,
              ),
              Container(
                //height: 140,
                padding: EdgeInsets.only(bottom: 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 8),
                      child: Text(
                        "$name".toUpperCase(),
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 8),
                      child: Text(
                        "$slogan",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              vertical: 15, horizontal: 64)),
                      onPressed: () {
                        BlocProvider.of<VoteBloc>(context)
                          ..add(AddVote(matricule));
                      },
                      child: Text("Je vote"),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            child: Container(
              margin: EdgeInsets.all(8),
              height: 48,
              width: 48,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: Colors.amber[700]),
              child: Center(
                child: Text(
                  "$numero",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
