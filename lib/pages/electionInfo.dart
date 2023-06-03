// import 'package:electiondapp/services/functions.dart';
// import 'package:flutter/material.dart';
// import 'package:web3dart/web3dart.dart';
//
// class ElectionInfo extends StatefulWidget {
//   final Web3Client ethClient;
//   final String electionName;
//   const ElectionInfo({super.key, required this.ethClient, required this.electionName});
//
//   @override
//   State<ElectionInfo> createState() => _ElectionInfoState();
// }
//
// class _ElectionInfoState extends State<ElectionInfo> {
//   TextEditingController addCandidateController = TextEditingController();
//   TextEditingController authorizeVoterController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           widget.electionName,
//         ),
//       ),
//       body: Container(
//         padding: EdgeInsets.all(14),
//         child: Column(
//           children: [
//             SizedBox(height: 20),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 Column(
//                   children: [
//                     FutureBuilder<List>(
//                       future: getCandidatesNum(widget.ethClient),
//                       builder: (context, snapshot) {
//                         if(snapshot.connectionState==ConnectionState.waiting) return Center(child: CircularProgressIndicator(),);
//                         return Text(
//                           snapshot.data![0].toString(),
//                           style: TextStyle(
//                             fontSize: 50,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         );
//                       }
//                     ),
//                     Text(
//                         'Total Candidates'
//                     )
//                   ],
//                 ),
//                 Column(
//                   children: [
//                     FutureBuilder<List>(
//                         future: getTotaVotes(widget.ethClient),
//                         builder: (context, snapshot) {
//                           if(snapshot.connectionState==ConnectionState.waiting) return Center(child: CircularProgressIndicator(),);
//                           return Text(
//                             snapshot.data![0].toString(),
//                             style: TextStyle(
//                               fontSize: 50,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           );
//                         }
//                     ),
//                     Text(
//                         'Total Votes'
//                     )
//                   ],
//                 ),
//
//               ],
//             ),
//
//             SizedBox(height: 20,),
//             Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     controller: addCandidateController,
//                     decoration: InputDecoration(
//                       filled: true,
//                       hintText: 'Enter Candidate name: ',
//                     ),
//                   ),
//                 ),
//                 SizedBox(width: 10),
//                 ElevatedButton(
//                     onPressed: (){
//                       addCandidate(addCandidateController.text, widget.ethClient);
//                     },
//                     child: Text('Add Candidate')
//                 ),
//               ],
//             ),
//             SizedBox(height: 20),
//             Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     controller: authorizeVoterController,
//                     decoration: InputDecoration(
//                       filled: true,
//                       hintText: 'Enter Voter Address ',
//                     ),
//                   ),
//                 ),
//                 SizedBox(width: 10),
//                 ElevatedButton(
//                     onPressed: (){
//                       authorizeVoter(authorizeVoterController.text, widget.ethClient);
//                     },
//                     child: Text('Add Candidate')
//                 ),
//               ],
//             ),
//             Divider(),
//             FutureBuilder<List>(
//               future: getCandidatesNum(widget.ethClient),
//               builder: (context,snapshot){
//                 if(snapshot.connectionState==ConnectionState.waiting){return Center(child: CircularProgressIndicator(),); }
//                 else{
//                   return Column(
//                     children: [
//                       for(int i=0;i<snapshot.data![0].toInt(); i++)
//                         FutureBuilder<List>(
//                             future: candidateInfo(i, widget.ethClient),
//                             builder: (context,candidatesnapshot){
//                               if(candidatesnapshot.connectionState==ConnectionState.waiting){return Center(child: CircularProgressIndicator(),); }
//                               else {
//                                return ListTile(
//                                  title: Text('Name: '+candidatesnapshot.data![0][0].toString()),
//                                  subtitle: Text('Votes: '+candidatesnapshot.data![0][1].toString()),
//                                  trailing: ElevatedButton(
//                                    onPressed: (){
//                                      vote(i, widget.ethClient);
//                                    },
//                                    child: Text('Vote'),
//                                  ),
//                                );
//                               }
//                               },
//
//                         )
//                     ],
//                   );
//                 }
//               }
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:electiondapp/services/functions.dart';
import 'package:flutter/material.dart';
import 'package:web3dart/web3dart.dart';

class ElectionInfo extends StatefulWidget {
  final Web3Client ethClient;
  final String electionName;
  const ElectionInfo({Key? key, required this.ethClient, required this.electionName}) : super(key: key);

  @override
  State<ElectionInfo> createState() => _ElectionInfoState();
}

class _ElectionInfoState extends State<ElectionInfo> {
  TextEditingController addCandidateController = TextEditingController();
  TextEditingController authorizeVoterController = TextEditingController();

  Future<List> refreshData() async {
    setState(() {});
    // Refreshes the state of the widget
    return await Future.wait([
      getCandidatesNum(widget.ethClient),
      getTotaVotes(widget.ethClient),
    ]);
  }

  @override
  void initState() {
    super.initState();
    refreshData();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.electionName,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(14),
          child: Column(
            children: [
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      FutureBuilder<List>(
                        future: getCandidatesNum(widget.ethClient),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) return Center(child: CircularProgressIndicator());
                          return Text(
                            snapshot.data![0].toString(),
                            style: TextStyle(
                              fontSize: 50,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        },
                      ),
                      Text('Total Candidates'),
                    ],
                  ),
                  Column(
                    children: [
                      FutureBuilder<List>(
                        future: getTotaVotes(widget.ethClient),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) return Center(child: CircularProgressIndicator());
                          return Text(
                            snapshot.data![0].toString(),
                            style: TextStyle(
                              fontSize: 50,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        },
                      ),
                      Text('Total Votes'),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: addCandidateController,
                      decoration: InputDecoration(
                        filled: true,
                        hintText: 'Enter Candidate name: ',
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () async {
                      await addCandidate(addCandidateController.text, widget.ethClient);
                      await refreshData();
                    },
                    child: Text('Add Candidate'),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: authorizeVoterController,
                      decoration: InputDecoration(
                        filled: true,
                        hintText: 'Enter Voter Address ',
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () async {
                      await authorizeVoter(authorizeVoterController.text, widget.ethClient);
                      await refreshData();
                    },
                    child: Text('Add Candidate'),
                  ),
                ],
              ),
              Divider(),
              FutureBuilder<List>(
                future: getCandidatesNum(widget.ethClient),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    return Column(
                      children: [
                        for (int i = 0; i < snapshot.data![0].toInt(); i++)
                          FutureBuilder<List>(
                            future: candidateInfo(i, widget.ethClient),
                            builder: (context, candidatesnapshot) {
                              if (candidatesnapshot.connectionState == ConnectionState.waiting) {
                                return Center(child: CircularProgressIndicator());
                              } else {
                                return ListTile(
                                  title: Text('Name: ' + candidatesnapshot.data![0][0].toString()),
                                  subtitle: Text('Votes: ' + candidatesnapshot.data![0][1].toString()),
                                  trailing: ElevatedButton(
                                    onPressed: () async {
                                      await vote(i, widget.ethClient);
                                      await refreshData();
                                    },
                                    child: Text('Vote'),
                                  ),
                                );
                              }
                            },
                          )
                      ],
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
