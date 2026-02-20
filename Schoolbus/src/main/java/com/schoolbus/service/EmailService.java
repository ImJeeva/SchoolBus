package com.schoolbus.service;

import java.util.Properties;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import org.springframework.stereotype.Service;

@Service
public class EmailService {

	// ===== CHANGE THESE TO YOUR GMAIL DETAILS =====
	private static final String FROM_EMAIL = "jeeva8work@gmail.com";
	private static final String PASSWORD = "rzky pigk dhii pxmj";
	
	private final Session session;  // ← ADD THIS

	// ===== CONSTRUCTOR - Initialize session once =====
	public EmailService() {
		Properties props = new Properties();
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.starttls.enable", "true");
		props.put("mail.smtp.host", "smtp.gmail.com");
		props.put("mail.smtp.port", "587");

		this.session = Session.getInstance(props, new Authenticator() {
			@Override
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(FROM_EMAIL, PASSWORD);
			}
		});
	}

	/**
	 * Sends an email alert to the parent.
	 */
	public void sendEmail(String toEmail, String subject, String body) {
		try {
			Message message = new MimeMessage(session);
			message.setFrom(new InternetAddress(FROM_EMAIL));
			message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
			message.setSubject(subject);
			message.setText(body);

			Transport.send(message);
			System.out.println("✅ Email sent to: " + toEmail);

		} catch (MessagingException e) {
			System.err.println("❌ Email failed to " + toEmail + ": " + e.getMessage());
		}
	}

	/**
	 * Sends BOARDING alert email to parent.
	 */
	public void sendBoardingAlert(String parentEmail, String studentName, String busNumber, String time) {
		String subject = "SchoolBus Alert: " + studentName + " has boarded the bus";
		String body = "Dear Parent,\n\n" 
			+ "This is to inform you that your child " + studentName 
			+ " has BOARDED bus " + busNumber + " at " + time + ".\n\n"
			+ "Have a safe journey!\n\n" 
			+ "Smart School Bus System";
		sendEmail(parentEmail, subject, body);
	}

	/**
	 * Sends DROPOFF alert email to parent.
	 */
	public void sendDropoffAlert(String parentEmail, String studentName, String busNumber, String time) {
		String subject = "SchoolBus Alert: " + studentName + " has been dropped off";
		String body = "Dear Parent,\n\n" 
			+ "This is to inform you that your child " + studentName
			+ " has been DROPPED OFF from bus " + busNumber + " at " + time + ".\n\n"
			+ "Please receive your child.\n\n" 
			+ "Smart School Bus System";
		sendEmail(parentEmail, subject, body);
	}

	/**
	 * Sends contact message from parent to school.
	 */
	public void sendContactMessage(String schoolEmail, String parentEmail, 
	                                String parentName, String subject, String messageBody) {
		try {
			Message message = new MimeMessage(session);
			message.setFrom(new InternetAddress(FROM_EMAIL));
			message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(schoolEmail));
			message.setReplyTo(InternetAddress.parse(parentEmail));
			message.setSubject("Parent Contact: " + subject);

			String htmlContent = 
				"<div style='font-family:Arial,sans-serif;max-width:600px;margin:0 auto;'>"
				+ "<div style='background:#4299e1;color:#fff;padding:20px;border-radius:10px 10px 0 0;'>"
				+ "<h2 style='margin:0;'>📧 Parent Contact Message</h2>"
				+ "</div>"
				+ "<div style='background:#f7fafc;padding:30px;border-radius:0 0 10px 10px;'>"
				+ "<p><strong>From:</strong> " + parentName + " (" + parentEmail + ")</p>"
				+ "<p><strong>Subject:</strong> " + subject + "</p>"
				+ "<hr style='border:none;border-top:1px solid #ddd;margin:20px 0;'/>"
				+ "<p><strong>Message:</strong></p>"
				+ "<div style='background:#fff;padding:15px;border-radius:8px;border-left:4px solid #4299e1;'>"
				+ messageBody.replace("\n", "<br/>")
				+ "</div>"
				+ "<hr style='border:none;border-top:1px solid #ddd;margin:20px 0;'/>"
				+ "<p style='color:#666;font-size:12px;'>"
				+ "Reply to this email to respond directly to the parent."
				+ "</p>"
				+ "</div>"
				+ "</div>";

			message.setContent(htmlContent, "text/html; charset=UTF-8");
			Transport.send(message);

			System.out.println("✅ Contact message sent to: " + schoolEmail);

		} catch (MessagingException e) {
			System.err.println("❌ Error sending contact message: " + e.getMessage());
			e.printStackTrace();
		}
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
 */