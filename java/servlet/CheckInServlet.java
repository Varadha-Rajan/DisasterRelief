package servlet;

import dao.BookingDAO;
import model.Booking;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/checkin")
public class CheckInServlet extends HttpServlet {
    private final BookingDAO dao = new BookingDAO();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Only NGO staff or Admin should perform check-in usually.
        String role = (String) req.getSession().getAttribute("userRole");
        if (role == null || !(role.equals("NGO") || role.equals("ADMIN"))) {
            resp.sendRedirect("dashboard.jsp?error=Not+authorized+to+check-in");
            return;
        }
        try {
            int bookingId = Integer.parseInt(req.getParameter("bookingId"));
            Booking b = dao.findById(bookingId);
            if (b == null) {
                resp.sendRedirect("dashboard.jsp?error=Invalid+booking");
                return;
            }
            if ("CHECKED_IN".equals(b.getStatus())) {
                resp.sendRedirect("dashboard.jsp?msg=Already+checked+in");
                return;
            }
            boolean ok = dao.updateStatus(bookingId, "CHECKED_IN");
            if (ok) resp.sendRedirect("dashboard.jsp?msg=Checked+in");
            else resp.sendRedirect("dashboard.jsp?error=Unable+to+check+in");
        } catch (NumberFormatException | SQLException ex) {
            throw new ServletException(ex);
        }
    }
}
