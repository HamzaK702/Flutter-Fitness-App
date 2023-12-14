import mongoose from "mongoose";

const TrainerSchema = new mongoose.Schema({
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
    type:Number,
      
    },
    time:{
        type:String,
         
    },
    height:{
        type:String,
          
        },
    students:{
        type:Array,
        default:[]
    },
},{timestamps:true});

const Trainer  = mongoose.model("Trainer" , TrainerSchema);
export default Trainer;