package model;

import java.util.Date;

public class Booking {
    private int id;
    private int userId;
    private int campId;
    private int slots;
    private String status; // BOOKED, CANCELLED, CHECKED_IN
    private Date bookedAt;
    private Date updatedAt;

    // getters / setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }
    public int getCampId() { return campId; }
    public void setCampId(int campId) { this.campId = campId; }
    public int getSlots() { return slots; }
    public void setSlots(int slots) { this.slots = slots; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    public Date getBookedAt() { return bookedAt; }
    public void setBookedAt(Date bookedAt) { this.bookedAt = bookedAt; }
    public Date getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(Date updatedAt) { this.updatedAt = updatedAt; }
}
