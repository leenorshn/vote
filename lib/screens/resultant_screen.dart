import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vote/apis/vote_api.dart';
import 'package:vote/models/candidat.dart';
import 'package:vote/screens/candidat_bloc/candidat_bloc.dart';
import 'package:vote/screens/candidat_vice_bloc/candidat_vice_bloc.dart';
import 'package:vote/votes/vote_bloc.dart';
import 'package:vote/votes_vice/vote_vice_bloc.dart';

class ResultScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Resultants"),
        elevation: 0,
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Resultats presidentiel",
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ),
            Expanded(
              child: BlocBuilder<CandidatBloc, CandidatState>(
                  builder: (context, state) {
                if (state is CandidatLoadedSuccess) {
                  return ListView.builder(
                      itemCount: state.candidats.length,
                      itemBuilder: (context, index) {
                        return ResultPresidentCard(
                          candidat: state.candidats[index],
                        );
                      });
                }
                if (state is VoteLoadedFailure) {
                  return Center(
                    child: Text("Error de votes"),
                  );
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              }),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Resultats vice-presidentiel",
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ),
            Card(
              margin: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.zero,
              ),
              child: Container(
                height: 200,
                child: BlocBuilder<CandidatViceBloc, CandidatViceState>(
                    builder: (context, state) {
                  if (state is CandidatViceLoadedSuccess) {
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: state.candidats.length,
                      itemBuilder: (context, index) {
                        Candidat candidat = state.candidats[index];
                        return CandidatViceTile(
                          candidat: candidat,
                        );
                      },
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CandidatViceTile extends StatelessWidget {
  const CandidatViceTile({
    this.candidat,
    Key key,
  }) : super(key: key);

  final Candidat candidat;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: (MediaQuery.of(context).size.width / 3) + 56,
      padding: EdgeInsets.only(bottom: 8),
      child: Column(
        children: [
          Container(
            height: 100,
            width: 100,
            child: Image.network(candidat.avatar),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "${candidat.name}",
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ),
          StreamBuilder<int>(
              stream:
                  VoteApi().getCandidatVotesVice(this.candidat.id).asStream(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text(
                    "${snapshot.data} voix",
                    style: TextStyle(fontSize: 24, color: Colors.teal),
                  );
                }
                return Text(
                  "0 voix",
                  style: TextStyle(fontSize: 18, color: Colors.teal),
                );
              }),
          BlocBuilder<VoteViceBloc, VoteViceState>(builder: (context, state) {
            if (state is VoteViceLoadedSuccess) {
              return Text(
                "/ ${state.votes} total ",
                style: TextStyle(fontSize: 18, color: Colors.orange[700]),
              );
            }
            return Text(
              "0",
              style: TextStyle(fontSize: 18, color: Colors.orange[700]),
            );
          }),
        ],
      ),
    );
  }
}

class ResultPresidentCard extends StatelessWidget {
  const ResultPresidentCard({
    Key key,
    this.candidat,
  }) : super(key: key);
  final Candidat candidat;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: Container(
        child: Stack(
          children: [
            Row(
              children: [
                Image.network(
                  this.candidat.avatar,
                  height: 140,
                  width: 140,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Column(
                    children: [
                      StreamBuilder<int>(
                          stream: VoteApi()
                              .getCandidatVotes(this.candidat.id)
                              .asStream(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Text(
                                "${snapshot.data} voix",
                                style:
                                    TextStyle(fontSize: 32, color: Colors.teal),
                              );
                            }
                            return Text(
                              "0 voix",
                              style:
                                  TextStyle(fontSize: 32, color: Colors.teal),
                            );
                          }),
                      BlocBuilder<VoteBloc, VoteState>(
                          builder: (context, state) {
                        if (state is VoteLoadedSuccess) {
                          return Text(
                            "/ ${state.votes} total ",
                            style: TextStyle(
                                fontSize: 18, color: Colors.orange[700]),
                          );
                        }
                        return Text(
                          "0",
                          style: TextStyle(
                              fontSize: 18, color: Colors.orange[700]),
                        );
                      }),
                      Container(
                        margin: EdgeInsets.only(top: 8),
                        child: Text(
                          "${candidat.name}",
                          overflow: TextOverflow.ellipsis,
                          style:
                              TextStyle(fontSize: 12, color: Colors.grey[700]),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              right: 8,
              top: 8,
              child: Container(
                height: 40,
                width: 40,
                child: Center(
                    child: Text(
                  "${candidat.numero}",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                )),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: Colors.orange[700],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
