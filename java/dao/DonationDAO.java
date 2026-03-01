package dao;

import model.Donation;
import utils.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class DonationDAO {

    public boolean create(Donation d) throws SQLException {
        String sql = "INSERT INTO donations (donor_id, donation_type, amount, material_description, status, receipt_number) VALUES (?,?,?,?,?,?)";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, d.getDonorId());
            ps.setString(2, d.getDonationType());
            if (d.getAmount() != null) ps.setDouble(3, d.getAmount());
            else ps.setNull(3, Types.DECIMAL);
            if (d.getMaterialDescription() != null) ps.setString(4, d.getMaterialDescription());
            else ps.setNull(4, Types.VARCHAR);
            ps.setString(5, d.getStatus());
            if (d.getReceiptNumber() != null) ps.setString(6, d.getReceiptNumber());
            else ps.setNull(6, Types.VARCHAR);

            int aff = ps.executeUpdate();
            if (aff == 0) return false;
            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) d.setId(rs.getInt(1));
            }
            return true;
        }
    }

    public List<Donation> listByDonor(int donorId) throws SQLException {
        String sql = "SELECT * FROM donations WHERE donor_id = ? ORDER BY created_at DESC";
        List<Donation> list = new ArrayList<>();
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, donorId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) list.add(toDonation(rs));
            }
        }
        return list;
    }

    public Donation findById(int id) throws SQLException {
        String sql = "SELECT * FROM donations WHERE id = ?";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return toDonation(rs);
            }
        }
        return null;
    }

    public boolean updateStatusAndReceipt(int id, String status, String receiptNumber) throws SQLException {
        String sql = "UPDATE donations SET status = ?, receipt_number = ? WHERE id = ?";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setString(2, receiptNumber);
            ps.setInt(3, id);
            return ps.executeUpdate() > 0;
        }
    }

    private Donation toDonation(ResultSet rs) throws SQLException {
        Donation d = new Donation();
        d.setId(rs.getInt("id"));
        d.setDonorId(rs.getInt("donor_id"));
        d.setDonationType(rs.getString("donation_type"));
        double amt = rs.getDouble("amount");
        if (!rs.wasNull()) d.setAmount(amt);
        d.setMaterialDescription(rs.getString("material_description"));
        d.setStatus(rs.getString("status"));
        d.setReceiptNumber(rs.getString("receipt_number"));
        Timestamp t = rs.getTimestamp("created_at");
        if (t != null) d.setCreatedAt(new Date(t.getTime()));
        return d;
    }
}
