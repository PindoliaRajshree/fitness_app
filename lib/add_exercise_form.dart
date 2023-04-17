import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:fitness_app/models/excercise_model.dart';
import 'package:flutter/material.dart';

class AddExerciseForm extends StatefulWidget {
  final TextEditingController exerciseNameController, imageUrlController;
  final List<ExerciseModel> list;

  const AddExerciseForm({
    Key? key,
    required this.exerciseNameController,
    required this.list, // to check for duplicate names from list
    required this.imageUrlController, // image url
  }) : super(key: key);

  @override
  State<AddExerciseForm> createState() => _AddExerciseFormState();
}

class _AddExerciseFormState extends State<AddExerciseForm> {
  var formKey = GlobalKey<FormState>();
  File? image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
          margin: EdgeInsets.only(left: 20, right: 20),
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 10,
                ),
                Stack(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Add Fitness Exercise',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.teal,
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        onTap: () {
                          // close popup form with result false
                          Navigator.of(context).pop(false);
                        },
                        child: Padding(
                          padding: EdgeInsets.only(right: 10),
                          child: Icon(
                            Icons.close,
                            size: 25,
                            color: Colors.teal,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: widget.exerciseNameController,
                        cursorColor: Colors.black,
                        validator: (String? value) {
                          bool result = false;
                          widget.list.forEach((element) {
                            // loop through list of exercise
                            if (element.name == value)
                              result = true; // find duplicates from list
                          });
                          if (value!.isEmpty) {
                            return 'Please Enter Exercise Name';
                          } else if (result) {
                            return 'Exercise Name Already Exists';
                          }
                          return null;
                        },
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                        decoration: InputDecoration(
                          isDense: true,
                          hintText: "Exercise Name",
                          hintStyle: TextStyle(
                            color: Colors.black54,
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black54,
                              width: 2.0,
                            ),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 2.0,
                            ),
                          ),
                        ),
                        textInputAction: TextInputAction.next,
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // open file picker to choose image from storage
                        getImage();
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Choose Image",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.normal,
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Text(
                        // to display image path if not null
                        image == null
                            ? 'No Image Selected'
                            : widget.imageUrlController.text,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
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
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            if (widget.imageUrlController.text.isEmpty) {
                              // if image null, display message to select image
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text(
                                  'Please Select Fitness Image',
                                ),
                                behavior: SnackBarBehavior.floating,
                              ));
                            } else {
                              // close popup form with result true
                              Navigator.of(context).pop(true);
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
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
                    ),
                    SizedBox(
                      width: 20,
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future getImage() async {
    //selecting image
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    setState(() {
      if (result != null) {
        image = File(result.files.single.path!); // getting image as file
        widget.imageUrlController.text =
            image!.path; // setting image path in form of file
        print(image!.path);
      }
    });
  }
}
