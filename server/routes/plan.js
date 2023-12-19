import express from "express";
import { selectPlan, getCurrentWorkout } from "../controllers/plan.js";
import { addWorkout, getWorkout } from "../controllers/workout.js";
import { verifyToken } from "../middleware/auth.js";
const router = express.Router();

router.post("/addWorkout" ,  addWorkout);
router.get("/getExercises" ,  getWorkout); //gets you the exercises
router.post("/selectPlan" , verifyToken , selectPlan);
router.post("/getWorkout", getCurrentWorkout); //get you the day of the workout

export default router;