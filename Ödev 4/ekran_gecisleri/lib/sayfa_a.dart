import 'package:ekran_gecisleri/sayfa_b.dart';
import 'package:flutter/material.dart';

class SayfaA extends StatefulWidget {
  const SayfaA({super.key});

  @override
  State<SayfaA> createState() => _SayfaAState();
}

class _SayfaAState extends State<SayfaA> {
  @override
  Widget build(BuildContext context) {
    var ekranBilgisi = MediaQuery.sizeOf(context);
    final double ekranGenisligi = ekranBilgisi.width;
    return Scaffold(
      backgroundColor: const Color.fromRGBO(210, 135, 85, 1),
      appBar: AppBar(
        title: const Text("Sayfa A"),
        backgroundColor: Colors.transparent,
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
                    builder: (context) => const SayfaB(),
                  ),
                );
              },
              child: const Text("GİT > B"),
            ),
          ),
        ],
      ),
    );
  }
}
