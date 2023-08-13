const express = require("express");
const itemRouter = express.Router();
const Item = require("../models/Item");
const { GET_ITEM, ADD_ITEM, GET_ALL_ITEMS } = require("../const");

itemRouter.post(ADD_ITEM, async (req, res) => {
  try {
    const {
      title,
      images,
      rating,
      price,
      productType,
      colors,
      availableQuantity,
      description,
      videoUrl,
      categoryId,
      privacyPolicy,
    } = req.body;

    const newItem = new Item({
      title,
      images,
      rating,
      price,
      productType,
      colors,
      availableQuantity,
      description,
      categoryId,
      videoUrl,
      privacyPolicy,
    });

    await newItem.save();
    res.json({ msg: "Item added successfully", item: newItem });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

itemRouter.get(`${GET_ALL_ITEMS}/:id`, async (req, res) => {
  try {
    const categoryId = req.params.id;
    const items = await Item.find({ categoryId: categoryId });

    if (!items) {
      return res
        .status(404)
        .json({ msg: "No items found for the specified category" });
    }
    res.json(items);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

module.exports = itemRouter;
