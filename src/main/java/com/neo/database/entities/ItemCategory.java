package com.neo.database.entities;
// Generated May 9, 2015 3:13:15 PM by Hibernate Tools 4.3.1

import java.util.HashSet;
import java.util.Set;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import static javax.persistence.GenerationType.IDENTITY;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

/**
 * ItemCategory generated by hbm2java
 */
@Entity
@Table(name = "item_category", catalog = "project_ecommerce"
)
public class ItemCategory implements java.io.Serializable {

    private Integer itemCategoryId;
    private Category categoryByMainCategory;
    private Category categoryBySubCategory;
    private Set<Item> items = new HashSet<Item>(0);

    public ItemCategory() {
    }

    public ItemCategory(Category categoryByMainCategory, Category categoryBySubCategory) {
        this.categoryByMainCategory = categoryByMainCategory;
        this.categoryBySubCategory = categoryBySubCategory;
    }

    public ItemCategory(Category categoryByMainCategory, Category categoryBySubCategory, Set<Item> items) {
        this.categoryByMainCategory = categoryByMainCategory;
        this.categoryBySubCategory = categoryBySubCategory;
        this.items = items;
    }

    @Id
    @GeneratedValue(strategy = IDENTITY)

    @Column(name = "item_category_id", unique = true, nullable = false)
    public Integer getItemCategoryId() {
        return this.itemCategoryId;
    }

    public void setItemCategoryId(Integer itemCategoryId) {
        this.itemCategoryId = itemCategoryId;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "main_category", nullable = false)
    public Category getCategoryByMainCategory() {
        return this.categoryByMainCategory;
    }

    public void setCategoryByMainCategory(Category categoryByMainCategory) {
        this.categoryByMainCategory = categoryByMainCategory;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "sub_category", nullable = false)
    public Category getCategoryBySubCategory() {
        return this.categoryBySubCategory;
    }

    public void setCategoryBySubCategory(Category categoryBySubCategory) {
        this.categoryBySubCategory = categoryBySubCategory;
    }

    @OneToMany(fetch = FetchType.LAZY, mappedBy = "itemCategory")
    public Set<Item> getItems() {
        return this.items;
    }

    public void setItems(Set<Item> items) {
        this.items = items;
    }

}
