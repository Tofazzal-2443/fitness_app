
import 'package:flutter/material.dart';

import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class StartExercisesPage extends StatefulWidget {
  const StartExercisesPage({
    Key? key,
  }) : super(key: key);
  static const String routeName = '/startExercisesPage';

  @override
  State<StartExercisesPage> createState() => _StartExercisesPageState();
}

class _StartExercisesPageState extends State<StartExercisesPage> {
  double second = 5;

  @override
  Widget build(BuildContext context) {
    final imageUrl = ModalRoute.of(context)!.settings.arguments as String;

    //final provider = Provider.of<ExercisesProvider>(context);
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Stack(
          children: [
            SizedBox(
              height: double.infinity,
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 50,
              child: Column(
                children: [
                  SleekCircularSlider(
                    min: 0,
                    max: 50,
                    initialValue: 5,
                    onChange: (double value) {
                      setState(() {
                        second = value;
                      });
                      // callback providing a value while its being changed (with a pan gesture)
                    },
                    onChangeStart: (double startValue) {
                      // callback providing a starting value (when a pan gesture starts)
                    },
                    onChangeEnd: (double endValue) {
                      // ucallback providing an ending value (when a pan gesture ends)
                    },
                    innerWidget: (double value) {
                      return Center(
                        child: Text(
                          second.toStringAsFixed(0),
                          style: const TextStyle(
                            color: Colors.redAccent,
                            fontSize: 45,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      );
                      // use your custom widget inside the slider (gets a slider value from the callback)
                    },
                  ),
                  ElevatedButton(onPressed: (){}, child: const Text("Start", style: TextStyle(fontSize: 30),),)
                ],
              ),

            ),
          ],
        ),
      ),
    );
  }
}
