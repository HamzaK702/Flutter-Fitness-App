class Workout {
  String id;
  String day;
  List<ExerciseDetail> warmUp;
  List<ExerciseDetail> exercises;
  List<ExerciseDetail> coolDown;

  Workout({
    required this.id,
    required this.day,
    required this.warmUp,
    required this.exercises,
    required this.coolDown,
  });

  factory Workout.fromJson(Map<String, dynamic> json) {
    return Workout(
      id: json['_id'],
      day: json['Day'],
      warmUp: (json['WarmUp'] as List<dynamic>)
          .map((i) => ExerciseDetail.fromJson(i))
          .toList(),
      exercises: (json['Exercises'] as List<dynamic>)
          .map((i) => ExerciseDetail.fromJson(i))
          .toList(),
      coolDown: (json['CoolDown'] as List<dynamic>)
          .map((i) => ExerciseDetail.fromJson(i))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['Day'] = this.day;
    data['WarmUp'] = this.warmUp.map((v) => v.toJson()).toList();
    data['Exercises'] = this.exercises.map((v) => v.toJson()).toList();
    data['CoolDown'] = this.coolDown.map((v) => v.toJson()).toList();
    return data;
  }
}


class ExerciseDetail {
  String id;
  String exercise;
  String? sets;
  String? reps;
  String? time;

  ExerciseDetail({
    required this.id,
    required this.exercise,
    this.sets,
    this.reps,
    this.time,
  });

  factory ExerciseDetail.fromJson(Map<String, dynamic> json) {
    return ExerciseDetail(
      id: json['_id'],
      exercise: json['Exercise'],
      sets: json['Sets'],
      reps: json['Reps'],
      time: json['Time'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['Exercise'] = this.exercise;
    if (this.sets != null) data['Sets'] = this.sets;
    if (this.reps != null) data['Reps'] = this.reps;
    if (this.time != null) data['Time'] = this.time;
    return data;
  }
}
