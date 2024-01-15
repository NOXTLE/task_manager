import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:log/appProvider.dart';
import 'package:log/listingz.dart';
import 'package:provider/provider.dart';

class OnGoing extends StatelessWidget {
  OnGoing({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProviderApp>(builder: (context, val, child) {
      if (val.dataval.isEmpty) {
        var box = Hive.box("taskaa");
        for (int a = 0; a < box.length; a++) {
          val.dataval.add(box.getAt(a));
        }
      }
      return Scaffold(
          backgroundColor: Colors.orange,
          body: Container(
              // Place as the child widget of a scaffold
              width: double.infinity,
              height: double.infinity,
              child: ListView.builder(
                  itemCount: val.dataval.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.all(10),
                      child: listTile(
                          isChecked: val.isChecked,
                          title: val.dataval[index]["Task"].toString(),
                          start: val.dataval[index]["Start"].toString(),
                          end: val.dataval[index]["end"].toString(),
                          Index: index),
                    );
                  })));
    });
  }
}
