import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import paket intl

void main() {
  runApp(const CurrencyConverterApp());
}

class CurrencyConverterApp extends StatelessWidget {
  const CurrencyConverterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: CurrencyConverter(),
    );
  }
}

class CurrencyConverter extends StatefulWidget {
  const CurrencyConverter({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CurrencyConverterState createState() => _CurrencyConverterState();
}

class _CurrencyConverterState extends State<CurrencyConverter> {
  String _selectedCurrency = 'USD';
  double _convertedAmount = 0.0;
  final TextEditingController _amountController = TextEditingController();

  // Nilai tukar statis (simulasi)
  final Map<String, double> _exchangeRates = {
    'USD': 15000.0, // 1 USD = 15,000 IDR
    'EUR': 17000.0, // 1 EUR = 17,000 IDR
    'GBP': 20000.0, // 1 GBP = 20,000 IDR
  };

  // Fungsi untuk mengonversi mata uang
  void _convertCurrency() {
    double amount = double.parse(_amountController.text);
    setState(() {
      _convertedAmount = amount * _exchangeRates[_selectedCurrency]!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Konversi Uang'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Stack(
        children: [
          // Gambar background dari internet
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                    'https://i.pinimg.com/564x/51/ff/65/51ff658f78fd8ca1268f9ca20d4c6983.jpg'),
                fit: BoxFit.cover, // Agar gambar menyesuaikan ukuran layar
              ),
            ),
          ),
          // Elemen UI lainnya
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DropdownButton<String>(
                  value: _selectedCurrency,
                  items: ['USD', 'EUR', 'GBP'].map((String currency) {
                    // Mengubah warna teks berdasarkan nilai mata uang
                    Color textColor;
                    Color backgroundColor = Colors.white
                        .withOpacity(0.8); // Latar belakang transparan

                    if (currency == 'USD') {
                      textColor = Colors.green;
                    } else if (currency == 'EUR') {
                      textColor = Colors.blue;
                    } else {
                      textColor = Colors.red;
                    }
                    return DropdownMenuItem<String>(
                      value: currency,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 16.0),
                        decoration: BoxDecoration(
                          color: backgroundColor,
                          borderRadius:
                              BorderRadius.circular(8.0), // Sudut membulat
                        ),
                        child: Text(
                          currency,
                          style: TextStyle(
                              color: textColor), // Ganti warna sesuai mata uang
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      _selectedCurrency = newValue!;
                    });
                  },
                ),
                TextField(
                  controller: _amountController,
                  decoration: InputDecoration(
                    labelText: 'Enter amount in $_selectedCurrency',
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.7),
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _convertCurrency,
                  child: const Text('Convert to IDR'),
                ),
                const SizedBox(height: 20),
                // Output hasil konversi dengan latar belakang
                Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8), // Latar belakang transparan
                    borderRadius: BorderRadius.circular(8.0), // Sudut membulat
                  ),
                  child: Text(
                    'Converted Amount: Rp ${NumberFormat.currency(locale: 'id_ID', symbol: '') .format(_convertedAmount)}', // Menggunakan intl untuk format
                    style: const TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0), fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
