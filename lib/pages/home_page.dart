import 'package:fitness_app/custom/custom_styles.dart';
import 'package:fitness_app/pages/start_exercises_page.dart';
import 'package:fitness_app/provider/exercises_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  static const String routeName = '/homePage';

  @override
  Widget build(BuildContext context) {
    final exProvider = Provider.of<ExercisesProvider>(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Fitness App'),
          centerTitle: true,
        ),
        body: SizedBox(
          width: double.infinity,
          child: ListView(
            children: [
              FutureBuilder(
                  future: exProvider.getHomeData(),
                  builder: (context, snapshot){
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return const Text("Something is wrong");
                } else if (snapshot.data == null) {
                  return const Text("snapshot data are null");
                }
                return ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: snapshot.data!.exercises!.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: (){
                          //Provider.of<ExercisesProvider>(context).setImageUrl(snapshot.data!.exercises![index].thumbnail);
                          Navigator.pushNamed(context, StartExercisesPage.routeName, arguments: snapshot.data!.exercises![index].thumbnail); //arguments: snapshot.data!.exercises![index].thumbnail
                        },
                        child: Container(
                          height: 200,
                          margin: const EdgeInsets.all(7),
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.network(
                                  "${snapshot.data!.exercises![index].thumbnail}",
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                left: 0,
                                right: 0,
                                top: 0,
                                child: Container(
                                  padding: const EdgeInsets.only(left: 10, bottom: 10),
                                  alignment: Alignment.bottomCenter,
                                  height: 200,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    gradient: const LinearGradient(
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter,
                                      colors: [
                                        Colors.black,
                                        Colors.transparent,
                                        Colors.transparent,
                                      ],
                                    ),
                                  ),
                                  child: Text("${snapshot.data!.exercises![index].title}", style: titleStyle,),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    });
              })
            ],
          ),
        ));
  }
}
