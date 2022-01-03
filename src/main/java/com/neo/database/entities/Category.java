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
import javax.persistence.OneToMany;
import javax.persistence.Table;

/**
 * Category generated by hbm2java
 */
@Entity
@Table(name = "category", catalog = "project_ecommerce"
)
public class Category implements java.io.Serializable {

    private Integer categoryId;
    private String name;
    private Set<ItemCategory> itemCategoriesForMainCategory = new HashSet<ItemCategory>(0);
    private Set<ItemCategory> itemCategoriesForSubCategory = new HashSet<ItemCategory>(0);

    public Category() {
    }

    public Category(String name, Set<ItemCategory> itemCategoriesForMainCategory, Set<ItemCategory> itemCategoriesForSubCategory) {
        this.name = name;
        this.itemCategoriesForMainCategory = itemCategoriesForMainCategory;
        this.itemCategoriesForSubCategory = itemCategoriesForSubCategory;
    }

    @Id
    @GeneratedValue(strategy = IDENTITY)

    @Column(name = "category_id", unique = true, nullable = false)
    public Integer getCategoryId() {
        return this.categoryId;
    }

    public void setCategoryId(Integer categoryId) {
        this.categoryId = categoryId;
    }

    @Column(name = "name", length = 45)
    public String getName() {
        return this.name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @OneToMany(fetch = FetchType.LAZY, mappedBy = "categoryByMainCategory")
    public Set<ItemCategory> getItemCategoriesForMainCategory() {
        return this.itemCategoriesForMainCategory;
    }

    public void setItemCategoriesForMainCategory(Set<ItemCategory> itemCategoriesForMainCategory) {
        this.itemCategoriesForMainCategory = itemCategoriesForMainCategory;
    }

    @OneToMany(fetch = FetchType.LAZY, mappedBy = "categoryBySubCategory")
    public Set<ItemCategory> getItemCategoriesForSubCategory() {
        return this.itemCategoriesForSubCategory;
    }

    public void setItemCategoriesForSubCategory(Set<ItemCategory> itemCategoriesForSubCategory) {
        this.itemCategoriesForSubCategory = itemCategoriesForSubCategory;
    }

}