/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.neo.util;

import java.io.Serializable;

/**
 *
 * @author neo
 */
public class AdminStatistics implements Serializable {

    private final User user;
    private final Item item;
    private final Accounts accounts;

    public AdminStatistics() {
        this.user = new User();
        this.item = new Item();
        this.accounts = new Accounts();
    }

    public User getUser() {
        return user;
    }

    public Item getItem() {
        return item;
    }

    public Accounts getAccounts() {
        return accounts;
    }

    public static class User {

        private String userCountRegistered;
        private String userCountSellers;
        private String userCountBuyers;
        private String userCountGuests;
        private String userCountCurrent;

        private User() {
        }

        public String getUserCountRegistered() {
            return userCountRegistered;
        }

        public void setUserCountRegistered(String userCountRegistered) {
            this.userCountRegistered = userCountRegistered;
        }

        public String getUserCountSellers() {
            return userCountSellers;
        }

        public void setUserCountSellers(String userCountSellers) {
            this.userCountSellers = userCountSellers;
        }

        public String getUserCountBuyers() {
            return userCountBuyers;
        }

        public void setUserCountBuyers(String userCountBuyers) {
            this.userCountBuyers = userCountBuyers;
        }

        public String getUserCountGuests() {
            return userCountGuests;
        }

        public void setUserCountGuests(String userCountGuests) {
            this.userCountGuests = userCountGuests;
        }

        public String getUserCountCurrent() {
            return userCountCurrent;
        }

        public void setUserCountCurrent(String userCountCurrent) {
            this.userCountCurrent = userCountCurrent;
        }
    }

    public static class Item {

        private String itemCountRegistered;
        private String itemCountStock;
        private String itemCountCart;
        private String itemCountSold;
        private String itemCountCurrent;

        private Item() {
        }

        public String getItemCountRegistered() {
            return itemCountRegistered;
        }

        public void setItemCountRegistered(String itemCountRegistered) {
            this.itemCountRegistered = itemCountRegistered;
        }

        public String getItemCountStock() {
            return itemCountStock;
        }

        public void setItemCountStock(String itemCountStock) {
            this.itemCountStock = itemCountStock;
        }

        public String getItemCountCart() {
            return itemCountCart;
        }

        public void setItemCountCart(String itemCountCart) {
            this.itemCountCart = itemCountCart;
        }

        public String getItemCountSold() {
            return itemCountSold;
        }

        public void setItemCountSold(String itemCountSold) {
            this.itemCountSold = itemCountSold;
        }

        public String getItemCountCurrent() {
            return itemCountCurrent;
        }

        public void setItemCountCurrent(String itemCountCurrent) {
            this.itemCountCurrent = itemCountCurrent;
        }
    }

    public static class Accounts {

        private String totalStockValue;
        private String totalSalesValue;
        private String incomeCommissions;
        private String incomePromotions;
        private String totalIncome;

        private Accounts() {
        }

        public String getTotalStockValue() {
            return totalStockValue;
        }

        public void setTotalStockValue(String totalStockValue) {
            this.totalStockValue = totalStockValue;
        }

        public String getTotalSalesValue() {
            return totalSalesValue;
        }

        public void setTotalSalesValue(String totalSalesValue) {
            this.totalSalesValue = totalSalesValue;
        }

        public String getIncomeCommissions() {
            return incomeCommissions;
        }

        public void setIncomeCommissions(String incomeCommissions) {
            this.incomeCommissions = incomeCommissions;
        }

        public String getIncomePromotions() {
            return incomePromotions;
        }

        public void setIncomePromotions(String incomePromotions) {
            this.incomePromotions = incomePromotions;
        }

        public String getTotalIncome() {
            return totalIncome;
        }

        public void setTotalIncome(String totalIncome) {
            this.totalIncome = totalIncome;
        }
    }

}
