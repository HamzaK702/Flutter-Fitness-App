import mongoose from "mongoose";

const StudentSchema = new mongoose.Schema({
    firstName:{
        type:String,
        required:true,
        min:3,
        max:50
    },
    lastName:{
        type:String,
        required:true,
        min:2,
        max:50
    },
    email:{
        type:String,
        required:true,
        unique:true,
        max:50
    },
    password:{
        type:String,
        required:true,
        min:5
    },
    picturePath:{
        type:String,
        default:""
    },
    weight:{
        type:Number
        },
    height:{
        type:String
        },
    trainers:{
        type:Array,
        default:[]
    },
},{timestamps:true});

const Student = mongoose.model("Student" , StudentSchema);
export default Student;