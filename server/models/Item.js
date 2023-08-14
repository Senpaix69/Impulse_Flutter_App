const mongoose = require("mongoose");

const item = mongoose.Schema({
  title: {
    type: String,
    required: true,
  },
  image: {
    type: String,
    trim: true,
    required: true,
  },
  categoryId: {
    type: String,
    trim: true,
    required: true,
  },
  itemId: {
    type: String,
    trim: true,
    required: true,
  },
  subCatId: {
    type: String,
    trim: true,
    required: true,
  },
  rating: {
    type: Number,
    default: 0,
  },
  price: {
    type: Number,
    required: true,
  },
});

const Item = mongoose.model("item", item);
module.exports = Item;
