package com.schoolbus.service;

import com.twilio.Twilio;
import com.twilio.rest.api.v2010.account.Message;
import com.twilio.type.PhoneNumber;
import org.springframework.stereotype.Service;

@Service
public class SmsService {

    // ===== REPLACE THESE WITH YOUR TWILIO CREDENTIALS =====
    private static final String ACCOUNT_SID = "YOUR_TWILIO_ACCOUNT_SID";
    private static final String AUTH_TOKEN   = "YOUR_TWILIO_AUTH_TOKEN";
    private static final String FROM_NUMBER  = "+1XXXXXXXXXX"; // Your Twilio phone number

    static {
        Twilio.init(ACCOUNT_SID, AUTH_TOKEN);
    }

    /**
     * Send an SMS alert to a parent phone number.
     *
     * @param toPhone  Parent's phone number (e.g., "+919876543210")
     * @param message  Alert message text
     */
    public void sendSms(String toPhone, String message) {
        try {
            Message.creator(
                    new PhoneNumber(toPhone),
                    new PhoneNumber(FROM_NUMBER),
                    message
            ).create();
            System.out.println("SMS sent to: " + toPhone);
        } catch (Exception e) {
            System.err.println("SMS failed to " + toPhone + ": " + e.getMessage());
        }
    }

    /**
     * Send a BOARDING alert.
     */
    public void sendBoardingAlert(String parentPhone, String studentName, String busNumber, String time) {
        String msg = "SCHOOLBUS ALERT: " + studentName + " has BOARDED bus " + busNumber + " at " + time + ". Stay safe!";
        sendSms(parentPhone, msg);
    }

    /**
     * Send a DROP-OFF alert.
     */
    public void sendDropoffAlert(String parentPhone, String studentName, String busNumber, String time) {
        String msg = "SCHOOLBUS ALERT: " + studentName + " has been DROPPED OFF from bus " + busNumber + " at " + time + ". Please receive your child.";
        sendSms(parentPhone, msg);
    }
}