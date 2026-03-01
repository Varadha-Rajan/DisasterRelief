package servlet;

import dao.ResourceDAO;
import model.Resource;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/resources")
public class ResourcesListServlet extends HttpServlet {
    private final ResourceDAO dao = new ResourceDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            List<Resource> list = dao.listAll();
            req.setAttribute("resources", list);
            req.getRequestDispatcher("resources.jsp").forward(req, resp);
        } catch (SQLException ex) {
            throw new ServletException(ex);
        }
    }
}
