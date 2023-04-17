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
  List<ProgramModel> _programlist = [];
  List<ExerciseModel> _exerciselist = [];
  List<String> exerciseNameList = [];
  List<ExerciseModel> _exerciseProgramList = [];
  TextEditingController programNameController = new TextEditingController();
  TextEditingController exerciseNameController = new TextEditingController();
  TextEditingController imageUrlController = new TextEditingController();
  List<bool> isExpandlist = [];
  String? selectedExerciseName;

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
                            isExpandlist.add(false);
                            print(_programlist.length);
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
                              selectedExerciseName = '';
                            } else {
                              if (exerciseNameList.length == 1)
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
                                              _exerciseProgramList
                                                  .forEach((element) {
                                                if (element.program_name ==
                                                    _programlist[index].name) {
                                                  element.program_name =
                                                      programNameController
                                                          .text;
                                                }
                                              });
                                            }
                                            _programlist.removeAt(index);
                                            _programlist.add(ProgramModel(
                                                programNameController.text));
                                            print(_programlist);
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
                                            _exerciseProgramIndex
                                                .forEach((element) {
                                              _exerciseProgramList
                                                  .removeAt(element);
                                            });
                                          }
                                          _programlist.removeAt(index);
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
                            if (isExpandlist[index] &&
                                _exerciseProgramList.isNotEmpty) ...[
                              ListView.builder(
                                itemCount: _exerciseProgramList.length,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, _index) {
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
                                                      _exerciseProgramList
                                                          .removeAt(_index);
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
