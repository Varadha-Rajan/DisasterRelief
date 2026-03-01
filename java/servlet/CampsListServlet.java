package servlet;

import dao.CampDAO;
import model.Camp;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/camps")
public class CampsListServlet extends HttpServlet {
    private final CampDAO dao = new CampDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            List<Camp> camps = dao.listAll();
            req.setAttribute("camps", camps);
            req.getRequestDispatcher("camps.jsp").forward(req, resp);
        } catch (SQLException ex) {
            throw new ServletException(ex);
        }
    }
}
