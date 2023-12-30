import User from "../models/User.js";
import Plan from "../models/Plan.js";
import WorkoutHistory from "../models/workoutHistory.js";
import mongoose from "mongoose";

export const selectPlan = async (req, res) => {
const { userId, split } = req.body;

    if (!userId || !split) {
        return res.status(400).send({ message: 'Missing userId or split' });
    }

    const validSplits = ['Push/Pull/Legs Split', 'Bodybuilder Split', 'Upper/Lower Body Split', 'Fullbody'];

    if (!validSplits.includes(split)) {
        return res.status(400).send({ message: 'Invalid workout split' });
    }

    try {
        // Find or create Plan for the user
        const plan = await Plan.findOneAndUpdate(
            { userId: mongoose.Types.ObjectId(userId) },
            { Split: split, count: 0 },
            { new: true, upsert: true }
        );
           
        res.status(200).send({ message: 'Workout plan selected successfully', plan });
        console.log("updated split info of user") 
    } catch (error) {
        console.error('Error selecting plan:', error);
        res.status(500).send({ message: 'Internal Server Error' });
    }
}

export const getCurrentWorkout = async (req, res) => {
    const { userId } = req.body;

    if (!userId) {
        return res.status(400).send({ message: 'Missing userId' });
    }

    try {
        const plan = await Plan.findOne({ userId: mongoose.Types.ObjectId(userId) });

        if (!plan) {
            return res.status(404).send({ message: 'No plan found for this user' });
        }
        const day = muscleName(plan.Split, plan.count);
        res.status(200).send({ day });
    } catch (error) {
        console.error('Error retrieving current workout:', error);
        res.status(500).send({ message: 'Internal Server Error' });
    }
};


export const getCurrentSplit = async (req, res) => {
    const { userId } = req.body;

    if (!userId) {
        return res.status(400).send({ message: 'Missing userId' });
    }

    try {
        const plan = await Plan.findOne({ userId: mongoose.Types.ObjectId(userId) });

        if (!plan) {
            return res.status(404).send({ message: 'No plan found for this user' });
        }
        const split = plan.Split + "";
        console.log(split)
        res.status(200).send({ split });
    } catch (error) {
        console.error('Error retrieving current workout:', error);
        res.status(500).send({ message: 'Internal Server Error' });
    }
};


function muscleName(split, count) {
    switch (split) {
        case "Push/Pull/Legs Split":
            console.log(["Push", "Pull", "Legs"][count % 3])
            return ["Push", "Pull", "Legs"][count % 3]; 
        case "Bodybuilder Split":
            console.log(["Chest", "Back", "Arms", "Shoulders", "Legs"][count % 5])
            return ["Chest", "Back", "Arms", "Shoulders", "Legs"][count % 5];
        case "Upper/Lower Body Split":
            console.log(["Upper Body", "Lower Body"][count % 2])
            return ["Upper Body", "Lower Body"][count % 2];
        case "Fullbody":
            console.log("Fullbody")
            return "Full Body";
        default:
            console.log(split, count)
            return "Rest";
    }
}

export const finishWorkout = async (req, res) => {
    const userId = req.body.userId;
    
    if (!userId || !mongoose.Types.ObjectId.isValid(userId)) {
        return res.status(400).send('Invalid user ID');
    }
    
    try {
        const user = await User.findById(userId);
        if (!user) {
            return res.status(404).send('User not found');
        }
    
        // Find plans associated with this user and increment count
        const plans = await Plan.find({ userId: userId });
        if (plans.length === 0) {
            return res.status(404).send('No plans found for this user');
        }
    
        for (const plan of plans) {
            plan.count = (plan.count || 0) + 1;
            await plan.save();
        }
    
        // Increment consist in the user
        user.consist = (user.consist || 0) + 1;
        await user.save();
    
        res.send({ message: 'Workout completed successfully', user, plans });
    } catch (error) {
        res.status(500).send(error.message);
    }
    }


    export const historyWorkout = async (req, res) => {
        try {
          const { userId, workoutName } = req.body;
        
          // Create a new workout entry
          const newWorkout = { name: workoutName, date: new Date() };
        
          // Find the user's workout history and update it
          const result = await WorkoutHistory.findOneAndUpdate(
              { userId: mongoose.Types.ObjectId(userId) },
              { $push: { previousWorkouts: newWorkout } },
              { new: true, upsert: true }  
          );
        
          res.status(200).json({ message: 'Workout added successfully', result });
        } catch (error) {
          res.status(500).json({ message: 'Error adding workout', error });
        }
        }


export const getHistory = async (req, res) => {
    try {
        const userId = req.query.userId; // Getting the userId from query parameters

        if (!userId) {
            return res.status(400).json({ message: 'UserId is required' });
        }

        // Find the workout history for the user
        const history = await WorkoutHistory.findOne({ userId: userId }).sort({'previousWorkouts.date': -1});

        if (!history) {
            return res.status(404).json({ message: 'Workout history not found' });
        }

        res.status(200).json(history);
    } catch (error) {
        console.error(error);
        res.status(500).json({ message: 'Error retrieving workout history', error });
    }
        }