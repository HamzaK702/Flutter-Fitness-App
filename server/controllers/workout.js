import User from "../models/User.js";
import WorkoutModel from "../models/Workout.js";

export const addWorkout = async (req, res) => {
    try {
        const newWorkout = new WorkoutModel(req.body);
        await newWorkout.save();
        res.status(200).send('Workout added successfully');
      } catch (error) {
        res.status(500).send('Error saving workout: ' + error.message);
      }
}



export const getWorkout = async (req, res) => {
  
try{
    
    const day = req.query.day;
    console.log("it was called: "+day)
    const workout = await WorkoutModel.findOne({ Day: day });
    if (!workout) {
      return res.status(404).send('Workout not found for the specified day');
    }
    
    res.status(200).json(workout);
  } catch (error) {
    res.status(500).send('Error retrieving workout: ' + error.message);
  }
}


