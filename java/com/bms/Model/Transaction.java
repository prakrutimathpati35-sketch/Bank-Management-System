package com.bms.Model;

public class Transaction {

    private int transactionId;
    private String type;
    private double amount;
    private String description;
    private String date;

    public Transaction(int transactionId,
                       String type,
                       double amount,
                       String description,
                       String date) {

        this.transactionId = transactionId;
        this.type = type;
        this.amount = amount;
        this.description = description;
        this.date = date;
    }

    public int getTransactionId() {
        return transactionId;
    }

    public String getType() {
        return type;
    }

    public double getAmount() {
        return amount;
    }

    public String getDescription() {
        return description;
    }

    public String getDate() {
        return date;
    }
}