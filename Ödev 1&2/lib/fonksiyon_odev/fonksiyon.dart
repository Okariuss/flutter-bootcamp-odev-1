class Fonksiyon {
  double? soru1(double km) {
    if (km < 0) {
      print("Girilen değer negatif olamaz. Değeri tekrar kontrol ediniz.");
      return null;
    }
    return km * 0.621;
  }

  void soru2(double kisaKenar, double uzunKenar) {
    if (kisaKenar <= 0 || uzunKenar <= 0) {
      print(
          "Kenarlar negatif veya 0 olamaz. Alan hesaplanamıyor. Kenarları tekrar kontrol ediniz.");
    } else {
      print(
          "Kenarları $kisaKenar ve $uzunKenar olan dikdörtgenin alanı ${kisaKenar * uzunKenar}'dir");
    }
  }

  int? soru3(int sayi) {
    if (sayi < 0) {
      print("Girilen değer negatif olamaz. Değeri tekrar kontrol ediniz.");
      return null;
    }
    int sonuc = 1;
    while (sayi >= 1) {
      sonuc *= sayi;
      sayi--;
    }
    return sonuc;
  }

  void soru4(String kelime) {
    int adet = 0;
    for (var harf in kelime.toLowerCase().runes) {
      if (harf == 101) {
        adet++;
      }
    }
    print("$kelime kelimesinde $adet tane e harfi vardır.");
  }

  double? soru5(int kenarSayisi) {
    if (kenarSayisi <= 2) {
      print("Şeklin oluşması için kenar sayısının en az 3 olması gerekiyor.");
      return null;
    }
    return ((kenarSayisi - 2) * 180) / kenarSayisi;
  }

  int? soru6(int gun) {
    int normalMesaiSaati = 150;
    if (gun < 0) {
      print("Lütfen geçerli bir gün giriniz.");
      return null;
    }
    int toplamSaat = gun * 8;
    if (toplamSaat <= 150) {
      return toplamSaat * 40;
    } else {
      int kalanSaat = toplamSaat - normalMesaiSaati;
      return (normalMesaiSaati * 40) + (kalanSaat * 80);
    }
  }

  int? soru7(double toplamSaat) {
    if (toplamSaat < 0) {
      print("Lütfen geçerli bir saat giriniz.");
      return null;
    }
    return 50 + (toplamSaat - 1).ceil() * 10;
  }
}
