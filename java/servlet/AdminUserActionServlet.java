package servlet;

import dao.UserDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/admin/user-action")
public class AdminUserActionServlet extends HttpServlet {
    private final UserDAO dao = new UserDAO();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession s = req.getSession(false);
        if (s == null || !"ADMIN".equals(s.getAttribute("userRole"))) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp?error=Not+authorized");
            return;
        }

        try {
            String action = req.getParameter("action");
            int userId = Integer.parseInt(req.getParameter("userId"));

            if ("delete".equals(action)) {
                dao.deleteUser(userId);
                resp.sendRedirect(req.getContextPath() + "/admin/users?msg=Deleted");
                return;
            } else if ("changeRole".equals(action)) {
                String newRole = req.getParameter("newRole");
                dao.changeRole(userId, newRole);
                resp.sendRedirect(req.getContextPath() + "/admin/users?msg=Role+updated");
                return;
            }
            resp.sendRedirect(req.getContextPath() + "/admin/users");
        } catch (NumberFormatException | SQLException ex) {
            throw new ServletException(ex);
        }
    }
}
