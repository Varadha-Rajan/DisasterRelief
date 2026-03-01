package servlet;

import dao.CampDAO;
import model.Camp;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/admin/camps")
public class AdminCampsServlet extends HttpServlet {
    private final CampDAO dao = new CampDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession s = req.getSession(false);
        if (s == null || !"ADMIN".equals(s.getAttribute("userRole"))) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp?error=Not+authorized");
            return;
        }
        try {
            List<Camp> camps = dao.listAll();
            req.setAttribute("camps", camps);
            req.getRequestDispatcher("/admin_manage_camps.jsp").forward(req, resp);
        } catch (SQLException ex) {
            throw new ServletException(ex);
        }
    }
}
