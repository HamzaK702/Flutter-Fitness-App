import User from "../models/User.js";
import WeightHistory from "../models/weightHistory.js";

export const updateWeight = async (req, res) => {
    const { userId, newWeight } = req.body;

    if (!userId || !newWeight) {
        return res.status(400).send({ message: 'Missing userId or newWeight' });
    }

    try {
        // Update weight in User collection
        const user = await User.findById(userId);
        if (!user) {
            return res.status(404).send({ message: 'User not found' });
        }

        user.weight = newWeight;
        await user.save();

        // Add new weight to WeightHistory collection
        const weightHistory = await WeightHistory.findOne({ userId });
        if (weightHistory) {
            weightHistory.weights.push(newWeight);
            await weightHistory.save();
        } else {
            // Create new WeightHistory if it doesn't exist
            const newWeightHistory = new WeightHistory({
                userId,
                weights: [newWeight]
            });
            await newWeightHistory.save();
        }

        res.status(200).send({ message: 'Weight updated successfully' });
    } catch (error) {
        console.error('Error updating weight:', error);
        res.status(500).send({ message: 'Internal Server Error' });
    }
}


export const addHeight = async (req, res) => {
    const { userId, newHeight } = req.body;

    if (!userId || newHeight === undefined) {
        return res.status(400).send({ message: 'Missing userId or newHeight' });
    }

    try {
        const user = await User.findById(userId);

        if (!user) {
            return res.status(404).send({ message: 'User not found' });
        }

        user.height = newHeight;
        await user.save();

        res.status(200).send({ message: 'Height updated successfully', user });
    } catch (error) {
        console.error('Error updating height:', error);
        res.status(500).send({ message: 'Internal Server Error' });
    }
}

