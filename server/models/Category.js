const mongoose = require("mongoose");

const categorySchema = mongoose.Schema({
  imageUrl: {
    type: String,
    required: true,
    trim: true,
  },
  title: {
    type: String,
    required: true,
  },
  adminId: {
    type: String,
    required: true,
    trim: true,
  },
  subcategories: [
    {
      title: {
        type: String,
        required: true,
      },
    },
  ],
});

const Category = mongoose.model("category", categorySchema);

module.exports = Category;
