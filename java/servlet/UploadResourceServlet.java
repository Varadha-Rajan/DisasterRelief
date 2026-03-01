package servlet;

import dao.ResourceDAO;
import model.Resource;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/upload-resource")
public class UploadResourceServlet extends HttpServlet {
    private final ResourceDAO dao = new ResourceDAO();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Integer userId = (Integer) req.getSession().getAttribute("userId");
        String role = (String) req.getSession().getAttribute("userRole");
        if (userId == null || !"NGO".equals(role)) {
            resp.sendRedirect("login.jsp?error=Please+login+as+NGO+to+upload");
            return;
        }

        try {
            String type = req.getParameter("type");
            String name = req.getParameter("name");
            int quantity = Integer.parseInt(req.getParameter("quantity"));
            String unit = req.getParameter("unit");
            String desc = req.getParameter("description");

            if (quantity <= 0) {
                resp.sendRedirect("upload_resource.jsp?error=Invalid+quantity");
                return;
            }

            Resource r = new Resource();
            r.setNgoId(userId);
            r.setType(type);
            r.setName(name);
            r.setQuantity(quantity);
            r.setUnit(unit);
            r.setDescription(desc);

            if (dao.create(r)) resp.sendRedirect("resources?msg=Resource+uploaded");
            else resp.sendRedirect("upload_resource.jsp?error=Unable+to+upload");
        } catch (NumberFormatException | SQLException ex) {
            throw new ServletException(ex);
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.sendRedirect("upload_resource.jsp");
    }
}
