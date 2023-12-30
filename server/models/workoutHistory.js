import mongoose from "mongoose";

const WorkoutSchema  = new mongoose.Schema({
    name: {
        type: String,
        required: true
      },
      date: {
        type: Date,
        required: true
      }
    });

    const WorkoutHistorySchema = new mongoose.Schema({
        userId: {
          type: mongoose.Schema.Types.ObjectId,
          ref: 'User', // Assuming you have a User model
          required: true
        },
        previousWorkouts: [WorkoutSchema]
      });

const WorkoutHistory  = mongoose.model("WorkoutHistory" , WorkoutHistorySchema );
export default WorkoutHistory;