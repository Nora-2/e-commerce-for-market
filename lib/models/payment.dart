import 'package:Shop/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PaymentScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment'),
        backgroundColor: Colors.white,
         elevation: 0,
            iconTheme: IconThemeData(
            color: Colors.purple
          ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset('assets/images/credit_card.png',
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Name on Card',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Card Number',
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(16),
                  ],
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your card number';
                    }
                    if (value.length != 16) {
                      return 'Invalid card number';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Expiration Date',
                        ),
                        keyboardType: TextInputType.datetime,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(4),
                          CardMonthInputFormatter(),
                        ],
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter expiration date';
                          }
                          if (!CardUtils.validateDate(value)) {
                            return 'Invalid expiration date';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'CVV',
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(3),
                        ],
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter CVV';
                          }
                          if (value.length != 3) {
                            return 'Invalid CVV';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,//change background color of button
                          backgroundColor: Colors.purple,//change text color of button
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          elevation: 15.0,
                        ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                       snackBar(
                                title: "Pay",
                                message: "Successfully payed",
                               );
                      }
                    },
                    child: Text('Submit Payment'),
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

class CardMonthInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    var dateText = _addSlash(newValue.text);
    return newValue.copyWith(
      text: dateText,
      selection: TextSelection.collapsed(offset: dateText.length),
);
}

String _addSlash(String value) {
var dateText = value.replaceAll(RegExp(r'\D+'), '');
if (dateText.length > 2) {
dateText = 'dateText.substring(0,2)/{dateText.substring(2)}';
}
return dateText;
}
}

class CardUtils {
static bool validateDate(String value) {
if (value.length != 4) {
return false;
}
final month = int.tryParse(value.substring(0, 2));
final year = int.tryParse(value.substring(2));
if (month == null || year == null) {
return false;
}
if (month < 1 || month > 12) {
return false;
}
final now = DateTime.now();
final expiry = DateTime(year, month);
return expiry.isAfter(now);
}
}