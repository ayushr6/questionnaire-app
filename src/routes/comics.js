const express = require("express");
const router = express.Router();
const Comic = require("../models/comics");
const fs = require("fs");
const csv = require("csv-parser");

// @route GET /api/comics
// @desc Get all comics
router.get("/", async (req, res) => {
  try {
    const comics = await Comic.find();
    res.json(comics);
  } catch (err) {
    console.error(err.message);
    res.status(500).send("Server Error");
  }
});

// @route POST /api/comics
// @desc Add a new comic
router.post("/", async (req, res) => {
  const { title, description, genres, imageUrl } = req.body;

  try {
    const newComic = new Comic({
      title,
      description,
      genres,
      imageUrl,
    });

    const comic = await newComic.save();
    res.json(comic);
  } catch (err) {
    console.error(err.message);
    res.status(500).send("Server Error");
  }
});

// @route PUT /api/comics/:id
// @desc Update a comic
router.put("/:id", async (req, res) => {
  const { title, description, genres, imageUrl } = req.body;

  try {
    let comic = await Comic.findById(req.params.id);
    if (!comic) return res.status(404).json({ msg: "Comic not found" });

    comic.title = title || comic.title;
    comic.description = description || comic.description;
    comic.genres = genres || comic.genres;
    comic.imageUrl = imageUrl || comic.imageUrl;

    comic = await comic.save();
    res.json(comic);
  } catch (err) {
    console.error(err.message);
    res.status(500).send("Server Error");
  }
});

// @route DELETE /api/comics/:id
// @desc Delete a comic
router.delete("/:id", async (req, res) => {
  try {
    const comic = await Comic.findById(req.params.id);
    if (!comic) return res.status(404).json({ msg: "Comic not found" });

    await comic.remove();
    res.json({ msg: "Comic removed" });
  } catch (err) {
    console.error(err.message);
    res.status(500).send("Server Error");
  }
});

router.post("/bulk-upload", async (req, res) => {
  const filePath = "src/data/Toonsutra_Comics_Data.csv"; // Path to the CSV file

  try {
    // Step 1: Clear existing comics
    await Comic.deleteMany();
    console.log("Comics collection cleared.");

    const comics = [];

    // Step 2: Read and parse the CSV file
    fs.createReadStream(filePath)
      .pipe(csv())
      .on("data", (row) => {
        // Ensure the data is in the expected format
        comics.push({
          title: row["Title"],
          description: row["Description"],
          genres: row["Genre"].split("|"), // Split genres into an array
          imageUrl: row["Image URL"],
        });
      })
      .on("end", async () => {
        try {
          // Step 3: Insert new data
          await Comic.insertMany(comics);
          res.status(200).json({ msg: "Comics collection reuploaded successfully!" });
          console.log("Comics collection updated.");
        } catch (err) {
          console.error("Failed to insert comics:", err.message);
          res.status(500).json({ msg: "Failed to upload data" });
        }
      });
  } catch (err) {
    console.error("Server Error:", err.message);
    res.status(500).json({ msg: "Server Error" });
  }
});

module.exports = router;
