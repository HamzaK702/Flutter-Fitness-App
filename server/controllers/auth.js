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
            height = "",
            consist = 0,
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
            height,
            consist
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

export const updateUser = async (req, res) => {
    try {
      const userId = req.params.userId;
      const {
        firstName,
        lastName,
        email,
        height,
        weight,
        consist,
      } = req.body;
  
      // Find the user by their ID
      const user = await User.findById(userId);
  
      if (!user) {
        return res.status(404).json({ error: 'User not found' });
      }
  
      // Update the user's information
      user.firstName = firstName || user.firstName;
      user.lastName = lastName || user.lastName;
      user.email = email || user.email;
      user.height = height || user.height;
      user.weight = weight || user.weight;
      user.consist = consist || user.consist;
  
      // Save the updated user
      const updatedUser = await user.save();
  
      res.status(200).json(updatedUser);
    } catch (err) {
      console.error('Error updating user:', err);
      res.status(500).json({ error: err.message });
    }
  };




export const login = async (req,res) => {
    console.log("it came to lgin");
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