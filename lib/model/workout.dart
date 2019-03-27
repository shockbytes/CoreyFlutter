

class Workout {

  final String id;
  final String name;
  final String intensity;
  final String bodyRegion;


  Workout(this.id, this.name, this.bodyRegion, this.intensity);

  Workout.fromMap(Map map, String id)
      : this(id, map['name'].toString().replaceAll("_", " "), map["bodyRegion"], map["intensity"]);

  Map toMap() => {
    "name": name.replaceAll(" ", "_"),
    "bodyRegion": bodyRegion,
    "intensity": intensity
  };
}