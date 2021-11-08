class WorkoutFilter {
  List<String>? basketballSkillLevel;
  List<String>? fitnessDifficulty;
  List<int>? duration;

  WorkoutFilter(
      {this.basketballSkillLevel, this.fitnessDifficulty, this.duration});

  WorkoutFilter copyWith({
    List<String>? basketballSkillLevel,
    List<String>? fitnessDifficulty,
    List<int>? duration,
  }) =>
      WorkoutFilter(
        basketballSkillLevel: basketballSkillLevel ?? this.basketballSkillLevel,
        fitnessDifficulty: fitnessDifficulty ?? this.fitnessDifficulty,
        duration: duration ?? this.duration,
      );
}
