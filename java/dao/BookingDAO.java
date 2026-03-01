package dao;

import model.Booking;
import utils.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class BookingDAO {

    public boolean create(int userId, int campId, int slots) throws SQLException {
        String sql = "INSERT INTO bookings (user_id, camp_id, slots) VALUES (?,?,?)";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, userId);
            ps.setInt(2, campId);
            ps.setInt(3, slots);
            int r = ps.executeUpdate();
            return r > 0;
        }
    }

    public List<Booking> listByUser(int userId) throws SQLException {
        String sql = "SELECT * FROM bookings WHERE user_id = ? ORDER BY booked_at DESC";
        List<Booking> list = new ArrayList<>();
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Booking b = toBooking(rs);
                    list.add(b);
                }
            }
        }
        return list;
    }

    public Booking findById(int id) throws SQLException {
        String sql = "SELECT * FROM bookings WHERE id = ?";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return toBooking(rs);
            }
        }
        return null;
    }

    public boolean updateStatus(int bookingId, String status) throws SQLException {
        String sql = "UPDATE bookings SET status = ?, updated_at = CURRENT_TIMESTAMP WHERE id = ?";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setInt(2, bookingId);
            return ps.executeUpdate() > 0;
        }
    }

    private Booking toBooking(ResultSet rs) throws SQLException {
        Booking b = new Booking();
        b.setId(rs.getInt("id"));
        b.setUserId(rs.getInt("user_id"));
        b.setCampId(rs.getInt("camp_id"));
        b.setSlots(rs.getInt("slots"));
        b.setStatus(rs.getString("status"));
        Timestamp t1 = rs.getTimestamp("booked_at");
        if (t1 != null) b.setBookedAt(new Date(t1.getTime()));
        Timestamp t2 = rs.getTimestamp("updated_at");
        if (t2 != null) b.setUpdatedAt(new Date(t2.getTime()));
        return b;
    }
}
