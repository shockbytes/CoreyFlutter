

import 'package:Corey/data/workout/workout_repository.dart';
import 'package:Corey/model/exercise.dart';
import 'package:Corey/model/workout.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class FirebaseWorkoutRepository implements WorkoutRepository {

  FirebaseAuth _auth;
  DatabaseReference _workoutRef;

  List<Workout> _workouts = new List();

  Stream<List<Workout>> _workoutStream;

  FirebaseWorkoutRepository(this._auth) {
    //_workoutStream = Stream.fromIterable(_workouts.iterator);
    _setupFirebase();
  }

  @override
  deleteWorkout(Workout workout) {
    // TODO: implement deleteWorkout
    return null;
  }

  @override
  Stream<List<Exercise>> getExercises() {
    // TODO: implement getExercises
    return null;
  }

  @override
  Stream<Workout> getWorkouts() {
    return _workoutRef.onChildAdded
        .map((event) => Workout.fromMap(event.snapshot.value, event.snapshot.key));
  }

  @override
  storeWorkout(Workout workout) {
    // TODO: implement storeWorkout
    return null;
  }

  @override
  updateWorkout(Workout workout) {
    // TODO: implement updateWorkout
    return null;
  }

  _setupFirebase() {

    _workoutRef = FirebaseDatabase.instance.reference().child("workout");
    FirebaseDatabase.instance.setPersistenceEnabled(true);
    FirebaseDatabase.instance.setPersistenceCacheSizeBytes(10000000);

    _workoutRef.keepSynced(true);
    _workoutRef.onChildAdded.listen(_newWorkout);

    _workoutRef.onValue.listen((Event event) {
      print(event.snapshot.value.toString());
    });

    /*
    _counterSubscription = _counterRef.onValue.listen((Event event) {
      setState(() {
        _error = null;
        _counter = event.snapshot.value ?? 0;
      });
    }, onError: (Object o) {
      final DatabaseError error = o;
      setState(() {
        _error = error;
      });
    });
    _messagesSubscription =
        _messagesRef.limitToLast(10).onChildAdded.listen((Event event) {
          print('Child added: ${event.snapshot.value}');
        }, onError: (Object o) {
          final DatabaseError error = o;
          print('Error: ${error.code} ${error.message}');
        });
    */
  }

  void _newWorkout(event) {

    print(event);
    // Workout workout = new Workout.fromMap(event.snapshot.val(), event.snapshot.key);
    // _workouts.add(workout);
  }
  
  _teardownFirebase() {
    // TODO
  }

}