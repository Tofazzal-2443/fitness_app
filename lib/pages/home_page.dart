import 'package:fitness_app/custom/custom_styles.dart';
import 'package:fitness_app/provider/exercises_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  static const String routeName = '/homePage';

  @override
  Widget build(BuildContext context) {
    final exProvider = Provider.of<ExercisesProvider>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('Fitness App'),
          centerTitle: true,
        ),
        body: Container(
          width: double.infinity,
          child: ListView(
            children: [
              FutureBuilder(
                  future: exProvider.getHomeData(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return Text("Something is wrong");
                    } else if (snapshot.data == null) {
                      return Text("snapshot data are null");
                    }
                    return ListView.builder(
                        physics: BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: snapshot.data!.exercises!.length,
                        itemBuilder: (context, index) {
                          return Container(
                            height: 200,
                            margin: EdgeInsets.all(7),
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
                                    padding: EdgeInsets.only(left: 10, bottom: 10),
                                    alignment: Alignment.bottomCenter,
                                    child: Text("${snapshot.data!.exercises![index].title}", style: titleStyle,),
                                    height: 200,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      gradient: LinearGradient(
                                        begin: Alignment.bottomCenter,
                                        end: Alignment.topCenter,
                                        colors: [
                                          Colors.black,
                                          Colors.transparent,
                                          Colors.transparent,
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        });
                  }),
            ],
          ),
        ));
  }
}
