import User from "../models/User.js";
import { validationResult } from "express-validator";

export const register = async (req, res) => {
  try {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({ message: errors.array()[0].msg });
    }

    const { fullName, email, password, createdBy } = req.body;

    const userExists = await User.findOne({ email });
    if (userExists) {
      return res.status(400).json({ message: "Email already exists" });
    }

    const user = await User.create({
      fullName,
      email,
      password,
      createdBy,
    });

    res.status(201).json({
      success: true,
      message: "User registered",
      user: {
        id: user._id,
        fullName: user.fullName,
        email: user.email,
      },
    });
  } catch (error) {
    res.status(500).json({ message: "Server error" });
  }
};
