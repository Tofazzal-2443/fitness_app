import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/exercises_model.dart';

class CustomHttpRequest{



  static Future<ExercisesModel> fetchHomeData() async {
    String url =
        "https://raw.githubusercontent.com/codeifitech/fitness-app/master/exercises.json? fbclid=IwAR1s0681ePa8Rr60_MM04G4Hnpp8MlweW4DKO-SOawqKbIB2nIR98cBzpT8";
    ExercisesModel? exercisesModel;
    var responce = await http.get(Uri.parse(url));
    var data = jsonDecode(responce.body);
    exercisesModel = ExercisesModel.fromJson(data);
    return exercisesModel!;
  }
}