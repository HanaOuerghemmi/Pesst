// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pesst/common/functions/otp_function.dart';
import 'package:pesst/features/auth/screens/widgets/title_widget.dart';
import 'package:pesst/utils/colors.dart';
import 'package:pesst/utils/helper_padding.dart';
import 'package:pesst/utils/helper_textstyle.dart';



class OtpVerifWWidget extends StatefulWidget {
  final TextEditingController emailController;
  final TextEditingController otp1Controller;
  final TextEditingController otp2Controller;
  final TextEditingController otp3Controller;
  final TextEditingController otp4Controller;
  final TextEditingController otp5Controller;
  final TextEditingController otp6Controller;

  List<String> otp;

  OtpVerifWWidget({
    Key? key,
    required this.emailController,
    required this.otp1Controller,
    required this.otp2Controller,
    required this.otp3Controller,
    required this.otp4Controller,
    required this.otp5Controller,
    required this.otp6Controller,
    required this.otp,
   
  }) : super(key: key);

  @override
  State<OtpVerifWWidget> createState() => _OtpVerifWWidgetState();
}

class _OtpVerifWWidgetState extends State<OtpVerifWWidget> {
  bool verifOTP(String otp, String otpWritten) {
    return otp == otpWritten;
  }

  void updateOTP(List<String> newOTP) {
    setState(() {
      widget.otp = newOTP;
    });
  }

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      child: Column(children: [
        WidgetTitle(
          title: "OTP code verification 🔐",
          subTitle:
              "We have sent an OTP code to your email and ${widget.emailController.text}.\n Enter the OTP code below to verify",
        ),
        mediumPaddingVert,
        //Text(widget.otp[0]),
        FittedBox(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OtpInputField(
                controller: widget.otp1Controller,
              ),
              OtpInputField(
                controller: widget.otp2Controller,
              ),
              OtpInputField(
                controller: widget.otp3Controller,
              ),
              OtpInputField(
                controller: widget.otp4Controller,
              ),
              OtpInputField(
                controller: widget.otp5Controller,
              ),
              OtpInputField(
                controller: widget.otp6Controller,
              ),
            ],
          ),
        ),
        mediumPaddingVert,
        if (!verifOTP(
            widget.otp[0],
            widget.otp1Controller.text +
                widget.otp2Controller.text +
                widget.otp3Controller.text +
                widget.otp4Controller.text +
                widget.otp5Controller.text +
                widget.otp6Controller.text ))
          OtpCounter(
            newotp: () {
              updateOTP(widget.otp);
              sendOTPToEmail(
                widget.emailController.text,
                widget.otp,
              );
            },
          ),
      ]),
    );
  }
}

class OtpInputField extends StatelessWidget {
  final TextEditingController controller;
  const OtpInputField({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 50,
        width: 40,
        decoration: BoxDecoration(
          border: Border.all(width: 1),
          borderRadius: const BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        child: TextField(
          controller: controller,
          maxLength: 1,
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          style: const TextStyle(fontSize: 25),
          decoration: const InputDecoration(
            counterText: '',
          ),
          onChanged: (value) {
            if (value.length == 1) {
              FocusScope.of(context).nextFocus();
            }
          },
        ),
      ),
    );
  }
}

class OtpCounter extends StatefulWidget {
  final Function() newotp;

  const OtpCounter({super.key, required this.newotp});

  @override
  _OtpCounterState createState() => _OtpCounterState();
}

class _OtpCounterState extends State<OtpCounter> {
  int _counter = 60;
  bool _showButton = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    startCounter();
  }

  void startCounter() {
    const oneSecond = const Duration(seconds: 1);
    _timer = Timer.periodic(oneSecond, (Timer timer) {
      setState(() {
        if (_counter > 0) {
          _counter--;
        } else {
          //? When the counter = 0, show the resend button and cancel the timer
          _showButton = true;
          _timer?.cancel();
        }
      });
    });
  }

  void resetCounter() {
    setState(() {
      _counter = 60;
      _showButton = false;
    });
    // Restart the counter
    startCounter();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Didn't receive email?",
          style: textStyleTextBold,
        ),
        RichText(
          text: TextSpan(
            text: 'You can resend code in ',
            style: textStyleTextBold,
            children: [
              TextSpan(
                text: '$_counter',
                style: textStyleTextBold.copyWith(
                    color: primaryColor, fontSize: 20),
              ),
              TextSpan(text: ' s', style: textStyleTextBold)
            ],
          ),
        ),
        mediumPaddingVert,
        _showButton
            ? ElevatedButton(
                onPressed: () {
                  //* Handle button click
                  resetCounter();
                  //* send the new otp
                  widget.newotp();
                },
                child: Text(
                  "Resend OTP",
                  style: textStyleTextBold.copyWith(color: primaryColor),
                ),
              )
            : SizedBox.shrink(),
      ],
    );
  }

  @override
  void dispose() {
    //* Cancel the timer when the widget is disposed
    _timer?.cancel();
    super.dispose();
  }
}
