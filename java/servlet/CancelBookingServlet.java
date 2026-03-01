package servlet;

import dao.BookingDAO;
import model.Booking;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/cancel-booking")
public class CancelBookingServlet extends HttpServlet {
    private final BookingDAO dao = new BookingDAO();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Integer userId = (Integer) req.getSession().getAttribute("userId");
        if (userId == null) {
            resp.sendRedirect("login.jsp?error=Please+login");
            return;
        }
        try {
            int bookingId = Integer.parseInt(req.getParameter("bookingId"));
            Booking b = dao.findById(bookingId);
            if (b == null || b.getUserId() != userId) {
                resp.sendRedirect("bookings.jsp?error=Invalid+booking");
                return;
            }
            if ("CANCELLED".equals(b.getStatus())) {
                resp.sendRedirect("bookings.jsp?msg=Already+cancelled");
                return;
            }
            boolean ok = dao.updateStatus(bookingId, "CANCELLED");
            if (ok) resp.sendRedirect("bookings.jsp?msg=Cancelled+successfully");
            else resp.sendRedirect("bookings.jsp?error=Unable+to+cancel");
        } catch (NumberFormatException | SQLException ex) {
            throw new ServletException(ex);
        }
    }
}
