const mongoose = require("mongoose");

const item = mongoose.Schema({
  title: {
    type: String,
    required: true,
  },
  images: [
    {
      type: String,
      trim: true,
      required: true,
    },
  ],
  categoryId: {
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
  productType: {
    type: String,
    required: true,
  },
  colors: [
    {
      type: String,
      trim: true,
    },
  ],
  availableQuantity: {
    type: Number,
    required: true,
  },
  description: {
    type: String,
    required: true,
  },
  videoUrl: {
    type: String,
    trim: true,
    default: "",
  },
  privacyPolicy: {
    type: String,
    required: true,
  },
});

const Item = mongoose.model("item", item);
module.exports = Item;
