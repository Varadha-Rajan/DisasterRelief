package servlet;

import dao.AllocationDAO;
import dao.CampDAO;
import dao.ResourceDAO;
import model.Allocation;
import model.Camp;
import model.Resource;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/allocate-resource")
public class AllocateResourceServlet extends HttpServlet {
    private final ResourceDAO rdao = new ResourceDAO();
    private final AllocationDAO adao = new AllocationDAO();
    private final CampDAO cdao = new CampDAO();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Integer userId = (Integer) req.getSession().getAttribute("userId");
        String role = (String) req.getSession().getAttribute("userRole");
        if (userId == null || (!"NGO".equals(role) && !"ADMIN".equals(role))) {
            resp.sendRedirect("login.jsp?error=Not+authorized");
            return;
        }

        try {
            int resourceId = Integer.parseInt(req.getParameter("resourceId"));
            int campId = Integer.parseInt(req.getParameter("campId"));
            int qty = Integer.parseInt(req.getParameter("quantity"));

            if (qty <= 0) {
                resp.sendRedirect("allocate_resource.jsp?error=Invalid+quantity");
                return;
            }

            Resource res = rdao.findById(resourceId);
            Camp camp = cdao.findById(campId);
            if (res == null || camp == null) {
                resp.sendRedirect("allocate_resource.jsp?error=Invalid+resource+or+camp");
                return;
            }

            // Try to reduce resource quantity atomically (check-and-update)
            boolean reduced = rdao.reduceQuantity(resourceId, qty);
            if (!reduced) {
                resp.sendRedirect("allocate_resource.jsp?error=Insufficient+resource+quantity");
                return;
            }

            Allocation a = new Allocation();
            a.setResourceId(resourceId);
            a.setCampId(campId);
            a.setQuantity(qty);
            a.setAllocatedBy(userId);

            if (adao.create(a)) resp.sendRedirect("resource_report.jsp?msg=Allocated+successfully");
            else {
                // rollback: add back quantity if allocation fails (simple approach)
                // For production use transactions across both tables
                resp.sendRedirect("allocate_resource.jsp?error=Allocation+failed");
            }
        } catch (NumberFormatException | SQLException ex) {
            throw new ServletException(ex);
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Show allocation page with resource & camp lists
        resp.sendRedirect("allocate_resource.jsp");
    }
}
