import 'package:flutter/material.dart';
import 'dart:math';
import '../style/color.dart';
import 'success_reset_screen.dart';

class OtpScreen extends StatefulWidget {
  final String email;
  const OtpScreen({required this.email});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final _otpController = TextEditingController();
  bool _autoFilled = false;

  @override
  void initState() {
    super.initState();
    _startAutoFillOtp();
  }

  void _startAutoFillOtp() {
    // Generate random 6 digit OTP
    String randomOtp =
        List.generate(6, (_) => Random().nextInt(10).toString()).join();
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _autoFilled = true;
        _otpController.text = randomOtp;
      });
    });
  }

  void _goToSuccess() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
          builder: (_) => SuccessResetScreen(email: widget.email)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: AppColors.Black),
        title: Text('Forgot password',
            style:
                TextStyle(color: AppColors.Black, fontWeight: FontWeight.bold)),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: AppColors.grey.withOpacity(0.08),
                  blurRadius: 16,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Type a code',
                    style: TextStyle(
                        color: AppColors.grey, fontWeight: FontWeight.w500),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _otpController,
                        enabled: false,
                        style: TextStyle(
                          color: AppColors.Black, // atau AppColors.Primary
                          fontWeight: FontWeight.bold,
                          letterSpacing: 6,
                          fontSize: 22,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Code',
                          filled: true,
                          fillColor: AppColors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(
                                color: AppColors.grey.withOpacity(0.2)),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 14),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.Primary,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                        padding:
                            EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                      ),
                      onPressed: () {
                        // Dummy resend
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Code resent!')));
                      },
                      child: Text('Resend'),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "We texted you a code to verify your email ${widget.email} \nThis code will expired 10 minutes after this message. If you don't get a message.",
                    style: TextStyle(color: AppColors.grey, fontSize: 14),
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _autoFilled
                          ? AppColors.Primary
                          : AppColors.grey.withOpacity(0.2),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24)),
                    ),
                    onPressed: _autoFilled ? _goToSuccess : null,
                    child: Text(
                      'Change password',
                      style: TextStyle(
                        color: _autoFilled ? AppColors.white : AppColors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
