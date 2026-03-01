package servlet;

import dao.AllocationDAO;
import dao.ResourceDAO;
import model.Allocation;
import model.Resource;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/resource-report")
public class ResourceReportServlet extends HttpServlet {
    private final ResourceDAO rdao = new ResourceDAO();
    private final AllocationDAO adao = new AllocationDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            List<Resource> resources = rdao.listAll();
            List<Allocation> allocations = adao.listAll();
            req.setAttribute("resources", resources);
            req.setAttribute("allocations", allocations);
            req.getRequestDispatcher("resource_report.jsp").forward(req, resp);
        } catch (SQLException ex) {
            throw new ServletException(ex);
        }
    }
}
