import 'package:fl_sevengen_society_user_app/localization/localization_const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import '../../theme/theme.dart';

class CreditCardScreen extends StatefulWidget {
  const CreditCardScreen({super.key});

  @override
  State<CreditCardScreen> createState() => _CreditCardScreenState();
}

class _CreditCardScreenState extends State<CreditCardScreen> {
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  InputBorder border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10.0),
    borderSide: BorderSide(color: Colors.grey.shade300),
  );

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: whiteColor,
        elevation: 0.0,
        titleSpacing: 0.0,
        centerTitle: false,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: black33Color,
          ),
        ),
        title: Text(
          getTranslate(context, 'credit_card.credit_card'),
          style: semibold18Black33,
        ),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.zero,
        children: [
          creditCard(size),
          creditcardForm(),
          heightSpace,
          heightSpace,
          continueButton(),
        ],
      ),
    );
  }

  continueButton() {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/success');
      },
      child: Container(
        width: double.maxFinite,
        margin: const EdgeInsets.symmetric(
            horizontal: fixPadding * 2.0, vertical: fixPadding * 2.0),
        padding: const EdgeInsets.symmetric(
            horizontal: fixPadding * 2.0, vertical: fixPadding * 1.4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: primaryColor,
          boxShadow: [
            BoxShadow(
                color: primaryColor.withOpacity(0.1),
                blurRadius: 12.0,
                offset: const Offset(0, 6)),
          ],
        ),
        alignment: Alignment.center,
        child: Text(
          getTranslate(context, 'credit_card.continue'),
          style: semibold18White,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  creditcardForm() {
    return CreditCardForm(
      formKey: formKey,
      obscureCvv: true,
      cursorColor: primaryColor,
      cardNumber: cardNumber,
      cvvCode: cvvCode,
      isHolderNameVisible: true,
      isCardNumberVisible: true,
      isExpiryDateVisible: true,
      cardHolderName: cardHolderName,
      expiryDate: expiryDate,
      themeColor: primaryColor,
      cardNumberDecoration: InputDecoration(
        labelText: getTranslate(context, 'credit_card.card_number'),
        hintText: getTranslate(context, 'credit_card.enter_card_number'),
        hintStyle: medium16Grey,
        labelStyle: medium18Grey,
        filled: true,
        fillColor: whiteColor,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        enabledBorder: border,
        focusedBorder: border,
      ),
      expiryDateDecoration: InputDecoration(
        hintStyle: medium16Grey,
        labelStyle: medium18Grey,
        labelText: getTranslate(context, 'credit_card.expire_date'),
        hintText: 'XX/XX',
        filled: true,
        fillColor: whiteColor,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        enabledBorder: border,
        focusedBorder: border,
      ),
      cvvCodeDecoration: InputDecoration(
        hintStyle: medium16Grey,
        labelStyle: medium18Grey,
        labelText: getTranslate(context, 'credit_card.CVV'),
        hintText: 'XXX',
        filled: true,
        fillColor: whiteColor,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        enabledBorder: border,
        focusedBorder: border,
      ),
      cardHolderDecoration: InputDecoration(
        hintStyle: medium16Grey,
        labelStyle: medium18Grey,
        labelText: getTranslate(context, 'credit_card.name_on_card'),
        hintText: getTranslate(context, 'credit_card.enter_name_card'),
        filled: true,
        fillColor: whiteColor,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        enabledBorder: border,
        focusedBorder: border,
      ),
      onCreditCardModelChange: onCreditCardModelChange,
    );
  }

  creditCard(Size size) {
    return CreditCardWidget(
      cardNumber: cardNumber,
      expiryDate: expiryDate,
      cardHolderName: cardHolderName,
      cvvCode: cvvCode,
      showBackView: isCvvFocused,
      cardBgColor: whiteColor,
      backgroundImage: 'assets/creditcard/card-Bg.png',
      obscureCardNumber: true,
      obscureInitialCardNumber: false,
      obscureCardCvv: true,
      isHolderNameVisible: true,
      height: size.height * 0.28,
      isChipVisible: false,
      padding: 20.0,
      bankName: getTranslate(context, 'credit_card.credit_card'),
      cardType: CardType.mastercard,
      isSwipeGestureEnabled: true,
      customCardTypeIcons: <CustomCardTypeIcon>[
        CustomCardTypeIcon(
          cardType: CardType.mastercard,
          cardImage: Image.asset(
            'assets/creditcard/master-logo.png',
            height: 48,
            width: 48,
          ),
        ),
      ],
      onCreditCardWidgetChange: (creditCardBrand) {},
    );
  }

  void onCreditCardModelChange(CreditCardModel? creditCardModel) {
    setState(() {
      cardNumber = creditCardModel!.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }
}
