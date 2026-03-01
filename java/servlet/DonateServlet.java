package servlet;

import dao.DonationDAO;
import model.Donation;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.UUID;

@WebServlet("/donate")
public class DonateServlet extends HttpServlet {
    private final DonationDAO dao = new DonationDAO();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Integer userId = (Integer) req.getSession().getAttribute("userId");
        String role = (String) req.getSession().getAttribute("userRole");
        if (userId == null || !"DONOR".equals(role)) {
            resp.sendRedirect("login.jsp?error=Please+login+as+Donor+to+donate");
            return;
        }

        try {
            String type = req.getParameter("donationType"); // MONEY or MATERIAL
            Donation d = new Donation();
            d.setDonorId(userId);
            d.setDonationType(type);

            if ("MONEY".equals(type)) {
                String amountStr = req.getParameter("amount");
                double amount = Double.parseDouble(amountStr);
                if (amount <= 0) {
                    resp.sendRedirect("donate.jsp?error=Invalid+amount");
                    return;
                }
                d.setAmount(amount);

                // STUB: pretend payment succeeded. Replace with real gateway integration.
                boolean paymentOk = true; // integrate real payment here

                if (paymentOk) {
                    String receipt = "RCPT-" + UUID.randomUUID().toString().replaceAll("-", "").substring(0,12).toUpperCase();
                    d.setStatus("COMPLETED");
                    d.setReceiptNumber(receipt);
                } else {
                    d.setStatus("FAILED");
                }
            } else { // MATERIAL
                String desc = req.getParameter("materialDescription");
                if (desc == null || desc.trim().isEmpty()) {
                    resp.sendRedirect("donate.jsp?error=Describe+your+material+donation");
                    return;
                }
                d.setMaterialDescription(desc);
                d.setStatus("PENDING"); // NGO/Admin will mark as received later
            }

            if (dao.create(d)) {
                if (d.getStatus() != null && "COMPLETED".equals(d.getStatus())) {
                    resp.sendRedirect("receipt?id=" + d.getId());
                } else {
                    resp.sendRedirect("donation_history.jsp?msg=Donation+recorded");
                }
            } else {
                resp.sendRedirect("donate.jsp?error=Unable+to+save+donation");
            }
        } catch (NumberFormatException | SQLException ex) {
            throw new ServletException(ex);
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.sendRedirect("donate.jsp");
    }
}
