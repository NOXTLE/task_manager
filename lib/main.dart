import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:log/appProvider.dart';
import 'package:log/page2.dart';
import 'package:log/page3.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  await Hive.initFlutter();
  await Hive.openBox("taskaa");
  await Hive.openBox("completeqq1z0");

  runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: (context) => ProviderApp())],
    child: const MaterialApp(
      home: MyApp(),
      debugShowCheckedModeBanner: false,
    ),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProviderApp>(
      builder: (context, val, child) => Scaffold(
        appBar: AppBar(
            backgroundColor: val.index == 0 ? Colors.orange : Colors.green,
            elevation: 0,
            centerTitle: true,
            title: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              val.index == 0
                  ? Text("On Going Tasks",
                      style: GoogleFonts.pacifico(
                          fontSize: 32,
                          textStyle: TextStyle(color: Colors.white)))
                  : Text("Completed Tasks",
                      style: GoogleFonts.pacifico(
                          textStyle: TextStyle(
                        fontSize: 32,
                        color: Colors.white,
                      ))),
              SizedBox(
                width: 10,
              ),
              Icon(
                Icons.edit_note_outlined,
                size: 40,
                color: Colors.white,
              ),
            ])),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: GestureDetector(
          onTap: () {
            val.showAnimate(context);
          },
          child: Container(
            child: Center(child: Text("+", style: TextStyle(fontSize: 24))),
            height: 50,
            width: 50,
            decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Color.fromARGB(255, 30, 30, 30),
                      offset: Offset(2, 10),
                      blurRadius: 10,
                      spreadRadius: 2),
                  // BoxShadow(
                  //   color: Colors.black,
                  //   offset: Offset(0, 0),
                  // )
                ],
                color: Colors.orange,
                borderRadius: BorderRadius.all(Radius.circular(50))),
          ),
        ),
        bottomNavigationBar: GNav(
            backgroundColor: val.index == 0 ? Colors.orange : Colors.green,
            iconSize: 24,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            padding: EdgeInsets.all(20),
            activeColor: val.index == 0
                ? Colors.yellow
                : Color.fromARGB(255, 5, 255, 14),
            tabs: [
              GButton(
                gap: 5,
                iconColor: Colors.yellow,
                padding: EdgeInsets.all(10),
                icon: Icons.watch_later_outlined,
                text: "OnGoing",
                backgroundColor: Color.fromARGB(255, 5, 53, 93),
                onPressed: () {
                  val.changeIndex(0);
                },
              ),
              GButton(
                iconColor: const Color.fromARGB(255, 5, 255, 14),
                gap: 5,
                margin: EdgeInsets.all(20),
                padding: EdgeInsets.all(10),
                backgroundColor: const Color.fromARGB(255, 5, 53, 93),
                icon: Icons.task_alt_sharp,
                text: "Completed",
                onPressed: () {
                  val.changeIndex(1);
                },
              )
            ]),
        body: Container(
            // Place as the child widget of a scaffold
            width: double.infinity,
            height: double.infinity,
            child: Container(
                child: Stack(alignment: Alignment.center, children: [
              IndexedStack(
                index: val.index,
                children: [OnGoing(), const Completed()],
              ),
              Positioned(
                bottom: 20,
                child: Stack(alignment: Alignment.center, children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Container(
                      width: MediaQuery.of(context).size.width / 1.5,
                      height: 80,
                    ),
                  ),
                ]),
              ),
            ]))),
      ),
    );
  }
}
