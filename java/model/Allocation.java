package model;

import java.util.Date;

public class Allocation {
    private int id;
    private int resourceId;
    private int campId;
    private int quantity;
    private int allocatedBy;
    private Date allocatedAt;

    // getters & setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public int getResourceId() { return resourceId; }
    public void setResourceId(int resourceId) { this.resourceId = resourceId; }
    public int getCampId() { return campId; }
    public void setCampId(int campId) { this.campId = campId; }
    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }
    public int getAllocatedBy() { return allocatedBy; }
    public void setAllocatedBy(int allocatedBy) { this.allocatedBy = allocatedBy; }
    public Date getAllocatedAt() { return allocatedAt; }
    public void setAllocatedAt(Date allocatedAt) { this.allocatedAt = allocatedAt; }
}
