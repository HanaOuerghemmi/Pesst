import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:otp/otp.dart';

//!Function to generate OTP code
List<String> generateOTP() {
    String secretKey = 'KseJboUwSF';
    List<String> otp =[];
   otp.add(
    OTP.generateTOTPCodeString(
      secretKey,
      DateTime.now().millisecondsSinceEpoch,
    ),
  );
    return otp;
  }
//?Function to send mail
//! gmail information

  final String username = 'hanadeveloper.app@gmail.com';
  final String password = 'rule mgff xwig baxx';
  Future<void> sendEmail(
      {required String to,
      required String subject,
      required String body}) async {
    final smtpServer = gmail(username, password);
    final message = Message()
      ..from = Address(username, 'Pesst')
      ..recipients.add(to)
      ..subject = subject
      ..text = body;

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ${sendReport.toString()}');
    } catch (e) {
      print('Error sending email: $e');
    }
  }
 
//?Function to send OTP code
  Future<void> sendOTPToEmail(String email, otp) async {
    
    try {
      await sendEmail(
        to: email,
        subject: 'Your Pesst OTP Code',
        body: 'Your OTP code is: $otp',
      );
      print('OTP sent to $email successfully');
    } catch (e) {
      print('Error sending OTP to $email: $e');
    }
  }

