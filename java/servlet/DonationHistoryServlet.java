package servlet;

import dao.DonationDAO;
import model.Donation;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/donation-history")
public class DonationHistoryServlet extends HttpServlet {
    private final DonationDAO dao = new DonationDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Integer userId = (Integer) req.getSession().getAttribute("userId");
        String role = (String) req.getSession().getAttribute("userRole");
        if (userId == null || !"DONOR".equals(role)) {
            resp.sendRedirect("login.jsp?error=Please+login+as+Donor");
            return;
        }

        try {
            List<Donation> list = dao.listByDonor(userId);
            req.setAttribute("donations", list);
            req.getRequestDispatcher("donation_history.jsp").forward(req, resp);
        } catch (SQLException ex) {
            throw new ServletException(ex);
        }
    }
}
