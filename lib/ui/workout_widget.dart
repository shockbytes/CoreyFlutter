import 'package:Corey/data/workout/firebase_workout_repository.dart';
import 'package:Corey/data/workout/workout_repository.dart';
import 'package:Corey/model/workout.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class WorkoutWidget extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _WorkoutWidgetState();
}

class _WorkoutWidgetState extends State<WorkoutWidget> {

  List<Workout> _cachedWorkouts = new List();
  List<Workout> _workouts = List();

  WorkoutRepository _workoutRepository = FirebaseWorkoutRepository(
      FirebaseAuth.instance);


  _newWorkoutAvailable(Workout w) {
    print(w.name);
    _cachedWorkouts.add(w);

    setState(() {
      _workouts = List.from(_cachedWorkouts);
    });
  }

  @override
  void initState() {
    super.initState();

    _workoutRepository.getWorkouts().listen(_newWorkoutAvailable);
  }

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
        itemCount: _workouts.length,
        itemBuilder: (BuildContext ctxt, int index) {
          return new Text(_workouts[index].name);
        }
    );
  }

}