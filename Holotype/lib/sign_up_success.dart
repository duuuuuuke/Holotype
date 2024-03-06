import 'package:flutter/material.dart';
import 'package:demo1/pages/Tabs.dart';
import 'package:demo1/pages/tabs/screens/authenticate/authenticate.dart';

class SignUpSuccess extends StatelessWidget {
  const SignUpSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(alignment: Alignment.center, children: [
      //background image
      Opacity(
        opacity: 0.5,
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage("assets/img/homepage.jpg"))),
        ),
      ),

      SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //title
            const Text(
              "holotype",
              style: TextStyle(
                color: Colors.black,
                fontFamily: "Georgia",
                fontSize: 80,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(
              height: 75,
            ),
            //content
            SizedBox(
                width: 300,
                height: 275,
                child: Column(
                  children: const [
                    Text(
                      "Hi, welcome to Holotype",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    Text("Here's how our app works:",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20)),
                    Text(
                        "1. Upload the pictures of your plant discovery for image recognition."),
                    Text("2. Record a log for your new discovery and post it!"),
                    Text(
                        "3. Vote for the posts that you think contain the new species."),
                    Text("4. Let community find and vote on your discovery."),
                    Text(
                        "5. Professionals will exam the posts that have high vote."),
                    Text(
                        "6. If the discovery is confirmed new findings, help experts to name the new plant!")
                  ],
                )),
            //go to main page
            Container(
                width: 300,
                height: 60,
                color: Colors.orange,
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (BuildContext context) {
                      return Tabs();
                    }));
                  },
                  child: const Text(
                    "CONTINUE",
                    style: TextStyle(fontSize: 30, color: Colors.white),
                  ),
                )),

            const SizedBox(
              height: 30,
            ),
            //back to home page
            FloatingActionButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (BuildContext context) {
                  return const Authenticate();
                }));
              },
              child: const Icon(Icons.home),
            )
          ],
        ),
      )
    ]));
  }
}
