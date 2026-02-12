package com.schoolbus.service;

import org.springframework.stereotype.Service;

import javax.mail.*;
import javax.mail.internet.*;
import java.util.Properties;

@Service
public class EmailService {

    // ===== CHANGE THESE TO YOUR GMAIL DETAILS =====
    private static final String FROM_EMAIL = "jeeva8work@gmail.com";  // your Gmail
    private static final String PASSWORD   = "rzky pigk dhii pxmj";        // Gmail App Password (not your login password)
    // NOTE: Use Gmail App Password — see instructions below

    /**
     * Sends an email alert to the parent.
     *
     * @param toEmail   Parent's email address
     * @param subject   Email subject
     * @param body      Email body message
     */
    public void sendEmail(String toEmail, String subject, String body) {

        // Gmail SMTP settings
        Properties props = new Properties();
        props.put("mail.smtp.auth",            "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host",            "smtp.gmail.com");
        props.put("mail.smtp.port",            "587");

        // Create session with Gmail credentials
        Session session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(FROM_EMAIL, PASSWORD);
            }
        });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(FROM_EMAIL));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject(subject);
            message.setText(body);

            Transport.send(message);
            System.out.println("Email sent to: " + toEmail);

        } catch (MessagingException e) {
            System.err.println("Email failed to " + toEmail + ": " + e.getMessage());
        }
    }


    public void sendBoardingAlert(String parentEmail, String studentName,
                                   String busNumber, String time) {
        String subject = "SchoolBus Alert: " + studentName + " has boarded the bus";
        String body    = "Dear Parent,\n\n"
                       + "This is to inform you that your child " + studentName
                       + " has BOARDED bus " + busNumber
                       + " at " + time + ".\n\n"
    
                       + "Have a safe journey!\n\n"
                       + "Smart School Bus System";
        sendEmail(parentEmail, subject, body);
    }

    /**
     * Sends DROPOFF alert email to parent.
     */
    public void sendDropoffAlert(String parentEmail, String studentName,
                                  String busNumber, String time) {
        String subject = "SchoolBus Alert: " + studentName + " has been dropped off";
        String body    = "Dear Parent,\n\n"
                       + "This is to inform you that your child " + studentName
                       + " has been DROPPED OFF from bus " + busNumber
                       + " at " + time + ".\n\n"
                       + "Please receive your child.\n\n"
                       + "Smart School Bus System";
        sendEmail(parentEmail, subject, body);
    }
}

/*
 * ===== HOW TO GET GMAIL APP PASSWORD =====
 *
 * 1. Go to your Google Account → myaccount.google.com
 * 2. Click "Security"
 * 3. Under "How you sign in to Google" → enable 2-Step Verification
 * 4. Search "App Passwords" in the search bar
 * 5. Select App = "Mail", Device = "Other" → type "SchoolBus"
 * 6. Click Generate → copy the 16-character password
 * 7. Paste that password in PASSWORD field above
 *
 * Example:
 * FROM_EMAIL = "myschoolbus2024@gmail.com"
 * PASSWORD   = "abcd efgh ijkl mnop"  (16 char app password)
 */