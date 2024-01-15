import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:log/appProvider.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class listTile extends StatefulWidget {
  listTile(
      {super.key,
      required this.title,
      required this.start,
      required this.end,
      required this.Index,
      required this.isChecked});
  String title;
  String start;
  String? end;
  int Index;
  bool isChecked;

  @override
  State<listTile> createState() => _listTileState();
}

class _listTileState extends State<listTile> {
  @override
  @override
  Widget build(BuildContext context) {
    return Consumer<ProviderApp>(builder: (context, val, child) {
      return Container(
        height: 120,
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 234, 192, 128),
            borderRadius: BorderRadius.circular(20)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.transparent,
            ),
            child: Container(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(20)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Checkbox(
                      value: widget.isChecked,
                      activeColor: Colors.green,
                      shape: CircleBorder(eccentricity: 0.8),
                      onChanged: (val) {
                        setState(() {
                          widget.isChecked = !widget.isChecked;
                        });
                      }),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.rebase_edit),
                            Text(" ${widget.title}",
                                style: GoogleFonts.robotoMono(
                                    textStyle: TextStyle(
                                        fontSize: 24,
                                        decoration: widget.isChecked == true
                                            ? TextDecoration.lineThrough
                                            : TextDecoration.none))),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.calendar_month, color: Colors.green),
                            Text(" ${widget.start}",
                                style: GoogleFonts.robotoMono(
                                  color: Colors.green,
                                  textStyle: TextStyle(
                                      fontSize: 24,
                                      decoration: widget.isChecked == true
                                          ? TextDecoration.lineThrough
                                          : TextDecoration.none),
                                )),
                          ],
                        ),
                        widget.end == ""
                            ? Text("")
                            : Row(
                                children: [
                                  Icon(
                                    Icons.date_range,
                                    color: Colors.red,
                                    size: 24,
                                  ),
                                  Text(
                                    " ${widget.end}",
                                    style: GoogleFonts.robotoMono(
                                        textStyle: TextStyle(
                                            color: Colors.red,
                                            fontSize: 24,
                                            decoration: widget.isChecked == true
                                                ? TextDecoration.lineThrough
                                                : TextDecoration.none)),
                                  ),
                                ],
                              ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 40,
                  ),
                  widget.isChecked == true
                      ? IconButton(
                          onPressed: () {
                            val.delete(widget.Index);
                          },
                          icon: Icon(
                            Icons.delete,
                            color: Colors.green,
                          ))
                      : Container()
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
