const express = require("express");
const dotenv = require("dotenv");
const connectDB = require("./config/db");
const comicsRoute = require("./routes/comics");

// Load environment variables
dotenv.config();

// Connect to database
connectDB();

const app = express();

// Middleware
app.use(express.json()); // Body parser

// API Routes
app.use("/api/comics", comicsRoute);

const PORT = process.env.PORT || 5000;

app.listen(PORT, () => console.log(`Server running on port ${PORT}`));
