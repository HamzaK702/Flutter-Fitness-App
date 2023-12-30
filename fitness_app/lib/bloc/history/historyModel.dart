class WorkoutDetail {
  final String name;
  final DateTime date;

  WorkoutDetail({required this.name, required this.date});

  factory WorkoutDetail.fromJson(Map<String, dynamic> json) {
    return WorkoutDetail(
      name: json['name'],
      date: DateTime.parse(json['date']),
    );
  }
}

class WorkoutHistory {
  final String userId;
  final List<WorkoutDetail> previousWorkouts;

  WorkoutHistory({required this.userId, required this.previousWorkouts});

  factory WorkoutHistory.fromJson(Map<String, dynamic> json) {
    var list = json['previousWorkouts'] as List;
    List<WorkoutDetail> workoutList = list.map((i) => WorkoutDetail.fromJson(i)).toList();
    return WorkoutHistory(
      userId: json['userId'],
      previousWorkouts: workoutList,
    );
  }
}
