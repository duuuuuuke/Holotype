import 'package:flutter/material.dart';
import 'package:demo1/pages/setting_page.dart';

class ExpertUserProfilePage extends StatelessWidget {
  const ExpertUserProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // Background Image

      child: ListView(
        children: [
          Stack(
            children: [
              // White Background
              Container(
                // decoration:
                //     BoxDecoration(border: Border.all(color: Colors.red)),
                  child: Container(
                    margin: EdgeInsets.fromLTRB(0, 200, 0, 0),
                    color: Colors.white,
                  )),
              Container(
                  margin: EdgeInsets.fromLTRB(0, 100, 0, 0),
                  child: Center(
                    child: Column(children: [
                      Container(
                        // margin: EdgeInsets.fromLTRB(200, 150, 200, 200),
                        height: 150,
                        decoration: BoxDecoration(
                          // border: Border.all(color: Colors.red),
                            image: DecorationImage(
                              image: AssetImage("assets/img/img.png"),
                              fit: BoxFit.contain,
                            ),
                            shape: BoxShape.circle),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
                        child: Text(
                          "Agnes Don",
                          style: TextStyle(
                              color: Color.fromARGB(255, 44, 94, 70),
                              fontFamily: "Fatface",
                              fontSize: 50),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Color.fromARGB(255, 249, 242, 233),
                              ),
                              child: Column(children: [
                                Container(
                                  width: 70,
                                  height: 20,
                                  margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                                  child: Text(
                                    "New Discoveries",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 9,
                                      color: Color.fromARGB(255, 44, 94, 70),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                  child: Text(
                                    "1",
                                    style: TextStyle(
                                        fontFamily: "Fatface",
                                        fontSize: 35,
                                        color: Color.fromRGBO(255, 138, 0, 1)),
                                  ),
                                )
                              ]),
                            ),
                            Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Color.fromARGB(255, 249, 242, 233),
                              ),
                              child: Column(children: [
                                Container(
                                  width: 70,
                                  height: 20,
                                  margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                                  child: Text(
                                    "Total\n Upvotes",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 9,
                                      color: Color.fromARGB(255, 44, 94, 70),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                  child: Text(
                                    "12",
                                    style: TextStyle(
                                        fontFamily: "Fatface",
                                        fontSize: 35,
                                        color: Color.fromRGBO(255, 138, 0, 1)),
                                  ),
                                )
                              ]),
                            ),
                            Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Color.fromARGB(255, 249, 242, 233),
                              ),
                              child: Column(children: [
                                Container(
                                  width: 70,
                                  height: 20,
                                  margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                                  child: Text(
                                    "Shared Observations",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 9,
                                      color: Color.fromARGB(255, 44, 94, 70),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                  child: Text(
                                    "4",
                                    style: TextStyle(
                                        fontFamily: "Fatface",
                                        fontSize: 35,
                                        color: Color.fromRGBO(255, 138, 0, 1)),
                                  ),
                                )
                              ]),
                            ),
                            Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Color.fromARGB(255, 249, 242, 233),
                              ),
                              child: Column(children: [
                                Container(
                                  width: 70,
                                  height: 20,
                                  margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                                  child: Text(
                                    "Successful Identifications",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 9,
                                      color: Color.fromARGB(255, 44, 94, 70),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                  child: Text(
                                    "9",
                                    style: TextStyle(
                                        fontFamily: "Fatface",
                                        fontSize: 35,
                                        color: Color.fromRGBO(255, 138, 0, 1)),
                                  ),
                                )
                              ]),
                            )
                          ],
                        ),
                      ),
                      Container(
                          margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                          child: Column(children: [
                            Container(
                              margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                      width: 100.0,
                                      height: 100.0,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                            15), // Image border
                                        child: SizedBox.fromSize(
                                          child: Image.asset(
                                              "assets/img/Plant10.jpg",
                                              width: 100.0,
                                              height: 100.0,
                                              fit: BoxFit.cover),
                                        ),
                                      )),
                                  Container(
                                      width: 100.0,
                                      height: 100.0,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                            15), // Image border
                                        child: SizedBox.fromSize(
                                          child: Image.asset(
                                              "assets/img/Plant1.jpg",
                                              width: 100.0,
                                              height: 100.0,
                                              fit: BoxFit.cover),
                                        ),
                                      )),
                                  Container(
                                      width: 100.0,
                                      height: 100.0,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                            15), // Image border
                                        child: SizedBox.fromSize(
                                          child: Image.asset(
                                              "assets/img/Plant6.jpg",
                                              width: 100.0,
                                              height: 100.0,
                                              fit: BoxFit.cover),
                                        ),
                                      )),
                                ],
                              ),
                            ),
                            Container(
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                      width: 100.0,
                                      height: 100.0,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                            15), // Image border
                                        child: SizedBox.fromSize(
                                          child: Image.asset(
                                              "assets/img/Plant3.jpg",
                                              width: 100.0,
                                              height: 100.0,
                                              fit: BoxFit.cover),
                                        ),
                                      )),
                                  Container(
                                      width: 100.0,
                                      height: 100.0,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                            15), // Image border
                                        child: SizedBox.fromSize(
                                          child: Image.asset(
                                              "assets/img/Plant9.jpg",
                                              width: 100.0,
                                              height: 100.0,
                                              fit: BoxFit.cover),
                                        ),
                                      )),
                                  Container(
                                      width: 100.0,
                                      height: 100.0,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                            15), // Image border
                                        child: SizedBox.fromSize(
                                          child: Image.asset(
                                              "assets/img/Plant7.jpg",
                                              width: 100.0,
                                              height: 100.0,
                                              fit: BoxFit.cover),
                                        ),
                                      )),
                                ],
                              ),
                            )
                          ]))
                    ]),
                  )),

              Positioned(
                // Icon Setting
                top: 230,
                right: 30,
                child: Container(
                  // decoration: BoxDecoration(border: Border.all(color: Colors.red)),
                  child: IconButton(
                    // TODO: Bug
                    icon: Icon(
                      Icons.settings_outlined,
                      size: 30,
                      color: Colors.orange,
                    ),
                    onPressed: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return SettingPage();
                      }));
                    },
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}