import 'package:fitness_app/models/program_model.dart';
import 'package:flutter/material.dart';

class AddProgramForm extends StatefulWidget {
  final TextEditingController programNameController;
  final bool? isEdit;
  final List<ProgramModel> list;

  const AddProgramForm(
      {Key? key,
      required this.programNameController,
      this.isEdit, // to check whether it is Insert or Update form
      required this.list}) // to check for duplicate program names
      : super(key: key);

  @override
  State<AddProgramForm> createState() => _AddProgramFormState();
}

class _AddProgramFormState extends State<AddProgramForm> {
  var formKey = GlobalKey<FormState>();

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
                        widget.isEdit!
                            ? 'Edit Fitness Programs'
                            : 'Add Fitness Programs',
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
                        controller: widget.programNameController,
                        cursorColor: Colors.black,
                        validator: (String? value) {
                          bool result = false;
                          widget.list.forEach((element) {
                            // looping through program name list
                            if (element.name == value)
                              result = true; // to find duplicate name from list
                          });
                          if (value!.isEmpty) {
                            return 'Please Enter Program Name';
                          } else if (result) {
                            return 'Program Name Already Exist';
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
                          hintText: "Program Name",
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
                            Navigator.of(context)
                                .pop(true); // close popup form with result true
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
                            widget.isEdit! ? "Save" : "Add",
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
}
