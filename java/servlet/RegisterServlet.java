package servlet;

import dao.UserDAO;
import model.User;
import utils.PasswordUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    private final UserDAO dao = new UserDAO();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String name = req.getParameter("name");
        String email = req.getParameter("email");
        String role = req.getParameter("role"); // ADMIN, NGO, DONOR, CITIZEN
        String password = req.getParameter("password");

        if (name == null || email == null || password == null || role == null) {
            resp.sendRedirect("register.jsp?error=Missing+fields");
            return;
        }

        try {
            if (dao.findByEmail(email) != null) {
                resp.sendRedirect("register.jsp?error=Email+already+registered");
                return;
            }

            byte[] salt = PasswordUtil.generateSalt();
            String hash = PasswordUtil.hashPassword(password, salt);

            User u = new User();
            u.setName(name);
            u.setEmail(email);
            u.setRole(role);
            u.setSalt(salt);
            u.setPasswordHash(hash);

            if (dao.create(u)) {
                resp.sendRedirect("login.jsp?msg=Registered+successfully");
            } else {
                resp.sendRedirect("register.jsp?error=Unable+to+register");
            }
        } catch (SQLException ex) {
            throw new ServletException(ex);
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.sendRedirect("register.jsp");
    }
}
