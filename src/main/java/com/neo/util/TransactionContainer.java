/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.neo.util;

import com.neo.beans.acc.Transaction;
import java.util.ArrayList;

/**
 *
 * @author neo
 */
public class TransactionContainer {

    private final ArrayList<Transaction> transactions = new ArrayList<>(10);

    public int getTotalCount() {
        return transactions.size();
    }

    public float getTotalAmount() {
        float total = 0;
        for (Transaction transaction : transactions) {
            total += transaction.getAmount();
        }
        return total;
    }

    public String getTotalAmountFormatted() {
        return String.format("%,.2f", getTotalAmount());
    }

    public String getTotalCommissionFormatted() {
        return String.format("%,.2f", getTotalCommission());
    }

    public float getTotalCommission() {
        float total = 0;
        for (Transaction transaction : transactions) {
            total += transaction.getCommissionAmount();
        }
        return total;
    }

    public Transaction[] getTransactions() {
        return AppUtil.toArray(Transaction.class, transactions);
    }

    public void addTransaction(Transaction transaction) {
        if (transaction != null && !transactions.contains(transaction)) {
            transactions.add(transaction);
        }
    }
}
