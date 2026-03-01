package servlet;

import dao.DonationDAO;
import model.Donation;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/receipt")
public class ReceiptServlet extends HttpServlet {
    private final DonationDAO dao = new DonationDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Integer userId = (Integer) req.getSession().getAttribute("userId");
        String role = (String) req.getSession().getAttribute("userRole");
        if (userId == null || !"DONOR".equals(role)) {
            resp.sendRedirect("login.jsp?error=Please+login+as+Donor");
            return;
        }

        String idStr = req.getParameter("id");
        if (idStr == null) {
            resp.sendRedirect("donation-history.jsp?error=Invalid+receipt");
            return;
        }

        try {
            int id = Integer.parseInt(idStr);
            Donation d = dao.findById(id);
            if (d == null || d.getDonorId() != userId) {
                resp.sendRedirect("donation-history.jsp?error=No+access+to+receipt");
                return;
            }
            req.setAttribute("donation", d);
            req.getRequestDispatcher("receipt.jsp").forward(req, resp);
        } catch (NumberFormatException | SQLException ex) {
            throw new ServletException(ex);
        }
    }
}
