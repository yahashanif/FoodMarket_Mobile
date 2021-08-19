part of 'pages.dart';

class PaymentMethodPage extends StatelessWidget {
  final String paymentURL;

  PaymentMethodPage(this.paymentURL);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: IllustrationPage(
        title: "Finish Your Payment",
        subtitle: "Please select your favorite\npayment method",
        picturePath: "assets/Payment.png",
        buttonTitle1: "Payment Method",
        buttonTap1: () async {
          await launch(paymentURL);
        },
        buttonTitle2: "Continue",
        buttonTap2: () {
          Get.to(SuccessOrderPage());
        },
      ),
    );
  }
}
