import express from "express";
import { selectPlan, getCurrentWorkout } from "../controllers/plan.js";
import { verifyToken } from "../middleware/auth.js";
const router = express.Router();

router.post("/selectPlan" , verifyToken , selectPlan);
router.post("/getWorkout", getCurrentWorkout);

export default router;