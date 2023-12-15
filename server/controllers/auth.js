import bcrypt from "bcrypt";
import jwt from "jsonwebtoken";
import User from "../models/User.js";
import Plan from '../models/Plan.js';

// register Student
export const registerUser = async (req, res) => {
    try {
        const { 
            firstName,
            lastName,
            email,
            password,
            picturePath,
            weight = 0,
            height = ""
        } = req.body;

        const salt = await bcrypt.genSalt();
        const passwordHash = await bcrypt.hash(password, salt);

        // Create new User
        const newUser = new User({
            firstName,
            lastName,
            email,
            password: passwordHash,
            picturePath,
            weight,
            height
        });

        const savedUser = await newUser.save();

        // Create a default Plan for the user
        const defaultPlan = new Plan({
            userId: savedUser._id,
            Split: 'Push/Pull/Legs Split',
            count: 0
        });

        await defaultPlan.save();

        res.status(200).json(savedUser);
    } catch (err) {
        console.error('Error registering user:', err);
        res.status(500).json({ error: err.message });
    }
};




export const login = async (req,res) => {
    try{
        const {email , password} = req.body;
        const user = await User.findOne({email:email})
        if(!user) return res.status(400).json({msg:"User does not exist"});
        const isMatch = await bcrypt.compare(password , user.password);
        if(!isMatch) return res.status(400).json({msg:"Invalid credentials"});
        const token = jwt.sign({id:user._id} , process.env.JWT_SECRET);
        delete user.password;
        res.status(200).json({token , user});
    } catch(err){
        res.status(500).json({error:err.message});
    }
}