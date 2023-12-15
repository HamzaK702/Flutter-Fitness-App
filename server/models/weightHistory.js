import mongoose from "mongoose";

const weightHistorySchema = new mongoose.Schema({
  userId: { 
    type: mongoose.Schema.Types.ObjectId, ref: 'User'
   },
  weights: [Number] // Array of weight entries
});

const WeightHistory = mongoose.model("WeightHistory" , weightHistorySchema);
export default WeightHistory;