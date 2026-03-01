package servlet;

import dao.CampDAO;
import model.Camp;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/admin/camp-action")
public class AdminCampActionServlet extends HttpServlet {
    private final CampDAO dao = new CampDAO();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession s = req.getSession(false);
        if (s == null || !"ADMIN".equals(s.getAttribute("userRole"))) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp?error=Not+authorized");
            return;
        }

        try {
            String action = req.getParameter("action");
            if ("create".equals(action)) {
                Camp c = new Camp();
                c.setName(req.getParameter("name"));
                c.setCapacity(Integer.parseInt(req.getParameter("capacity")));
                c.setAddress(req.getParameter("address"));
                c.setCity(req.getParameter("city"));
                c.setState(req.getParameter("state"));
                c.setFacilities(req.getParameter("facilities"));
                c.setContact(req.getParameter("contact"));
                dao.create(c);
                resp.sendRedirect(req.getContextPath() + "/admin/camps?msg=Created");
                return;
            } else if ("update".equals(action)) {
                Camp c = new Camp();
                c.setId(Integer.parseInt(req.getParameter("id")));
                c.setName(req.getParameter("name"));
                c.setCapacity(Integer.parseInt(req.getParameter("capacity")));
                c.setAddress(req.getParameter("address"));
                c.setCity(req.getParameter("city"));
                c.setState(req.getParameter("state"));
                c.setFacilities(req.getParameter("facilities"));
                c.setContact(req.getParameter("contact"));
                dao.update(c);
                resp.sendRedirect(req.getContextPath() + "/admin/camps?msg=Updated");
                return;
            } else if ("delete".equals(action)) {
                int id = Integer.parseInt(req.getParameter("id"));
                dao.delete(id);
                resp.sendRedirect(req.getContextPath() + "/admin/camps?msg=Deleted");
                return;
            }

            resp.sendRedirect(req.getContextPath() + "/admin/camps");
        } catch (NumberFormatException | SQLException ex) {
            throw new ServletException(ex);
        }
    }
}
