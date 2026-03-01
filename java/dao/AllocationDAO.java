package dao;

import model.Allocation;
import utils.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class AllocationDAO {

    public boolean create(Allocation a) throws SQLException {
        String sql = "INSERT INTO allocations (resource_id,camp_id,quantity,allocated_by) VALUES (?,?,?,?)";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, a.getResourceId());
            ps.setInt(2, a.getCampId());
            ps.setInt(3, a.getQuantity());
            ps.setInt(4, a.getAllocatedBy());
            int aff = ps.executeUpdate();
            if (aff == 0) return false;
            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) a.setId(rs.getInt(1));
            }
            return true;
        }
    }

    public List<Allocation> listByResource(int resourceId) throws SQLException {
        String sql = "SELECT * FROM allocations WHERE resource_id = ? ORDER BY allocated_at DESC";
        List<Allocation> list = new ArrayList<>();
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, resourceId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) list.add(toAllocation(rs));
            }
        }
        return list;
    }

    public List<Allocation> listAll() throws SQLException {
        String sql = "SELECT * FROM allocations ORDER BY allocated_at DESC";
        List<Allocation> list = new ArrayList<>();
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) list.add(toAllocation(rs));
        }
        return list;
    }

    private Allocation toAllocation(ResultSet rs) throws SQLException {
        Allocation a = new Allocation();
        a.setId(rs.getInt("id"));
        a.setResourceId(rs.getInt("resource_id"));
        a.setCampId(rs.getInt("camp_id"));
        a.setQuantity(rs.getInt("quantity"));
        a.setAllocatedBy(rs.getInt("allocated_by"));
        Timestamp t = rs.getTimestamp("allocated_at");
        if (t != null) a.setAllocatedAt(new Date(t.getTime()));
        return a;
    }
}
