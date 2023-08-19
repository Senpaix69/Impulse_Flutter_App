const express = require("express");
const itemRouter = express.Router();
const ItemDetails = require("../models/ItemDetails");
const Item = require("../models/Item");
const {
  ADD_ITEM,
  GET_ALL_ITEMS,
  GET_ITEM_DETAILS,
  DELETE_ITEM,
  UPDATE_ITEM,
} = require("../const");

itemRouter.post(ADD_ITEM, async (req, res) => {
  try {
    const newItemDetails = new ItemDetails(req.body);
    await newItemDetails.save();

    const newItem = new Item({
      ...req.body,
      image: req.body.images[0],
      itemId: newItemDetails._id,
    });
    await newItem.save();

    res.json({ msg: "Item added successfully", item: newItem });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

itemRouter.post(UPDATE_ITEM, async (req, res) => {
  try {
    const { _id, ...updateData } = req.body;

    const existingItem = await Item.findOne({ itemId: _id });
    const existingItemDetails = await ItemDetails.findOne({ _id });

    if (!existingItem || !existingItemDetails) {
      return res.status(400).json({ msg: "Item not found" });
    }

    Object.assign(existingItem, {
      ...updateData,
      image: req.body.images[0],
      itemId: req.body._id,
    });
    Object.assign(existingItemDetails, updateData);

    await existingItem.save();
    await existingItemDetails.save();

    res.json({ msg: "Item updated successfully" });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

itemRouter.get(`${GET_ALL_ITEMS}/:id`, async (req, res) => {
  try {
    const categoryId = req.params.id;
    const items = await Item.find({ categoryId });
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

itemRouter.delete(`${DELETE_ITEM}/:id`, async (req, res) => {
  try {
    const _id = req.params.id;
    const result = await Item.deleteOne({ itemId: _id });
    await ItemDetails.deleteOne({ _id });

    if (result.deletedCount === 0) {
      return res.status(404).json({ msg: "No item found" });
    }
    res.json({ msg: "Deleted Successfully" });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

module.exports = itemRouter;
