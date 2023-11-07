import 'package:flutter/material.dart';

class SayfaY extends StatefulWidget {
  const SayfaY({super.key});

  @override
  State<SayfaY> createState() => _SayfaYState();
}

class _SayfaYState extends State<SayfaY> {
  Future<bool> geriDonusTusu(BuildContext context) async {
    Navigator.of(context).popUntil((route) => route.isFirst);
    return false;
  }

  @override
  Widget build(BuildContext context) {
    var ekranBilgisi = MediaQuery.sizeOf(context);
    final double ekranGenisligi = ekranBilgisi.width;
    return Scaffold(
      backgroundColor: Colors.yellow,
      appBar: AppBar(
        title: const Text("Sayfa Y"),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
      ),
      body: WillPopScope(
        onWillPop: () => geriDonusTusu(context),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.all(ekranGenisligi / 20),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
                child: const Text("Anasayfaya Dön"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
