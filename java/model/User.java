package model;

import java.util.Date;

public class User {
    private int id;
    private String name;
    private String email;
    private String role; // ADMIN, NGO, DONOR, CITIZEN
    private String passwordHash;
    private byte[] salt;
    private String resetToken;
    private Date resetExpiry;

    // getters & setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    public String getRole() { return role; }
    public void setRole(String role) { this.role = role; }
    public String getPasswordHash() { return passwordHash; }
    public void setPasswordHash(String passwordHash) { this.passwordHash = passwordHash; }
    public byte[] getSalt() { return salt; }
    public void setSalt(byte[] salt) { this.salt = salt; }
    public String getResetToken() { return resetToken; }
    public void setResetToken(String resetToken) { this.resetToken = resetToken; }
    public Date getResetExpiry() { return resetExpiry; }
    public void setResetExpiry(Date resetExpiry) { this.resetExpiry = resetExpiry; }
}
