

import 'package:Corey/model/exercise.dart';
import 'package:Corey/model/workout.dart';

abstract class WorkoutRepository {

  Stream<Workout> getWorkouts();

  Stream<List<Exercise>> getExercises();

  storeWorkout(Workout workout);

  deleteWorkout(Workout workout);

  updateWorkout(Workout workout);

}