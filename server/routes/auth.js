import express  from "express";
import { login, updateUser } from "../controllers/auth.js";
const router = express.Router();

router.post("/login" , login);
router.put("/update/:userId" , updateUser);


export default router;