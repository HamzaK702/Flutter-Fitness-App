import mongoose from "mongoose";

const Schema = mongoose.Schema;

// Exercise Schema for Warm Up and Cool Down (Time-based)
const timeBasedExerciseSchema = new Schema({
  Exercise: { type: String, required: true },
  Time: { type: String, required: true }
});

// Exercise Schema for Main Exercises (Set and Rep based)
const setRepBasedExerciseSchema = new Schema({
  Exercise: { type: String, required: true },
  Sets: { type: String, required: true },
  Reps: { type: String, required: true }
});

// Workout Schema
const workoutSchema = new Schema({
  Day: { type: String, required: true },
  WarmUp: [timeBasedExerciseSchema],
  Exercises: [setRepBasedExerciseSchema],
  CoolDown: [timeBasedExerciseSchema]
});

// Create the model
const WorkoutModel = mongoose.model("Workout" , workoutSchema);
export default WorkoutModel;
