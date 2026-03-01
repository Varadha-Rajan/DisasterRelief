package dao;

import model.Resource;
import utils.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class ResourceDAO {

    public boolean create(Resource r) throws SQLException {
        String sql = "INSERT INTO resources (ngo_id,type,name,quantity,unit,description) VALUES (?,?,?,?,?,?)";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, r.getNgoId());
            ps.setString(2, r.getType());
            ps.setString(3, r.getName());
            ps.setInt(4, r.getQuantity());
            ps.setString(5, r.getUnit());
            ps.setString(6, r.getDescription());
            int aff = ps.executeUpdate();
            if (aff == 0) return false;
            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) r.setId(rs.getInt(1));
            }
            return true;
        }
    }

    public List<Resource> listAll() throws SQLException {
        String sql = "SELECT * FROM resources ORDER BY created_at DESC";
        List<Resource> list = new ArrayList<>();
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Resource r = toResource(rs);
                list.add(r);
            }
        }
        return list;
    }

    public Resource findById(int id) throws SQLException {
        String sql = "SELECT * FROM resources WHERE id = ?";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return toResource(rs);
            }
        }
        return null;
    }

    public boolean reduceQuantity(int resourceId, int amount) throws SQLException {
        String sql = "UPDATE resources SET quantity = quantity - ? WHERE id = ? AND quantity >= ?";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, amount);
            ps.setInt(2, resourceId);
            ps.setInt(3, amount);
            return ps.executeUpdate() > 0;
        }
    }

    private Resource toResource(ResultSet rs) throws SQLException {
        Resource r = new Resource();
        r.setId(rs.getInt("id"));
        r.setNgoId(rs.getInt("ngo_id"));
        r.setType(rs.getString("type"));
        r.setName(rs.getString("name"));
        r.setQuantity(rs.getInt("quantity"));
        r.setUnit(rs.getString("unit"));
        r.setDescription(rs.getString("description"));
        Timestamp t = rs.getTimestamp("created_at");
        if (t != null) r.setCreatedAt(new Date(t.getTime()));
        return r;
    }
}
