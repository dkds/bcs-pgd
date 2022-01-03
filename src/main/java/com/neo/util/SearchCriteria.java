/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.neo.util;

import com.neo.beans.item.Category;
import com.neo.beans.user.User;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Objects;

/**
 *
 * @author neo
 */
public class SearchCriteria implements Serializable {

    private final String searchText;
    private final boolean onlyName;
    private final float minPrice;
    private final float maxPrice;
    private final String range;
    private final Category category;
    private final String[] materials;
    private final String[] colors;
    private final String[] styles;
    private final Order[] orders;
    private final User currentUser;
    private final Builder builder;

    private SearchCriteria(Builder builder) {
        this.searchText = builder.searchText;
        this.onlyName = builder.onlyName;
        this.minPrice = builder.minPrice;
        this.maxPrice = builder.maxPrice;
        this.range = builder.range;
        this.category = builder.category;
        this.materials = builder.materials.toArray(new String[builder.materials.size()]);
        this.colors = builder.colors.toArray(new String[builder.colors.size()]);
        this.styles = builder.styles.toArray(new String[builder.styles.size()]);
        this.orders = builder.orders.toArray(new Order[builder.orders.size()]);
        this.currentUser = builder.user;
        this.builder = builder;
    }

    public String getStyle() {
        if (styles == null || styles.length == 0) {
            return "";
        }
        return styles[0];
    }

    public String[] getStyles() {
        return Arrays.copyOf(styles, styles.length);
    }

    public String getSearchText() {
        return searchText;
    }

    public float getMinPrice() {
        if (!isPriceSet()) {
            return 0;
        }
        return minPrice;
    }

    public float getMaxPrice() {
        if (!isPriceSet()) {
            return 500000;
        }
        return maxPrice;
    }

    public String getPriceRange() {
        return range;
    }

    public String getMaterial() {
        if (materials == null || materials.length == 0) {
            return "";
        }
        return materials[0];
    }

    public String[] getMaterials() {
        return Arrays.copyOf(materials, materials.length);
    }

    public String getColor() {
        if (colors == null || colors.length == 0) {
            return "";
        }
        return colors[0];
    }

    public String[] getColors() {
        return Arrays.copyOf(colors, colors.length);
    }

    public Order[] getOrders() {
        return Arrays.copyOf(orders, orders.length);
    }

    public Category getCategory() {
        return category;
    }

    public boolean isPriceSet() {
        return minPrice != -1 && maxPrice != -1;
    }

    public boolean isSearchTextSet() {
        return searchText != null && !searchText.trim().isEmpty();
    }

    public boolean isSearchOnlyName() {
        return onlyName;
    }

    public boolean isCategoriesSet() {
        return category != null;
    }

    public boolean isMaterialsSet() {
        return materials.length > 0;
    }

    public boolean isColorsSet() {
        return colors.length > 0;
    }

    public boolean isStylesSet() {
        return styles.length > 0;
    }

    public boolean isOrdersSet() {
        return orders.length > 0;
    }

    public User getCurrentUser() {
        return currentUser;
    }

    @Override
    public int hashCode() {
        int hash = 3;
        hash = 53 * hash + Objects.hashCode(this.searchText);
        hash = 53 * hash + Objects.hashCode(this.category);
        hash = 53 * hash + (this.onlyName ? 1 : 0);
        hash = 53 * hash + Float.floatToIntBits(this.minPrice);
        hash = 53 * hash + Float.floatToIntBits(this.maxPrice);
        hash = 53 * hash + Arrays.deepHashCode(this.materials);
        hash = 53 * hash + Arrays.deepHashCode(this.colors);
        hash = 53 * hash + Arrays.deepHashCode(this.styles);
        return hash;
    }

    @Override
    public boolean equals(Object obj) {
        return obj instanceof SearchCriteria && obj.hashCode() == hashCode();
    }

    public Builder getBuilder() {
        return builder;
    }

    public static class Builder implements Serializable {

        private String searchText = "";
        private boolean onlyName;
        private float minPrice = -1;
        private float maxPrice = -1;
        private String range;
        private Category category;
        private final ArrayList<String> materials = new ArrayList<>(2);
        private final ArrayList<String> colors = new ArrayList<>(2);
        private final ArrayList<String> styles = new ArrayList<>(2);
        private final ArrayList<Order> orders = new ArrayList<>(2);
        private User user;

        public Builder(User currentUser) {
            this.user = currentUser;
        }

        public Builder setSearchText(String searchText) {
            this.searchText = searchText;
            return this;
        }

        public Builder setSearchText(String searchText, boolean onlyName) {
            this.searchText = searchText;
            this.onlyName = onlyName;
            return this;
        }

        public Builder setPriceRange(String range) {
            if (range != null && !range.trim().isEmpty() && range.contains(";")) {
                try {
                    this.range = range;
                    this.minPrice = Float.valueOf(range.split(";")[0]);
                    this.maxPrice = Float.valueOf(range.split(";")[1]);
                } catch (NumberFormatException e) {
                    e.printStackTrace();
                }
            }
            return this;
        }

        public Builder setCategory(Category category) {
            this.category = category;
            return this;
        }

        public Builder addMaterial(String material) {
            if (!materials.contains(material)) {
                materials.add(material);
            }
            return this;
        }

        public Builder addColor(String color) {
            if (!colors.contains(color)) {
                colors.add(color);
            }
            return this;
        }

        public Builder addStyle(String style) {
            if (!styles.contains(style)) {
                styles.add(style);
            }
            return this;
        }

        public Builder addOrder(Order order) {
            if (!orders.contains(order)) {
                orders.add(order);
            }
            return this;
        }

        public SearchCriteria build() {
            return new SearchCriteria(this);
        }
    }

    public enum Order {

        NAME_ASC, NAME_DESC,
        PRICE_ASC, PRICE_DESC,
        AGE_ASC, AGE_DESC;

    }

}