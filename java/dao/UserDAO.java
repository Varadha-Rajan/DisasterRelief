package dao;

import model.User;
import utils.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class UserDAO {

    // --- Create / Register user ---
    public boolean create(User u) throws SQLException {
        String sql = "INSERT INTO users (name, email, role, password_hash, salt) VALUES (?,?,?,?,?)";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, u.getName());
            ps.setString(2, u.getEmail());
            ps.setString(3, u.getRole());
            ps.setString(4, u.getPasswordHash());
            ps.setBytes(5, u.getSalt());
            int affected = ps.executeUpdate();
            if (affected == 0) return false;
            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) u.setId(rs.getInt(1));
            }
            return true;
        }
    }

    // --- Find by email (used by Login, Register check, Reset request) ---
    public User findByEmail(String email) throws SQLException {
        String sql = "SELECT * FROM users WHERE email = ?";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, email);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return toUserFull(rs);
            }
        }
        return null;
    }

    // --- Find by id ---
    public User findById(int id) throws SQLException {
        String sql = "SELECT * FROM users WHERE id = ?";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return toUserFull(rs);
            }
        }
        return null;
    }

    // --- Reset token handling ---
    public boolean setResetToken(String email, String token, Timestamp expiry) throws SQLException {
        String sql = "UPDATE users SET reset_token = ?, reset_expiry = ? WHERE email = ?";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, token);
            ps.setTimestamp(2, expiry);
            ps.setString(3, email);
            return ps.executeUpdate() > 0;
        }
    }

    public User findByResetToken(String token) throws SQLException {
        String sql = "SELECT * FROM users WHERE reset_token = ?";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, token);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return toUserFull(rs);
            }
        }
        return null;
    }

    // --- Update password (after reset) ---
    public boolean updatePassword(int userId, String hash, byte[] salt) throws SQLException {
        String sql = "UPDATE users SET password_hash = ?, salt = ?, reset_token = NULL, reset_expiry = NULL WHERE id = ?";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, hash);
            ps.setBytes(2, salt);
            ps.setInt(3, userId);
            return ps.executeUpdate() > 0;
        }
    }

    // --- Admin: list all users ---
    public List<User> listAll() throws SQLException {
        String sql = "SELECT id, name, email, role, created_at, reset_token, reset_expiry FROM users ORDER BY id";
        List<User> list = new ArrayList<>();
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                User u = new User();
                u.setId(rs.getInt("id"));
                u.setName(rs.getString("name"));
                u.setEmail(rs.getString("email"));
                u.setRole(rs.getString("role"));
                Timestamp t = rs.getTimestamp("reset_expiry");
                if (t != null) u.setResetExpiry(new Date(t.getTime()));
                list.add(u);
            }
        }
        return list;
    }

    // --- Admin: change role ---
    public boolean changeRole(int userId, String newRole) throws SQLException {
        String sql = "UPDATE users SET role = ? WHERE id = ?";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, newRole);
            ps.setInt(2, userId);
            return ps.executeUpdate() > 0;
        }
    }

    // --- Admin: delete user ---
    public boolean deleteUser(int userId) throws SQLException {
        String sql = "DELETE FROM users WHERE id = ?";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, userId);
            return ps.executeUpdate() > 0;
        }
    }

    // --- Helper: map ResultSet to User (full fields used by servlets) ---
    private User toUserFull(ResultSet rs) throws SQLException {
        User u = new User();
        u.setId(rs.getInt("id"));
        u.setName(rs.getString("name"));
        u.setEmail(rs.getString("email"));
        u.setRole(rs.getString("role"));
        u.setPasswordHash(rs.getString("password_hash"));
        byte[] salt = rs.getBytes("salt");
        u.setSalt(salt);
        try {
            u.setResetToken(rs.getString("reset_token"));
        } catch (SQLException ignore) {}
        try {
            Timestamp t = rs.getTimestamp("reset_expiry");
            if (t != null) u.setResetExpiry(new Date(t.getTime()));
        } catch (SQLException ignore) {}
        return u;
    }
}
