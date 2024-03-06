import 'package:flutter/material.dart';
import '../../main.dart';
import 'Journal_log.dart';

class NoMatches extends StatelessWidget {
  const NoMatches({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            onPressed: (){
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (BuildContext context){
                    return const NoMatches();
                  })
              );
            },
            icon: const Icon(Icons.refresh)
          ),
          IconButton(
            onPressed: (){
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (BuildContext context){
                    return const MyApp();
                  })
              );
            },
            icon: const Icon(Icons.home),
          ),
        ]
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20,),
            Container(
              height: 300,
              color: Colors.lightBlueAccent,
            ),
            const SizedBox(height: 50,),
            const Text("No Matches",
              style: TextStyle(
                fontSize: 40,
              ),
            ),
            const SizedBox(height: 50,),
            const Text("This could be a potential new specie",
              style: TextStyle(
                  fontSize: 15
              ),
            ),
            const SizedBox(height: 30,),
            const Text("You can record a journal log about this discovery and let others to see!",
              style: TextStyle(
                  fontSize: 15
              ),
            ),
            const SizedBox(height: 30,),
            Container(
                alignment: Alignment.center,
                width: 300,
                height: 60,
                color: Colors.orange,
                child: TextButton(
                  onPressed: (){
                    showDialogFunctionLocation(context);
                  },
                  child: const Text("Journal Log",style: TextStyle(
                      fontSize: 30,
                      color: Colors.white),),
                )
            ),
          ],
        ),
      )
    );
  }
}
showDialogFunctionLocation(context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Confirm permission"),
        content: const Text("Do you agree that we will automatically obtain your current location?"),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (BuildContext context) {
                      return JournalLog();
                    })
                );
              },
              child: const Text("Yes")),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("No"),
          ),
        ],
      );
    },
  );
}