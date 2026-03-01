package utils;

public class EmailUtil {
    // Simple stub -- replace with JavaMail implementation and SMTP config in real deployment
    public static void sendPasswordResetEmail(String toEmail, String resetLink) {
        System.out.println("=== Password reset email ===");
        System.out.println("To: " + toEmail);
        System.out.println("Reset link: " + resetLink);
        System.out.println("NOTE: configure SMTP and replace this stub with real email sending.");
    }
}
