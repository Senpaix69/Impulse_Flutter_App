const express = require("express");
const exploreRouter = express.Router();
const Category = require("../models/Category");
const {
  ADD_CATEGORY,
  GET_ALL_CATEGORIES,
  GET_CATEGORY,
  UPDATE_CATEGORY,
  DELETE_CATEGORY,
} = require("../const");

exploreRouter.post(ADD_CATEGORY, async (req, res) => {
  try {
    const { imageUrl, title, adminId, subcategories } = req.body;
    const newCategory = new Category({
      imageUrl,
      title,
      adminId,
      subcategories: subcategories || [],
    });

    await newCategory.save();

    res.json({ msg: "Category added successfully", category: newCategory });
  } catch (error) {
    handleError(res, error);
  }
});

exploreRouter.get(`${GET_CATEGORY}/:id`, async (req, res) => {
  try {
    const categoryId = req.params.id;
    const category = await Category.findById(categoryId);

    if (!category) {
      return res.status(404).json({ msg: "Category not found" });
    }

    res.json({ category });
  } catch (error) {
    handleError(res, error);
  }
});

exploreRouter.get(GET_ALL_CATEGORIES, async (req, res) => {
  try {
    const categories = await Category.find();

    res.json(categories);
  } catch (error) {
    handleError(res, error);
  }
});

exploreRouter.post(UPDATE_CATEGORY, async (req, res) => {
  try {
    const { _id, imageUrl, title, subcategories } = req.body;
    const existingCategory = await Category.findById(_id);

    if (!existingCategory) {
      return res.status(400).json({ msg: "Category not found" });
    }

    if (imageUrl) existingCategory.imageUrl = imageUrl;
    if (title) existingCategory.title = title;
    if (subcategories) existingCategory.subcategories = subcategories;

    await existingCategory.save();
    res.json({ ...existingCategory._doc });
  } catch (error) {
    handleError(res, error);
  }
});

exploreRouter.post(DELETE_CATEGORY, async (req, res) => {
  try {
    const { _id } = req.body;
    const result = await Category.deleteOne({ _id });

    if (result.deletedCount === 0) {
      return res.status(400).json({ msg: "Category not found" });
    }

    res.json({ msg: "Deleted Successfully" });
  } catch (error) {
    handleError(res, error);
  }
});

function handleError(res, error) {
  res.status(500).json({ error: error.message });
}

module.exports = exploreRouter;
