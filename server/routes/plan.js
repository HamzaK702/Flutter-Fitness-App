import express from "express";
import { selectPlan, getCurrentWorkout, getCurrentSplit, finishWorkout } from "../controllers/plan.js";
import { addWorkout, getWorkout,  } from "../controllers/workout.js";
import { verifyToken } from "../middleware/auth.js";
const router = express.Router();

router.post("/addWorkout" ,  addWorkout);
router.get("/getExercises" ,  getWorkout); //gets you the exercises
router.post("/finishWorkout" ,  finishWorkout);
router.post("/selectPlan" ,  selectPlan);
router.post("/getSplit", getCurrentSplit);
router.post("/getWorkout", getCurrentWorkout); //get you the day of the workout

export default router;