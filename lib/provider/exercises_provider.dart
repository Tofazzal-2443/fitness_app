import 'package:fitness_app/http/custom_http.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/exercises_model.dart';



class ExercisesProvider extends ChangeNotifier{
  ExercisesModel ?exercisesModel;
  Future<ExercisesModel> getHomeData() async {
    exercisesModel = await CustomHttpRequest.fetchHomeData();
    return exercisesModel!;
  }


}