package servlet;

import dao.UserDAO;
import utils.EmailUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Timestamp;
import java.time.Instant;
import java.util.UUID;

@WebServlet("/reset-request")
public class PasswordResetRequestServlet extends HttpServlet {
    private final UserDAO dao = new UserDAO();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("email");
        if (email == null) {
            resp.sendRedirect("reset_request.jsp?error=Missing+email");
            return;
        }
        try {
            if (dao.findByEmail(email) == null) {
                // Do not reveal whether email exists for security; still show success message
                resp.sendRedirect("reset_request.jsp?msg=If+the+email+exists+a+reset+link+was+sent");
                return;
            }

            String token = UUID.randomUUID().toString().replaceAll("-", "");
            Timestamp expiry = Timestamp.from(Instant.now().plusSeconds(60 * 60)); // 1 hour
            dao.setResetToken(email, token, expiry);

            String resetLink = req.getRequestURL().toString().replace(req.getServletPath(), "") + "/reset-password.jsp?token=" + token;
            EmailUtil.sendPasswordResetEmail(email, resetLink);

            resp.sendRedirect("reset_request.jsp?msg=If+the+email+exists+a+reset+link+was+sent");
        } catch (Exception ex) {
            throw new ServletException(ex);
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.sendRedirect("reset_request.jsp");
    }
}
