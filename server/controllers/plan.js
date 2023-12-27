import User from "../models/User.js";
import Plan from "../models/Plan.js";
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
            return "Fullbody";
        default:
            console.log(split, count)
            return "Rest";
    }
}

