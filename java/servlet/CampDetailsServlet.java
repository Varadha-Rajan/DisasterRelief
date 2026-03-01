package servlet;

import dao.CampDAO;
import model.Camp;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/camp")
public class CampDetailsServlet extends HttpServlet {
    private final CampDAO dao = new CampDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String idStr = req.getParameter("id");
        if (idStr == null) {
            resp.sendRedirect("camps");
            return;
        }
        try {
            int id = Integer.parseInt(idStr);
            Camp camp = dao.findById(id);
            if (camp == null) {
                resp.sendRedirect("camps");
                return;
            }
            int booked = dao.currentBookedSlots(id);
            req.setAttribute("camp", camp);
            req.setAttribute("booked", booked);
            req.getRequestDispatcher("camp_details.jsp").forward(req, resp);
        } catch (NumberFormatException | SQLException ex) {
            throw new ServletException(ex);
        }
    }
}
