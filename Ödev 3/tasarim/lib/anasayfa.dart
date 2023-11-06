import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:tasarim/renkler.dart';

class Anasayfa extends StatefulWidget {
  const Anasayfa({super.key});

  @override
  State<Anasayfa> createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {
  @override
  Widget build(BuildContext context) {
    var d = AppLocalizations.of(context)!;
    var ekranBilgisi = MediaQuery.sizeOf(context);
    final double ekranGenisligi = ekranBilgisi.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          d.appBarTitle,
          style: TextStyle(
            fontSize: ekranGenisligi / 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: ekranGenisligi / 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DefaultTitle(name: d.addressHeader, size: ekranGenisligi),
                DefaultContainer(
                  widget: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        "images/location.png",
                        scale: 2,
                      ),
                      Padding(
                        padding: EdgeInsets.all(ekranGenisligi / 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ContainerHeaderText(
                                  size: ekranGenisligi,
                                  name: d.addressTitle,
                                ),
                                ContainerSubtitleText(
                                  size: ekranGenisligi,
                                  name: d.address,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DefaultTitle(name: d.bookingHeader, size: ekranGenisligi),
                DefaultContainer(
                  widget: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      DefaultContainer(
                        widget: Image.asset(
                          "images/toyota.png",
                          scale: 25,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(ekranGenisligi / 30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ContainerHeaderText(
                                  size: ekranGenisligi,
                                  name: d.carName,
                                ),
                                Row(
                                  children: [
                                    Image.asset(
                                      "images/rate.png",
                                      scale: 20,
                                    ),
                                    Text(
                                      "(${d.carRating})",
                                      style: TextStyle(
                                        fontSize: ekranGenisligi / 35,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            ContainerSubtitleText(
                              size: ekranGenisligi,
                              name: d.carBookingPrice,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Column(
              children: [
                DefaultContainer(
                  widget: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(d.carRental),
                      Text(d.carRentalPrice),
                    ],
                  ),
                ),
                DefaultContainer(
                  widget: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(d.carBooking),
                      Text(d.carBookingPrice),
                    ],
                  ),
                ),
                DefaultContainer(
                  widget: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(d.carDue),
                      Text(d.carDuePrice),
                    ],
                  ),
                ),
                DefaultContainer(
                  widget: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DefaultTitle(
                          name: d.carTotal, size: ekranGenisligi / 1.5),
                      DefaultTitle(
                          name: d.carTotalPrice, size: ekranGenisligi / 1.5),
                    ],
                  ),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: buttonRenk,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              child: Text(d.buttonTitle),
            ),
          ],
        ),
      ),
    );
  }
}

class ContainerSubtitleText extends StatelessWidget {
  const ContainerSubtitleText({
    super.key,
    required this.size,
    required this.name,
  });

  final double size;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Text(
      name,
      style: TextStyle(color: yaziRenk2, fontSize: size / 25),
    );
  }
}

class ContainerHeaderText extends StatelessWidget {
  const ContainerHeaderText({
    super.key,
    required this.size,
    required this.name,
  });

  final double size;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Text(
      name,
      style: TextStyle(
          color: yaziRenk1, fontWeight: FontWeight.bold, fontSize: size / 25),
    );
  }
}

class DefaultContainer extends StatelessWidget {
  const DefaultContainer({
    super.key,
    required this.widget,
  });

  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: widget,
        ),
      ),
    );
  }
}

class DefaultTitle extends StatelessWidget {
  const DefaultTitle({
    super.key,
    required this.name,
    required this.size,
  });

  final String name;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Text(
      name,
      style: TextStyle(
        color: yaziRenk1,
        fontWeight: FontWeight.bold,
        fontSize: size / 20,
      ),
    );
  }
}
