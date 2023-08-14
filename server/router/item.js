const express = require("express");
const itemRouter = express.Router();
const ItemDetails = require("../models/ItemDetails");
const Item = require("../models/Item");
const { ADD_ITEM, GET_ALL_ITEMS, GET_ITEM_DETAILS } = require("../const");

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
      subCatId,
      privacyPolicy,
    } = req.body;

    const newItemDetails = new ItemDetails({
      title,
      images,
      rating,
      price,
      productType,
      colors,
      availableQuantity,
      description,
      videoUrl,
      privacyPolicy,
    });
    await newItemDetails.save();

    const newItem = new Item({
      title,
      rating,
      price,
      subCatId,
      categoryId,
      image: images[0],
      itemId: newItemDetails._id,
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
    const items = await Item.find({ categoryId });

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

itemRouter.get(`${GET_ITEM_DETAILS}/:id`, async (req, res) => {
  try {
    const _id = req.params.id;
    const itemDetails = await ItemDetails.findOne({ _id });

    if (!itemDetails) {
      return res.status(404).json({ msg: "No item found" });
    }
    res.json(itemDetails);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

module.exports = itemRouter;
