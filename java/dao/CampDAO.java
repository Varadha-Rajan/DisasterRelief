package dao;

import model.Camp;
import utils.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CampDAO {

    public List<Camp> listAll() throws SQLException {
        String sql = "SELECT * FROM camps ORDER BY id";
        List<Camp> list = new ArrayList<>();
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Camp camp = toCamp(rs);
                list.add(camp);
            }
        }
        return list;
    }

    public Camp findById(int id) throws SQLException {
        String sql = "SELECT * FROM camps WHERE id = ?";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return toCamp(rs);
            }
        }
        return null;
    }

    public boolean create(Camp camp) throws SQLException {
        String sql = "INSERT INTO camps (name,capacity,address,city,state,facilities,contact) VALUES (?,?,?,?,?,?,?)";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, camp.getName());
            ps.setInt(2, camp.getCapacity());
            ps.setString(3, camp.getAddress());
            ps.setString(4, camp.getCity());
            ps.setString(5, camp.getState());
            ps.setString(6, camp.getFacilities());
            ps.setString(7, camp.getContact());
            int aff = ps.executeUpdate();
            if (aff == 0) return false;
            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) camp.setId(rs.getInt(1));
            }
            return true;
        }
    }

    public boolean update(Camp camp) throws SQLException {
        String sql = "UPDATE camps SET name=?, capacity=?, address=?, city=?, state=?, facilities=?, contact=? WHERE id = ?";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, camp.getName());
            ps.setInt(2, camp.getCapacity());
            ps.setString(3, camp.getAddress());
            ps.setString(4, camp.getCity());
            ps.setString(5, camp.getState());
            ps.setString(6, camp.getFacilities());
            ps.setString(7, camp.getContact());
            ps.setInt(8, camp.getId());
            return ps.executeUpdate() > 0;
        }
    }

    public boolean delete(int id) throws SQLException {
        String sql = "DELETE FROM camps WHERE id = ?";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        }
    }

    public int currentBookedSlots(int campId) throws SQLException {
        String sql = "SELECT COALESCE(SUM(slots),0) AS booked FROM bookings WHERE camp_id = ? AND status = 'BOOKED'";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, campId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return rs.getInt("booked");
            }
        }
        return 0;
    }

    private Camp toCamp(ResultSet rs) throws SQLException {
        Camp camp = new Camp();
        camp.setId(rs.getInt("id"));
        camp.setName(rs.getString("name"));
        camp.setCapacity(rs.getInt("capacity"));
        camp.setAddress(rs.getString("address"));
        camp.setCity(rs.getString("city"));
        camp.setState(rs.getString("state"));
        camp.setFacilities(rs.getString("facilities"));
        camp.setContact(rs.getString("contact"));
        return camp;
    }
}
