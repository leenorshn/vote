import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vote/auth/auth_bloc.dart';
import 'package:vote/screens/case_vote/case_vote_bloc.dart';
import 'package:vote/screens/case_vote_vice/case_vote_vice_bloc.dart';

class ChoiceScreen extends StatefulWidget {
  @override
  _ChoiceScreenState createState() => _ChoiceScreenState();
}

class _ChoiceScreenState extends State<ChoiceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("UAC-Vote"),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
              icon: Icon(CupertinoIcons.clear_circled),
              onPressed: () {
                BlocProvider.of<AuthBloc>(context)..add(LogoutEvent());
              })
        ],
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 24,
            ),
            Text(
              "Voulez-vous voter\n c'est facile\n commencer par ces etapes:",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                color: Colors.teal,
              ),
            ),
            SizedBox(
              height: 56,
            ),
            BlocBuilder<CaseVoteBloc, CaseVoteState>(
                // cubit: CaseVoteBloc(),
                builder: (context, state) {
              if (state is HasVoteSuccess) {
                if (state.hasVote) {
                  return ChoseDone(
                    cases: "President",
                  );
                } else {
                  return ChoiceVoteMenu(
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        "candidat",
                      );
                    },
                    label: "Presidentiel",
                    numStep: "1",
                  );
                }
              } else if (state is CaseVoteProgress) {
                return CustomLoading();
              } else {
                return ChoiceVoteMenu(
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      "candidat",
                    );
                  },
                  label: "Presidentiel",
                  numStep: "1",
                );
              }
            }),
            BlocBuilder<CaseVoteViceBloc, CaseVoteViceState>(
                builder: (context, state) {
              if (state is HasVoteViceSuccess) {
                if (state.hasVote) {
                  return ChoseDone(
                    cases: "Vice-president",
                  );
                } else {
                  return ChoiceVoteMenu(
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        "vice-candidat",
                      );
                    },
                    label: "Vice-Presidentiel",
                    numStep: "2",
                  );
                }
              } else if (state is CaseVoteViceProgress) {
                return CustomLoading();
              } else {
                return ChoiceVoteMenu(
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      "vice-candidat",
                    );
                  },
                  label: "Vice-Presidentiel",
                  numStep: "2",
                );
              }
            }),
            ChoiceVoteMenu(
              onTap: () {
                Navigator.of(context).pushNamed(
                  "resultant",
                );
              },
              label: "Resultats de vote",
              numStep: "3",
            ),
            Spacer(),
            SvgPicture.asset(
              "images/votes.svg",
              height: 108,
              width: 108,
              color: Colors.teal,
            ),
            SizedBox(
              height: 24,
            ),
          ],
        ),
      ),
    );
  }
}

class CustomLoading extends StatelessWidget {
  const CustomLoading({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: Container(
          width: MediaQuery.of(context).size.width - 24,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Encours ....",
                style: TextStyle(
                  color: Color(0xff21ce99),
                  fontWeight: FontWeight.w700,
                ),
              ),
              CircularProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}

class ChoiceVoteMenu extends StatelessWidget {
  final String label;
  final String numStep;
  final Function onTap;

  const ChoiceVoteMenu({this.label, this.numStep, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: ListTile(
        onTap: onTap,
        title: Text(
          "$label",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: Container(
          height: 40,
          width: 40,
          child: Center(
            child: Text("$numStep"),
          ),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22), border: Border.all()),
        ),
        trailing: Icon(CupertinoIcons.chevron_forward),
      ),
    );
  }
}

class ChoseDone extends StatelessWidget {
  final String cases;

  const ChoseDone({Key key, this.cases}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: Color(0xff21ce99),
      child: ListTile(
        leading: Icon(
          Icons.done,
          color: Colors.white,
        ),
        title: Text(
          "Tu as deja voté le ${cases}",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
