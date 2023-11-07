import 'package:ekran_gecisleri/sayfa_y.dart';
import 'package:flutter/material.dart';

class SayfaB extends StatefulWidget {
  const SayfaB({super.key});

  @override
  State<SayfaB> createState() => _SayfaBState();
}

class _SayfaBState extends State<SayfaB> {
  @override
  Widget build(BuildContext context) {
    var ekranBilgisi = MediaQuery.sizeOf(context);
    final double ekranGenisligi = ekranBilgisi.width;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Sayfa B"),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.all(ekranGenisligi / 20),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SayfaY(),
                  ),
                );
              },
              child: const Text("GİT > Y"),
            ),
          ),
        ],
      ),
    );
  }
}
