package servlet;

import dao.UserDAO;
import model.User;
import utils.PasswordUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.Date;

@WebServlet("/reset-password")
public class PasswordResetServlet extends HttpServlet {
    private final UserDAO dao = new UserDAO();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String token = req.getParameter("token");
        String password = req.getParameter("password");
        if (token == null || password == null) {
            resp.sendRedirect("reset_password.jsp?token=" + (token==null?"":token) + "&error=Missing+data");
            return;
        }
        try {
            User u = dao.findByResetToken(token);
            if (u == null || u.getResetExpiry() == null || u.getResetExpiry().before(new Date())) {
                resp.sendRedirect("reset_password.jsp?token=" + token + "&error=Invalid+or+expired+token");
                return;
            }

            byte[] newSalt = PasswordUtil.generateSalt();
            String newHash = PasswordUtil.hashPassword(password, newSalt);

            if (dao.updatePassword(u.getId(), newHash, newSalt)) {
                resp.sendRedirect("login.jsp?msg=Password+updated+successfully");
            } else {
                resp.sendRedirect("reset_password.jsp?token=" + token + "&error=Unable+to+update+password");
            }
        } catch (SQLException ex) {
            throw new ServletException(ex);
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.sendRedirect("reset_request.jsp");
    }
}
