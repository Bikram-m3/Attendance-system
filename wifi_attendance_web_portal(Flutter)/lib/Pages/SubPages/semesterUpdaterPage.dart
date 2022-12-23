import 'package:flutter/material.dart';

import '../../ApiManagers/SubjectApi.dart';

class semesterUpdaterPage extends StatefulWidget {
  final String routeName;

  const semesterUpdaterPage({Key? key, required this.routeName})
      : super(key: key);

  @override
  State<semesterUpdaterPage> createState() => _semesterUpdaterPageState();
}

class _semesterUpdaterPageState extends State<semesterUpdaterPage> {
  var departmentItems = ['BECE', 'BECIVIL', 'BEIT', 'BCA', 'BEELX', 'BESE'];
  var dropDownItems = ['1', '2', '3', '4', '5', '6', '7', '8'];
  var shiftdropDownItems = ['Morning', 'Day'];
  var byItems = ['Update', 'Downgrade'];
  String byValue = 'Update',
      filterdepartdropdownValue = 'BECE',
      dropdownValue = '1',
      shiftdropdownValue = 'Morning';

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(left: 3),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.6),
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Options :",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                width: 12,
              ),
              DropdownButton(
                  value: byValue,
                  items: byItems.map((String item) {
                    return DropdownMenuItem(value: item, child: Text(item));
                  }).toList(),
                  onChanged: (String? newvalue) {
                    setState(() {
                      byValue = newvalue!;
                    });
                  }),
            ],
          ),

          const SizedBox(
            height: 20,
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //depart dropdown....................
              const Text(
                "Department :",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                width: 8,
              ),
              DropdownButton(
                  value: filterdepartdropdownValue,
                  items: departmentItems.map((String item) {
                    return DropdownMenuItem(value: item, child: Text(item));
                  }).toList(),
                  onChanged: (String? newvalue) {
                    setState(() {
                      filterdepartdropdownValue = newvalue!;
                    });
                  }),
              const SizedBox(
                width: 10,
              ),

              //semester dropdown.....................
              const Text(
                "Semester :",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                width: 8,
              ),
              DropdownButton(
                  value: dropdownValue,
                  items: dropDownItems.map((String item) {
                    return DropdownMenuItem(value: item, child: Text(item));
                  }).toList(),
                  onChanged: (String? value) {
                    setState(() {
                      dropdownValue = value!;
                    });
                  }),
              const SizedBox(
                width: 10,
              ),

              //shift dropdown...........
              const Text(
                "Shift :",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                width: 8,
              ),
              DropdownButton(
                  value: shiftdropdownValue,
                  items: shiftdropDownItems.map((String item) {
                    return DropdownMenuItem(value: item, child: Text(item));
                  }).toList(),
                  onChanged: (String? value) {
                    setState(() {
                      shiftdropdownValue = value!;
                    });
                  }),
            ],
          ),

          const SizedBox(
            height: 40,
          ),

          //button....................................
          TextButton(
            style: TextButton.styleFrom(
              primary: Colors.white,
              backgroundColor: Colors.teal,
              onSurface: Colors.grey,
            ),
            child: const Text('Update Semester'),
            onPressed: () {
              print(byValue);
              print(filterdepartdropdownValue);
              print(shiftdropdownValue);
              print(dropdownValue);

              if (byValue == "Update") {
                if (dropdownValue == '8') {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          content: Container(
                            height: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(
                                  Icons.not_interested,
                                  color: Colors.red,
                                  size: 80,
                                ),
                                Text("Can't Update..!!"),
                              ],
                            ),
                          ),
                          actions: [
                            TextButton(
                              style: TextButton.styleFrom(
                                primary: Colors.white,
                                backgroundColor: Colors.teal,
                                onSurface: Colors.grey,
                              ),
                              child: const Text('OK'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      });
                } else {
                  int oldSem = int.parse(dropdownValue);
                  int newSem = oldSem + 1;

                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          content: Container(
                            height: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(
                                  Icons.cloud_done_rounded,
                                  color: Colors.red,
                                  size: 80,
                                ),
                                Text("Are you Sure..??"),
                              ],
                            ),
                          ),
                          actions: [
                            TextButton(
                              style: TextButton.styleFrom(
                                primary: Colors.white,
                                backgroundColor: Colors.teal,
                                onSurface: Colors.grey,
                              ),
                              child: const Text('Yes'),
                              onPressed: () {
                                SubjectApi()
                                    .semesterUpdate(
                                        filterdepartdropdownValue,
                                        shiftdropdownValue,
                                        oldSem.toString(),
                                        newSem.toString())
                                    .then((value) => {
                                          showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  content: Container(
                                                    height: 150,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                    ),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        const Icon(
                                                          Icons.not_interested,
                                                          color: Colors.red,
                                                          size: 80,
                                                        ),
                                                        Text(value),
                                                      ],
                                                    ),
                                                  ),
                                                  actions: [
                                                    TextButton(
                                                      style:
                                                          TextButton.styleFrom(
                                                        primary: Colors.white,
                                                        backgroundColor:
                                                            Colors.teal,
                                                        onSurface: Colors.grey,
                                                      ),
                                                      child: const Text('OK'),
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                    ),
                                                  ],
                                                );
                                              })
                                        });
                              },
                            ),
                            TextButton(
                              style: TextButton.styleFrom(
                                primary: Colors.white,
                                backgroundColor: Colors.teal,
                                onSurface: Colors.grey,
                              ),
                              child: const Text('No'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            )
                          ],
                        );
                      });
                }
              } else {
                if (dropdownValue == '1') {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          content: Container(
                            height: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              mainAxisAlignment:
                              MainAxisAlignment.center,
                              children: const [
                                Icon(
                                  Icons.not_interested,
                                  color: Colors.red,
                                  size: 80,
                                ),
                                Text("Can't Downgrade..!!"),
                              ],
                            ),
                          ),
                          actions: [
                            TextButton(
                              style: TextButton.styleFrom(
                                primary: Colors.white,
                                backgroundColor: Colors.teal,
                                onSurface: Colors.grey,
                              ),
                              child: const Text('OK'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      });
                } else {
                  int oldSem = int.parse(dropdownValue);
                  int newSem = oldSem - 1;

                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          content: Container(
                            height: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(
                                  Icons.cloud_done_rounded,
                                  color: Colors.red,
                                  size: 80,
                                ),
                                Text("Are you Sure..??"),
                              ],
                            ),
                          ),
                          actions: [
                            TextButton(
                              style: TextButton.styleFrom(
                                primary: Colors.white,
                                backgroundColor: Colors.teal,
                                onSurface: Colors.grey,
                              ),
                              child: const Text('Yes'),
                              onPressed: () {
                                SubjectApi()
                                    .semesterUpdate(
                                    filterdepartdropdownValue,
                                    shiftdropdownValue,
                                    oldSem.toString(),
                                    newSem.toString())
                                    .then((value) => {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          content: Container(
                                            height: 150,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(
                                                  20),
                                            ),
                                            child: Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .center,
                                              children: [
                                                const Icon(
                                                  Icons.not_interested,
                                                  color: Colors.red,
                                                  size: 80,
                                                ),
                                                Text(value),
                                              ],
                                            ),
                                          ),
                                          actions: [
                                            TextButton(
                                              style:
                                              TextButton.styleFrom(
                                                primary: Colors.white,
                                                backgroundColor:
                                                Colors.teal,
                                                onSurface: Colors.grey,
                                              ),
                                              child: const Text('OK'),
                                              onPressed: () {
                                                Navigator.of(context)
                                                    .pop();
                                              },
                                            ),
                                          ],
                                        );
                                      })
                                });
                              },
                            ),
                            TextButton(
                              style: TextButton.styleFrom(
                                primary: Colors.white,
                                backgroundColor: Colors.teal,
                                onSurface: Colors.grey,
                              ),
                              child: const Text('No'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            )
                          ],
                        );
                      });

                }
              }
            },
          ),
        ],
      ),
    );
  }
}
