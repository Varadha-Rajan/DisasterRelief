package servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/dashboard")
public class DashboardRedirectServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession s = req.getSession(false);
        if (s == null || s.getAttribute("userId") == null) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp?error=Please+login");
            return;
        }

        String role = (String) s.getAttribute("userRole");
        if (role == null) role = "CITIZEN";

        switch (role) {
            case "NGO":
                req.getRequestDispatcher("dashboard_ngo.jsp").forward(req, resp);
                break;
            case "ADMIN":
                req.getRequestDispatcher("dashboard_admin.jsp").forward(req, resp);
                break;
            case "DONOR":
                req.getRequestDispatcher("dashboard_donor.jsp").forward(req, resp);
                break;
            default: // CITIZEN and others
                req.getRequestDispatcher("dashboard_citizen.jsp").forward(req, resp);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }
}
