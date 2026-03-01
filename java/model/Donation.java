package model;

import java.util.Date;

public class Donation {
    private int id;
    private int donorId;
    private String donationType; // MONEY or MATERIAL
    private Double amount; // for MONEY
    private String materialDescription; // for MATERIAL
    private String status; // PENDING, COMPLETED, FAILED
    private String receiptNumber;
    private Date createdAt;

    // getters / setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public int getDonorId() { return donorId; }
    public void setDonorId(int donorId) { this.donorId = donorId; }
    public String getDonationType() { return donationType; }
    public void setDonationType(String donationType) { this.donationType = donationType; }
    public Double getAmount() { return amount; }
    public void setAmount(Double amount) { this.amount = amount; }
    public String getMaterialDescription() { return materialDescription; }
    public void setMaterialDescription(String materialDescription) { this.materialDescription = materialDescription; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    public String getReceiptNumber() { return receiptNumber; }
    public void setReceiptNumber(String receiptNumber) { this.receiptNumber = receiptNumber; }
    public Date getCreatedAt() { return createdAt; }
    public void setCreatedAt(Date createdAt) { this.createdAt = createdAt; }
}
