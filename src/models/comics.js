const mongoose = require("mongoose");

const comicSchema = new mongoose.Schema({
  title: {
    type: String,
    required: true,
    trim: true,
  },
  description: {
    type: String,
    required: true,
    trim: true,
  },
  genres: {
    type: [String], // Array of strings to handle multiple genres
    required: true,
  },
  imageUrl: {
    type: String,
    required: true,
  },
  createdAt: {
    type: Date,
    default: Date.now, // Auto-generate timestamp for creation
  },
  updatedAt: {
    type: Date,
    default: Date.now, // Auto-generate timestamp for updates
  },
});

// Model
module.exports = mongoose.model("Comic", comicSchema);
