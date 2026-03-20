export const uploadCarImages = async (req, res) => {
  try {

    const front = req.files["front"][0].path;
    const back = req.files["back"][0].path;
    const left = req.files["left"][0].path;
    const right = req.files["right"][0].path;

    res.status(200).json({
      success: true,
      message: "Images uploaded successfully",
      images: { front, back, left, right }
    });

  } catch (error) {

    console.error(error);

    res.status(500).json({
      success: false,
      message: "Upload failed"
    });
  }
};
