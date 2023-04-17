import 'dart:io';

import 'package:fitness_app/add_exercise_form.dart';
import 'package:fitness_app/add_program_form.dart';
import 'package:flutter/material.dart';
import 'package:fitness_app/models/excercise_model.dart';
import 'package:fitness_app/models/program_model.dart';

class ProgramDashboard extends StatefulWidget {
  const ProgramDashboard({Key? key}) : super(key: key);

  @override
  State<ProgramDashboard> createState() => _ProgramDashboardState();
}

class _ProgramDashboardState extends State<ProgramDashboard> {
  var heightsize, widthsize;
  List<ProgramModel> _programlist = []; // display list of programs
  List<ExerciseModel> _exerciselist =
      []; // for maintaining records of exercise list
  List<String> exerciseNameList = []; // display exercisenames in dropdown menu
  List<ExerciseModel> _exerciseProgramList =
      []; // display program specific exercise list
  TextEditingController programNameController = new TextEditingController();
  TextEditingController exerciseNameController = new TextEditingController();
  TextEditingController imageUrlController = new TextEditingController();
  List<bool> isExpandlist =
      []; // for show / hide exercise list in each program item
  String?
      selectedExerciseName; // for showing selected exercise name from dropdown name

  @override
  Widget build(BuildContext context) {
    heightsize = MediaQuery.of(context).size.height;
    widthsize = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          height: heightsize,
          width: widthsize,
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        // result based on program name added successful or not
                        bool isProgramAdd = await showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              return AddProgramForm(
                                programNameController: programNameController,
                                isEdit: false,
                                list: _programlist,
                              );
                            });
                        if (isProgramAdd) {
                          setState(() {
                            _programlist
                                .add(ProgramModel(programNameController.text));
                            isExpandlist.add(
                                false); // by default program list item will be in hide mode
                            print(_programlist
                                .length); // to check program name is added into list or not
                          });
                        }
                        setState(() {
                          programNameController.clear();
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          "Create Program",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.normal,
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        // result based on exercise added successful or not
                        bool isProgramAdd = await showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              return AddExerciseForm(
                                exerciseNameController: exerciseNameController,
                                list: _exerciselist,
                                imageUrlController: imageUrlController,
                              );
                            });
                        if (isProgramAdd) {
                          setState(() {
                            _exerciselist.add(ExerciseModel.OnlyExercise(
                                exerciseNameController.text,
                                File(imageUrlController.text)));
                            exerciseNameList.add(exerciseNameController.text);
                            if (exerciseNameList.isEmpty) {
                              selectedExerciseName =
                                  ''; // if name list empty, then display hint in dropdown menu
                            } else {
                              if (exerciseNameList.length ==
                                  1) // if name list contains one item, then displau first item as default value in dropdown menu
                                selectedExerciseName = exerciseNameList[0];
                            }
                            print(
                                '${_exerciselist.length} ${exerciseNameList.length}');
                          });
                        }
                        setState(() {
                          exerciseNameController.clear();
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          "Create Exercise",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.normal,
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Programs List',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.teal,
                      fontSize: 20.0,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: _programlist.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 10, right: 10),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromRGBO(0, 0, 0, 0.3),
                              blurRadius: 11,
                              offset: Offset(-1, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  _programlist[index].name.toString(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18.0,
                                  ),
                                ),
                                Spacer(),
                                Row(
                                  children: [
                                    InkWell(
                                      onTap: () async {
                                        setState(() {
                                          // display current program name in edit program name popup form
                                          programNameController.text =
                                              _programlist[index]
                                                  .name
                                                  .toString();
                                        });
                                        bool isProgramAdd = await showDialog(
                                            context: context,
                                            barrierDismissible: false,
                                            builder: (BuildContext context) {
                                              return AddProgramForm(
                                                programNameController:
                                                    programNameController,
                                                isEdit: true,
                                                list: _programlist,
                                              );
                                            });
                                        if (isProgramAdd) {
                                          setState(() {
                                            if (_exerciseProgramList
                                                .isNotEmpty) {
                                              //checking exercise list is not empty
                                              _exerciseProgramList
                                                  .forEach((element) {
                                                // looping through each item of exercise list
                                                if (element.program_name ==
                                                    _programlist[index].name) {
                                                  //comparing exercise list's program name with current program name
                                                  element.program_name =
                                                      programNameController
                                                          .text; // updating exercise list's program name
                                                }
                                              });
                                            }
                                            // remove program from list and adding new program name
                                            _programlist.removeAt(index);
                                            _programlist.add(ProgramModel(
                                                programNameController.text));
                                            print(_programlist.length);
                                          });
                                        }
                                        setState(() {
                                          programNameController.clear();
                                        });
                                      },
                                      child: Icon(
                                        Icons.edit,
                                        size: 20,
                                        color: Colors.teal,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          // for getting indexes of exercises under current program
                                          List<int> _exerciseProgramIndex = [];
                                          if (_exerciseProgramList.isNotEmpty) {
                                            _exerciseProgramList
                                                .forEach((element) {
                                              if (element.program_name ==
                                                  _programlist[index].name) {
                                                _exerciseProgramIndex.add(
                                                    _exerciseProgramList
                                                        .indexOf(element));
                                              }
                                            });
                                            // removing all exercises under current program
                                            _exerciseProgramIndex
                                                .forEach((element) {
                                              _exerciseProgramList
                                                  .removeAt(element);
                                            });
                                          }
                                          _programlist.removeAt(
                                              index); //removing program using current index
                                        });
                                      },
                                      child: Icon(
                                        Icons.delete,
                                        size: 20,
                                        color: Colors.teal,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          // show / hide exercise list and dropdown menu
                                          isExpandlist[index] =
                                              !isExpandlist[index];
                                        });
                                      },
                                      child: Icon(
                                        isExpandlist[index]
                                            ? Icons.expand_less
                                            : Icons.expand_more,
                                        size: 30,
                                        color: Colors.teal,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            isExpandlist[index]
                                ? SizedBox(
                                    height: 20,
                                  )
                                : Container(),
                            isExpandlist[index]
                                ? Row(
                                    children: [
                                      SizedBox(
                                        width: 40,
                                      ),
                                      DropdownButton(
                                        items: exerciseNameList.map((e) {
                                          return DropdownMenuItem<String>(
                                            child: Text(e),
                                            value: e,
                                          );
                                        }).toList(),
                                        hint: Text('Select Exercise'),
                                        value: selectedExerciseName,
                                        onChanged: (value) {
                                          setState(() {
                                            selectedExerciseName =
                                                value.toString();
                                            print(selectedExerciseName);
                                          });
                                        },
                                      ),
                                      Spacer(),
                                      ElevatedButton(
                                        onPressed: () {
                                          setState(() {
                                            // get index of currently selected exercise name from dropdown menu
                                            int getSelectedExerciseIndex = -1;
                                            if (_exerciselist.isNotEmpty) {
                                              _exerciselist.forEach((element) {
                                                if (element.name ==
                                                    selectedExerciseName) {
                                                  getSelectedExerciseIndex =
                                                      _exerciselist
                                                          .indexOf(element);
                                                }
                                              });
                                            }
                                            _exerciseProgramList.add(ExerciseModel(
                                                selectedExerciseName,
                                                _exerciselist[
                                                        getSelectedExerciseIndex]
                                                    .image_url,
                                                _programlist[index].name));
                                            print(_exerciseProgramList.length);
                                          });
                                        },
                                        style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            "Add",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.normal,
                                              fontSize: 20.0,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                    ],
                                  )
                                : Container(),
                            isExpandlist[index]
                                ? SizedBox(
                                    height: 20,
                                  )
                                : Container(),
                            // exercise list under particular program is shown only if exercise list not empty
                            if (isExpandlist[index] &&
                                _exerciseProgramList.isNotEmpty) ...[
                              ListView.builder(
                                itemCount: _exerciseProgramList.length,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, _index) {
                                  // checking program name with exercise program name and display that exercise list item under that program name
                                  return _programlist[index].name ==
                                          _exerciseProgramList[_index]
                                              .program_name
                                      ? Column(
                                          children: [
                                            Row(
                                              children: [
                                                SizedBox(
                                                  width: 40,
                                                ),
                                                Container(
                                                  width: 50,
                                                  height: 50,
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                      image: FileImage(
                                                          _exerciseProgramList[
                                                                  _index]
                                                              .image_url!),
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 20,
                                                ),
                                                Text(
                                                  _exerciseProgramList[_index]
                                                      .name
                                                      .toString(),
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 18.0,
                                                  ),
                                                ),
                                                Spacer(),
                                                InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      _exerciseProgramList.removeAt(
                                                          _index); // removing exercise list item
                                                    });
                                                  },
                                                  child: Icon(
                                                    Icons.delete,
                                                    size: 20,
                                                    color: Colors.teal,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 20,
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 15,
                                            ),
                                          ],
                                        )
                                      : Container();
                                },
                              ),
                            ],
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
