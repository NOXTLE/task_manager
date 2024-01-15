import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:log/appProvider.dart';
import 'package:provider/provider.dart';

class Completed extends StatelessWidget {
  const Completed({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProviderApp>(builder: (context, val, child) {
      print(val.completedDate);
      print(val.completedList);
      if (val.completedList.isEmpty) {
        var box = Hive.box("completeqq1z0");
        for (int a = 0; a < box.length; a++) {
          val.completedList.add(box.get(a));
        }
      }
      return Scaffold(
          backgroundColor: Colors.green,
          body: ListView.builder(
              itemCount: val.completedList.length,
              itemBuilder: (context, index) {
                return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 100,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: const Color.fromARGB(255, 142, 224, 145)),
                        child: Row(children: [
                          const Icon(Icons.task_alt,
                              size: 50, color: Colors.green),
                          const SizedBox(
                            width: 50,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  "Task: ${val.completedList[index][0]["Task"]}",
                                  style: GoogleFonts.robotoMono(
                                      textStyle: const TextStyle(
                                          fontSize: 24,
                                          color:
                                              Color.fromARGB(255, 2, 40, 22)))),
                              const SizedBox(
                                width: 40,
                              ),
                              Text(
                                  "Started: ${val.completedList[index][0]["Start"]}",
                                  style: GoogleFonts.robotoMono(
                                      textStyle: const TextStyle(
                                          fontSize: 18,
                                          color:
                                              Color.fromARGB(255, 2, 40, 22)))),
                              Text(
                                  "ended: ${val.completedList[index][1].toString()}",
                                  maxLines: 1,
                                  style: GoogleFonts.robotoMono(
                                      textStyle: const TextStyle(
                                          overflow: TextOverflow.fade,
                                          fontSize: 18,
                                          color:
                                              Color.fromARGB(255, 2, 40, 22))))
                            ],
                          ),
                        ])));
              }));
    });
  }
}
