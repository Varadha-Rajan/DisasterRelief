package servlet;

import dao.UserDAO;
import model.User;
import utils.PasswordUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private final UserDAO dao = new UserDAO();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("email");
        String password = req.getParameter("password");

        try {
            User u = dao.findByEmail(email);
            if (u == null || !PasswordUtil.verify(password, u.getSalt(), u.getPasswordHash())) {
                resp.sendRedirect("login.jsp?error=Invalid+credentials");
                return;
            }

            HttpSession session = req.getSession(true);
            session.setAttribute("userId", u.getId());
            session.setAttribute("userName", u.getName());
            session.setAttribute("userRole", u.getRole());
            session.setMaxInactiveInterval(30 * 60); // 30 minutes

            // Set session cookie flags (setSecure(true) in production with HTTPS)
            Cookie sessionCookie = new Cookie("JSESSIONID", session.getId());
            sessionCookie.setHttpOnly(true);
            sessionCookie.setSecure(false);
            sessionCookie.setPath(req.getContextPath().isEmpty() ? "/" : req.getContextPath());
            resp.addCookie(sessionCookie);

            // Redirect to dispatcher which will forward to role-specific dashboard
            resp.sendRedirect(req.getContextPath() + "/dashboard");
        } catch (SQLException ex) {
            throw new ServletException(ex);
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.sendRedirect("login.jsp");
    }
}
