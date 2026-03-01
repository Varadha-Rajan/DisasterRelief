package servlet;

import dao.BookingDAO;
import dao.CampDAO;
import model.Camp;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/book-camp")
public class BookCampServlet extends HttpServlet {
    private final BookingDAO bookingDAO = new BookingDAO();
    private final CampDAO campDAO = new CampDAO();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Integer userId = (Integer) req.getSession().getAttribute("userId");
        if (userId == null) {
            resp.sendRedirect("login.jsp?error=Please+login+to+book");
            return;
        }

        try {
            int campId = Integer.parseInt(req.getParameter("campId"));
            int slots = Integer.parseInt(req.getParameter("slots"));
            if (slots <= 0) {
                resp.sendRedirect("camp?id=" + campId + "&error=Invalid+slots");
                return;
            }

            Camp camp = campDAO.findById(campId);
            if (camp == null) {
                resp.sendRedirect("camps?error=Camp+not+found");
                return;
            }

            int booked = campDAO.currentBookedSlots(campId);
            if (booked + slots > camp.getCapacity()) {
                resp.sendRedirect("camp?id=" + campId + "&error=Not+enough+capacity");
                return;
            }

            boolean ok = bookingDAO.create(userId, campId, slots);
            if (ok) resp.sendRedirect("bookings.jsp?msg=Booked+successfully");
            else resp.sendRedirect("camp?id=" + campId + "&error=Unable+to+book");
        } catch (NumberFormatException | SQLException ex) {
            throw new ServletException(ex);
        }
    }
}
