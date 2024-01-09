import 'package:flutter/material.dart';
import 'package:pesst/common/forget_password/otp_verif_widgets.dart';
import 'package:pesst/utils/colors.dart';
import 'package:pesst/widgets/custom_button.dart';


class OtpScreen extends StatefulWidget {
  final TextEditingController emailController;
  List<String> otp;
  OtpScreen({
    Key? key,
    required this.emailController,
    required this.otp,
  }) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  bool verifOTP(String otp, String otpWritten) {
    return otp == otpWritten;
  }

  @override
  Widget build(BuildContext context) {
    final otp1Controller = TextEditingController();
    final otp2Controller = TextEditingController();
    final otp3Controller = TextEditingController();
    final otp4Controller = TextEditingController();
    final otp5Controller = TextEditingController();
    final otp6Controller = TextEditingController();
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child:

            // otp verif widget ,
            Column(
          children: [
            OtpVerifWWidget(
              emailController: widget.emailController,
              otp: widget.otp,
              otp1Controller: otp1Controller,
              otp2Controller: otp2Controller,
              otp3Controller: otp3Controller,
              otp4Controller: otp4Controller,
              otp5Controller: otp5Controller,
              otp6Controller: otp6Controller,
            ),
            CustomButton(
                colorText: whiteColor,
                textButton: "Continue",
                onPressed: () {
                  if (verifOTP(widget.otp[0], 
                  
                  otp1Controller.text +
              otp2Controller.text +
              otp3Controller.text +
              otp4Controller.text +
              otp5Controller.text +
              otp6Controller.text 
                  )) {
                    print('true');
                    // Navigator.pushNamed(
                    //   context,
                    //   NewPasswordSceen.routeName,
                    //   arguments: {
                    //     'emailController': widget.emailController.text,
                    //   },
                    // );
                  } else {
                    Text("verif ");
                  }
                }),
          ],
        ),
        // button
      ),
    );
  }
}
