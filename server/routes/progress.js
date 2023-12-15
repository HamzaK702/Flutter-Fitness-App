import express from "express";
import { updateWeight, addHeight } from "../controllers/progress.js";
import { verifyToken } from "../middleware/auth.js";
const router = express.Router();

router.post("/updateWeight" , verifyToken , updateWeight);
router.post("/addHeight" , verifyToken , addHeight);

export default router;