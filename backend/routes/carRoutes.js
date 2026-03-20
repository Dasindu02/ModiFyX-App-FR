import express from "express";
import multer from "multer";
import { uploadCarImages } from "../controllers/carController.js";

const router = express.Router();

const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    cb(null, "uploads/");
  },

  filename: (req, file, cb) => {
    cb(null, Date.now() + "-" + file.originalname);
  },
});

const upload = multer({ storage });

router.post(
  "/upload",
  upload.fields([
    { name: "front" },
    { name: "back" },
    { name: "left" },
    { name: "right" },
  ]),
  uploadCarImages
);

export default router;
