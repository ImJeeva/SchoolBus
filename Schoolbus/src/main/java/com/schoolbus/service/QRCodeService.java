package com.schoolbus.service;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.util.Base64;

import org.springframework.stereotype.Service;

import com.google.zxing.BarcodeFormat;
import com.google.zxing.WriterException;
import com.google.zxing.client.j2se.MatrixToImageWriter;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.qrcode.QRCodeWriter;

@Service
public class QRCodeService {

    // QR code image size in pixels
    private static final int WIDTH  = 250;
    private static final int HEIGHT = 250;

    /**
     * Generates a QR code image for a student and returns it as a Base64 string.
     * This Base64 string is directly used in JSP as an <img> tag src.
     *
     * @param qrCodeValue  The unique student code (e.g. "STU-001")
     * @return Base64 encoded PNG image string
     */
    public String generateQRCodeBase64(String qrCodeValue) {
        try {
            QRCodeWriter qrCodeWriter = new QRCodeWriter();
            BitMatrix bitMatrix = qrCodeWriter.encode(qrCodeValue, BarcodeFormat.QR_CODE, WIDTH, HEIGHT);

            ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
            MatrixToImageWriter.writeToStream(bitMatrix, "PNG", outputStream);

            byte[] imageBytes = outputStream.toByteArray();
            return Base64.getEncoder().encodeToString(imageBytes);

        } catch (WriterException | IOException e) {
            e.printStackTrace();
            return null;
        }
    }

    /**
     * Generates a unique QR code value for a student.
     * Format: STU-{studentId}
     * Example: STU-1, STU-2, STU-3
     *
     * @param studentId  The student's database ID
     * @return Unique QR code string
     */
    public String generateQRCodeValue(int studentId) {
        return "STU-" + studentId;
    }
}