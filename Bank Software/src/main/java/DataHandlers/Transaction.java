package DataHandlers;

import java.sql.Timestamp;

public class Transaction {
    private String id;
    private Timestamp dateTime;
    private String type;
    private String description;
    private double amount;

    public String getId() { return id; }
    public Timestamp getDateTime() { return dateTime; }
    public String getType() { return type; }
    public String getDescription() { return description; }
    public double getAmount() { return amount; }

    public void setId(String id) { this.id = id; }
    public void setDateTime(Timestamp dateTime) { this.dateTime = dateTime; }
    public void setType(String type) { this.type = type; }
    public void setDescription(String description) { this.description = description; }
    public void setAmount(double amount) { this.amount = amount; }
}