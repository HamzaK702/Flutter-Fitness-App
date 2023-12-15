import mongoose from "mongoose";

const planSchema = new mongoose.Schema({
  userId: { 
    type: mongoose.Schema.Types.ObjectId, ref: 'User' },
  Split: { 
    type: String, enum: 
    ['Push/Pull/Legs Split', 
    'Bodybuilder Split', 
    'Upper/Lower Body Split', 
    'Fullbody'] },
  count: 
  {
    type:Number 
    }
});

const Plan = mongoose.model("Plan" , planSchema);
export default Plan;
