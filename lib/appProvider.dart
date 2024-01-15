import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

class ProviderApp extends ChangeNotifier {
  int index = 0;
  void changeIndex(val) {
    index = val;
    notifyListeners();
  }

  bool isChecked = false;
  bool isz = false;

  var controller = TextEditingController();
  var end = TextEditingController();
  var te = TextEditingController();

  Future chooseDate(context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      controller.text = picked.toString().split(" ")[0];
    }
  }

  Future endDate(context) async {
    DateTime? value = await showDatePicker(
        context: context,
        firstDate: DateTime(2000),
        lastDate: DateTime(2100),
        initialDate: DateTime.now());

    if (value != null) {
      end.text = value.toString().split(" ")[0];
    }
  }

  var dataval = [];

//adds data
  void data(context) {
    var data = Hive.box("taskaa");
    data.add({"Task": te.text, "Start": controller.text, "end": end.text});
    dataval.add({"Task": te.text, "Start": controller.text, "end": end.text});
    te.clear();
    end.clear();
    controller.clear();
    Navigator.pop(context);
    notifyListeners();
  }

  var completedList = [];
  var completedDate = [];
  void delete(index) {
    var box = Hive.box("taskaa");
    var box1 = Hive.box("completeqq1z0");
    var value = box.getAt(index);
    box1.add([value, DateFormat('yMd').format(DateTime.now())]);
    completedList.add([value, DateFormat('yMd').format(DateTime.now())]);

    box.deleteAt(index);
    dataval.removeAt(index);
    notifyListeners();
  }

  void showAnimate(BuildContext context) {
    showGeneralDialog(
        context: context,
        pageBuilder: (context, animation1, animation2) {
          return Container();
        },
        transitionBuilder: (context, a1, a2, widget) {
          return StatefulBuilder(
            builder: (context, state) => ScaleTransition(
              scale: Tween<double>(begin: 0.0, end: 1.0).animate(a1),
              child: FadeTransition(
                opacity: Tween<double>(begin: 0.0, end: 1).animate(a1),
                child: AlertDialog(
                  backgroundColor: Colors.orange,
                  title: const Center(child: Text("Add Your Task")),
                  content: Container(
                    height: 260,
                    width: 400,
                    child: Column(children: [
                      TextField(
                        controller: te,
                        decoration: const InputDecoration(
                            hintText: "Task ",
                            border: OutlineInputBorder(),
                            filled: true,
                            fillColor: Color.fromARGB(255, 238, 223, 199)),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextField(
                        controller: controller,
                        onTap: () {
                          chooseDate(context);
                        },
                        readOnly: true,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.calendar_month),
                          label: Text("Starting Date"),
                          filled: true,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Add An Ending Date?"),
                          Checkbox(
                              value: isz,
                              onChanged: (value) {
                                state(() => isz = !isz);

                                notifyListeners();
                              }),
                        ],
                      ),
                      Visibility(
                        maintainSize: false,
                        maintainAnimation: true,
                        maintainState: true,
                        visible: isz,
                        child: Expanded(
                          child: TextField(
                            controller: end,
                            onTap: () {
                              endDate(context);
                            },
                            readOnly: true,
                            decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.calendar_month),
                              label: Text("Ending Date"),
                              filled: true,
                            ),
                          ),
                        ),
                      ),
                    ]),
                  ),
                  actions: [
                    ElevatedButton(
                        onPressed: () {
                          data(context);
                        },
                        child: const Text("Add Task")),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Close"))
                  ],
                ),
              ),
            ),
          );
        });
  }
}
