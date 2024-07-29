import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Curr extends StatefulWidget {
  const Curr({super.key});

  @override
  State<Curr> createState() => _CurrState();
}

class _CurrState extends State<Curr> {
  final TextEditingController textEditingController = TextEditingController();
  double result = 0;
  String selectedCurrency = 'USD';

  // Map of supported currencies with their full names and exchange rates to INR
  final Map<String, Map<String, dynamic>> currencies = {
    'USD': {'fullName': 'United States Dollar', 'rate': 0.012},
    'EUR': {'fullName': 'Euro', 'rate': 0.011},
    'GBP': {'fullName': 'British Pound Sterling', 'rate': 0.0095},
    'JPY': {'fullName': 'Japanese Yen', 'rate': 1.45},
    'AUD': {'fullName': 'Australian Dollar', 'rate': 0.018},
    'CAD': {'fullName': 'Canadian Dollar', 'rate': 0.016},
    'CNY': {'fullName': 'Chinese Yuan', 'rate': 0.078},
    'BTC': {'fullName': 'Bitcoin', 'rate': 0.0000004},
    'INR': {'fullName': 'Indian Rupee', 'rate': 1.0},
    'BRL': {'fullName': 'Brazilian Real', 'rate': 0.060},
    'CHF': {'fullName': 'Swiss Franc', 'rate': 0.011},
    'CUP': {'fullName': 'Cuban Peso', 'rate': 0.45},
    'DKK': {'fullName': 'Danish Krone', 'rate': 0.089},
    'EGP': {'fullName': 'Egyptian Pound', 'rate': 0.37},
    'HKD': {'fullName': 'Hong Kong Dollar', 'rate': 0.094},
    'HUF': {'fullName': 'Hungarian Forint', 'rate': 0.036},
    'ILS': {'fullName': 'Israeli New Shekel', 'rate': 0.044},
    'KRW': {'fullName': 'South Korean Won', 'rate': 1.55},
    'MXN': {'fullName': 'Mexican Peso', 'rate': 0.21},
    'NOK': {'fullName': 'Norwegian Krone', 'rate': 0.11},
    'NZD': {'fullName': 'New Zealand Dollar', 'rate': 0.018},
    'PKR': {'fullName': 'Pakistani Rupee', 'rate': 0.042},
    'PHP': {'fullName': 'Philippine Peso', 'rate': 0.21},
    'RUB': {'fullName': 'Russian Ruble', 'rate': 0.032},
    'SAR': {'fullName': 'Saudi Riyal', 'rate': 0.045},
    'SEK': {'fullName': 'Swedish Krona', 'rate': 0.11},
    'SGD': {'fullName': 'Singapore Dollar', 'rate': 0.016},
    'THB': {'fullName': 'Thai Baht', 'rate': 0.41},
    'TRY': {'fullName': 'Turkish Lira', 'rate': 0.034},
    'UAH': {'fullName': 'Ukrainian Hryvnia', 'rate': 0.32},
    'VND': {'fullName': 'Vietnamese Dong', 'rate': 0.28},
    // Add more currencies as needed
  };

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.black,
        width: 2,
        style: BorderStyle.solid,
      ),
      borderRadius: BorderRadius.all(Radius.circular(10)),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("Currency Converter", style: TextStyle(fontFamily: 'Schyler')),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '$selectedCurrency $result',
                style: TextStyle(
                  fontSize: 65.sp,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Schyler',
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(10.0), // Consistent padding
                child: TextField(
                  controller: textEditingController,
                  style: TextStyle(color: Colors.black, fontFamily: 'Schyler'),
                  decoration: InputDecoration(
                    hintText: 'Please enter the amount in INR',
                    prefixIcon: Icon(Icons.currency_rupee),
                    filled: true,
                    fillColor: Colors.white,
                    focusedBorder: border,
                    enabledBorder: border,
                  ),
                  keyboardType: TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0), // Consistent padding
                child: DropdownButtonFormField<String>(
                  value: selectedCurrency,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.black, width: 2),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.black, width: 2),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.black, width: 2),
                    ),
                  ),
                  icon: Icon(Icons.arrow_drop_down, color: Colors.black),
                  items: currencies.keys.map((String currency) {
                    return DropdownMenuItem<String>(
                      value: currency,
                      child: Text(
                        '${currencies[currency]!['fullName']} (${currency})',
                        style: TextStyle(
                          fontSize: 19, // Adjusted font size
                          color: Colors.black,
                          fontFamily: 'Schyler',
                        ),
                        overflow: TextOverflow.ellipsis, // Handle overflow with ellipsis
                      ),
                    );
                  }).toList(),
                  onChanged: (String? newCurrency) {
                    setState(() {
                      selectedCurrency = newCurrency!;
                      result=0;
                      textEditingController.clear();
                    });
                  },
                )
                ,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0), // Consistent padding
                child: ElevatedButton(
                  onPressed: () {
                    if (textEditingController.text.isEmpty) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text("Error"),
                            content: const Text("Please enter an amount in INR."),
                            actions: [
                              TextButton(
                                child: const Text("OK"),
                                onPressed: () {
                                  Navigator.of(context).pop(); // Close the dialog
                                },
                              ),
                            ],
                          );
                        },
                      );
                    } else {
                      setState(() {
                        double amount = double.parse(textEditingController.text);
                        result = amount * currencies[selectedCurrency]!['rate']!;
                      });
                      FocusScope.of(context).unfocus(); // Close the keyboard
                    }
                  },

                  style: ButtonStyle(
                    elevation: const MaterialStatePropertyAll(15),
                    backgroundColor: const MaterialStatePropertyAll(Colors.black),
                    foregroundColor: const MaterialStatePropertyAll(Colors.white),
                    minimumSize: const MaterialStatePropertyAll(Size(double.infinity, 50)),
                    shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    )),
                  ),
                  child: const Text("Convert", style: TextStyle(fontFamily: 'Schyler')),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
