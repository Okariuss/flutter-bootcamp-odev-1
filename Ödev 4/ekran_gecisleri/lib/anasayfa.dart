import 'package:ekran_gecisleri/sayfa_a.dart';
import 'package:ekran_gecisleri/sayfa_x.dart';
import 'package:flutter/material.dart';

class Anasayfa extends StatefulWidget {
  const Anasayfa({super.key});

  @override
  State<Anasayfa> createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {
  @override
  Widget build(BuildContext context) {
    var ekranBilgisi = MediaQuery.sizeOf(context);
    final double ekranGenisligi = ekranBilgisi.width;
    return Scaffold(
      backgroundColor: const Color.fromRGBO(115, 150, 205, 1),
      appBar: AppBar(
        title: const Text("Anasayfa"),
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.all(ekranGenisligi / 20),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SayfaA(),
                  ),
                );
              },
              child: const Text("GİT > A"),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(ekranGenisligi / 20),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SayfaX(),
                  ),
                );
              },
              child: const Text("GİT > X"),
            ),
          ),
        ],
      ),
    );
  }
}
