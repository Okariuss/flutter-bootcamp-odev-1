import 'package:homework_1/fonksiyon_odev/fonksiyon.dart';

void main() {
  var fonksiyon = Fonksiyon();

  double km = -3;
  double? sonuc1 = fonksiyon.soru1(km);
  if (sonuc1 != null) {
    print("$km km = $sonuc1");
  }

  double kisaKenar = 15, uzunKenar = -30;
  fonksiyon.soru2(kisaKenar, uzunKenar);

  int sayi = 5;
  int? sonuc3 = fonksiyon.soru3(sayi);
  if (sonuc3 != null) {
    print("$sayi! = $sonuc3");
  }

  String kelime = "Okan";
  fonksiyon.soru4(kelime);

  int kenarSayisi = 1;
  double? sonuc5 = fonksiyon.soru5(kenarSayisi);
  if (sonuc5 != null) {
    print("$kenarSayisi kenarlı şeklin her bir iç açısı $sonuc5'dir");
  }

  int gun = 20;
  int? sonuc6 = fonksiyon.soru6(gun);
  if (sonuc6 != null) {
    print("$gun gün sonunda alınacak toplam maaş $sonuc6'dır");
  }

  double toplamSaat = 3;
  int? sonuc7 = fonksiyon.soru7(toplamSaat);
  if (sonuc7 != null) {
    print(
        "$toplamSaat saat park sonunda otoparka ödeyeceğiniz ücret $sonuc7'dir");
  }
}
