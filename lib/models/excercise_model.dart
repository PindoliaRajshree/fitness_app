import 'dart:io';

class ExerciseModel {
  String? name;
  File? image_url;
  String? program_name;

  ExerciseModel.OnlyExercise(
      this.name, this.image_url); // to add only exercise details

  ExerciseModel(this.name, this.image_url,
      this.program_name); // to add exercise details for particular program
}
