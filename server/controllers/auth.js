import bcrypt from "bcrypt";
import jwt from "jsonwebtoken";
import Student from "../models/Student.js";
import Trainer from "../models/Trainer.js";

// register Student
export const registerStudent = async (req,res) => {
    try{
        const { 
            firstName,
            lastName,
            email,
            password,
            picturePath,
            weight=0,
            height="",S
         } = req.body;
        const salt = await bcrypt.genSalt();
        const passwordHash = await bcrypt.hash(password , salt);
        const newStudent = new Student({
            firstName,
            lastName,
            email,
            password:passwordHash,
            picturePath,
            weight,
            height,
            trainers:[]
        });
       const savedStudent =  await newStudent.save();
       res.status(200).json(savedStudent);
    } catch(err){
        res.status(500).json({error:err.message});
    }
};




export const registerTrainer = async (req,res) => {
    try{
        const { 
            firstName,
            lastName,
            email,
            password,
            picturePath,
            weight=0,
            height="",
         } = req.body;
        const salt = await bcrypt.genSalt();
        const passwordHash = await bcrypt.hash(password , salt);
        const newTrainer = new Trainer({
            firstName,
            lastName,
            email,
            password:passwordHash,
            picturePath,
            weight,
            height,
            trainers:[]
        });
       const savedTrainer =  await newTrainer.save();
       res.status(201).json(savedTrainer);
    } catch(err){
        res.status(500).json({error:err.message});
    }
};


export const login = async (req,res) => {
    try{
        const {email , password} = req.body;
        const user = await Student.findOne({email:email})
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