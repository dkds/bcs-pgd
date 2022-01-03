/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.neo.beans.item;

import com.neo.beans.Bean;
import com.neo.util.CountedList;
import java.util.Arrays;
import java.util.Objects;

/**
 *
 * @author neo
 */
public final class Category extends Bean<Category> implements CountedList.Countable, Comparable<Category> {

    private String name;
    private CountedList<Category> subCategories;
    private int categoryId;
    private int count;
    private boolean visible;

    public Category() {
    }

    public Category(String name) {
        this.name = name;
    }

    public Category(int categoryId) {
        this.categoryId = categoryId;
    }

    public Category(int categoryId, String name) {
        this.categoryId = categoryId;
        this.name = name;
    }

    public Category(int itemCategoryId, int categoryId, String name) {
        this.categoryId = categoryId;
        this.name = name;
        setId(itemCategoryId);
    }

    public Category(String name, Category subCategory) {
        this.name = name;
        setSubCategory(subCategory);
    }

    public Category(String name, String subCategory) {
        this.name = name;
        setSubCategory(new Category(subCategory));
    }

    public Category(int itemCategoryId, int mainCategoryId, String name, int subCategoryId, String subCategory) {
        this.categoryId = mainCategoryId;
        this.name = name;
        setSubCategory(new Category(itemCategoryId, subCategoryId, subCategory));
        setId(itemCategoryId);
    }

    public Category(int mainCategoryId, String name, Category[] subCategories) {
        this.categoryId = mainCategoryId;
        this.name = name;
        setSubCategories(subCategories);
    }

    /**
     * @return the name
     */
    public String getName() {
        return name;
    }

    /**
     * @param name the name to set
     */
    public void setName(String name) {
        this.name = name;
    }

    /**
     * @return the subCategories
     */
    public Category[] getSubCategories() {
        if (subCategories == null) {
            return new Category[]{null};
        }
        return subCategories.toArray(new Category[subCategories.size()]);
    }

    /**
     * @param subCategories the subCategories to set
     */
    public void setSubCategories(Category[] subCategories) {
        for (Category subCategory : subCategories) {
            subCategory.countDown();
        }
        this.subCategories = new CountedList<>(Arrays.asList(subCategories));
    }

    public void setSubCategory(Category subCategory) {
        subCategory.countDown();
        this.subCategories = new CountedList<>(Arrays.asList(new Category[]{subCategory}));
    }

    public Category getSubCategory() {
        return getSubCategories()[0];
    }

    public void addSubCategory(Category category) {
        if (subCategories == null) {
            setSubCategory(category);
        } else {
            subCategories.add(category);
        }
    }

    @Override
    public boolean equals(Object obj) {
        return obj instanceof Category
               && ((Category) obj).getName().equals(getName());
    }

    @Override
    public int getCount() {
        return count;
    }

    @Override
    public int countUp() {
        count++;
        return count;
    }

    @Override
    public int countDown() {
        count--;
        return count;
    }

    @Override
    public int setCount(int count) {
        this.count = count;
        return this.count;
    }

    @Override
    public int compareTo(Category category) {
        if (category == null) {
            return 0;
        }
        return getCategoryId() - category.getCategoryId();
    }

    public int getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }

    public void setVisible(boolean visible) {
        this.visible = visible;
    }

    public boolean isVisible() {
        return visible;
    }

    @Override
    public int hashCode() {
        int hash = 5;
        hash = 53 * hash + Objects.hashCode(this.name);
        hash = 53 * hash + this.categoryId;
        return hash;
    }

    @Override
    public void clone(Category bean) {
        setName(bean.getName());
        setSubCategories(bean.getSubCategories());
        setCategoryId(bean.getCategoryId());
        setCount(bean.getCount());
        setVisible(bean.isVisible());
        setId(bean.getId());
    }
}
