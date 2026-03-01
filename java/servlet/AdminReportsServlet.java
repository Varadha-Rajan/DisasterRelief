package servlet;

import dao.AllocationDAO;
import dao.BookingDAO;
import dao.CampDAO;
import dao.DonationDAO;
import dao.ResourceDAO;
import model.Allocation;
import model.Booking;
import model.Camp;
import model.Donation;
import model.Resource;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/admin/reports")
public class AdminReportsServlet extends HttpServlet {
    private final CampDAO campDAO = new CampDAO();
    private final BookingDAO bookingDAO = new BookingDAO();
    private final AllocationDAO allocationDAO = new AllocationDAO();
    private final ResourceDAO resourceDAO = new ResourceDAO();
    private final DonationDAO donationDAO = new DonationDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession s = req.getSession(false);
        if (s == null || !"ADMIN".equals(s.getAttribute("userRole"))) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp?error=Not+authorized");
            return;
        }

        try {
            List<Camp> camps = campDAO.listAll();
            // occupancy: for each camp compute booked slots
            Map<Integer, Integer> bookedMap = new HashMap<>();
            for (Camp c : camps) {
                bookedMap.put(c.getId(), campDAO.currentBookedSlots(c.getId()));
            }

            // allocations per camp
            List<Allocation> allocations = allocationDAO.listAll();
            Map<Integer, Integer> allocatedPerCamp = new HashMap<>();
            for (Allocation a : allocations) {
                allocatedPerCamp.put(a.getCampId(), allocatedPerCamp.getOrDefault(a.getCampId(), 0) + a.getQuantity());
            }

            // donation summary
            List<Donation> donationsAll = donationDAO.listByDonor(0); // we will add listAll if needed
            // donationDAO currently has listByDonor; instead use SQL here:
            // For now we'll sum donations by querying donation table via DonationDAO or adapt
            // We'll use a helper: DonationDAO.listAll (below) - ensure you add it or we can run raw SQL

            // For simplicity, add donationsAll via DonationDAO.listAll() if present
            // but in case not present, we will set as empty list
            // (I'll provide a listAll method for DonationDAO below — add it if not already present)

            req.setAttribute("camps", camps);
            req.setAttribute("bookedMap", bookedMap);
            req.setAttribute("allocatedPerCamp", allocatedPerCamp);
            req.getRequestDispatcher("/admin_reports.jsp").forward(req, resp);
        } catch (SQLException ex) {
            throw new ServletException(ex);
        }
    }
}
