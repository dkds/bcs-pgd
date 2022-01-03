/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.neo.beans.acc;

import com.neo.beans.item.Item;
import com.neo.beans.user.User;
import com.neo.util.AppConst;
import java.util.Date;

/**
 *
 * @author neo
 */
public class Transaction {

    private User buyer;
    private Item item;
    private long time;
    private float commissionPersentage;
    private int count;

    public Transaction() {
    }

    public Transaction(User buyer, Item item, long time, float commissionPersentage, int count) {
        this.buyer = buyer;
        this.item = item;
        this.time = time;
        this.commissionPersentage = commissionPersentage;
        this.count = count;
    }

    public User getBuyer() {
        return buyer;
    }

    public void setBuyer(User buyer) {
        this.buyer = buyer;
    }

    public User getSeller() {
        if (item != null) {
            return item.getSeller();
        }
        return null;
    }

    public Item getItem() {
        return item;
    }

    public void setItem(Item item) {
        this.item = item;
    }

    public Date getTime() {
        return new Date(time);
    }

    public void setTime(long time) {
        this.time = time;
    }

    public String getTimeFormatted() {
        return AppConst.Application.DEFAULT_DATE_FORMAT.format(getTime());
    }

    public float getCommissionPersentage() {
        return commissionPersentage;
    }

    public void setCommissionPersentage(float commissionPersentage) {
        this.commissionPersentage = commissionPersentage;
    }

    public float getCommissionAmount() {
        if (item != null) {
            return (item.getUnitprice() * (getCommissionPersentage() / 100)) * item.getQuantity();
        }
        return 0;
    }

    public float getAmount() {
        if (item != null) {
            return (item.getUnitprice() * item.getQuantity());
        }
        return 0;
    }

    public String getAmountFormatted() {
        return String.format("%,.2f", getAmount());
    }

    public String getCommissionPersentageFormatted() {
        return String.format("%,.2f", getCommissionPersentage());
    }

    public String getCommissionAmountFormatted() {
        return String.format("%,.2f", getCommissionAmount());
    }

    public int getCount() {
        return count;
    }

    public void setCount(int count) {
        this.count = count;
    }
}
