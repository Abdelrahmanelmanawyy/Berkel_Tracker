import 'package:flutter/material.dart';

class Station {
  final int id;
  final String category;
  final String location;
  final String name;

  Station(this.id, {required this.category, required this.location})
    : name = location;

  String get line => category;
}

class StationData {
  static Color getLineColor(String category) {
    switch (category) {
      case "M1A":
        return Colors.red;
      case "M1B":
        return Colors.orange;
      case "M2":
        return Colors.green;
      case "M3":
        return Colors.blue;
      case "M4":
        return Colors.pink;
      case "M5":
        return Colors.purple;
      case "M6":
        return Colors.teal;
      case "M7":
        return Colors.indigo;
      case "M8":
        return Colors.lightBlue.shade900;
      case "M9":
        return Colors.amber.shade700;
      case "M11":
        return Colors.deepOrange.shade300;
      case "F1":
        return Colors.amber;
      case "F2":
        return Colors.amber.shade400;
      case "F4":
        return Colors.amber.shade600;
      case "T1":
        return Colors.red.shade300;
      case "T2":
        return Colors.red.shade400;
      case "T3":
        return Colors.red.shade500;
      case "T4":
        return Colors.red.shade600;
      case "B1":
        return Colors.blueGrey.shade300;
      case "Metrobüs":
        return Colors.black;
      case "Kaymakamlık":
        return Colors.brown;
      case "Valilik":
        return Colors.deepOrange;
      case "Noter":
        return Colors.blueGrey;
      case "Üniversite":
        return Colors.cyan;
      case "Göç İdaresi":
        return Colors.lime;
      case "Havalimanı":
        return Colors.lightBlue;
      case "Vize":
        return Colors.deepPurple;
      case "Otogar":
        return Colors.amber.shade800;
      case "AVM":
        return Colors.lightGreen;
      case "Adliye":
        return Colors.redAccent;
      case "iDATA":
        return Colors.indigoAccent;
      case "Diğer":
        return Colors.grey;
      case "PhotoXbox":
        return Colors.pinkAccent;
      default:
        return Colors.blue;
    }
  }

  static List<Station> getAllStations() {
    return [
      // Metro stations (10001-10100)
      Station(10001, category: "M1A", location: "Ataköy, Şirinevler 1"),
      Station(10002, category: "M1A", location: "Bahçelievler 1"),
      Station(10003, category: "M1A", location: "Terazidere 1"),
      Station(10004, category: "M1A", location: "Kocatepe 1"),
      Station(10005, category: "M1A", location: "Emniyet-Fatih 1"),
      Station(10006, category: "M1A", location: "Aksaray 1"),
      Station(10007, category: "M1B", location: "Kirazlı, Bağcılar 1"),
      Station(10008, category: "M1B", location: "Kirazlı, Bağcılar 2"),
      Station(10009, category: "M1B", location: "Bağcılar Meydan 1"),
      Station(10010, category: "M2", location: "Yenikapı 1"),
      Station(10011, category: "M2", location: "Yenikapı 2"),
      Station(10012, category: "M2", location: "Yenikapı 3"),
      Station(10013, category: "M2", location: "Yenikapı 4"),
      Station(10014, category: "M2", location: "Yenikapı 5"),
      Station(10015, category: "M2", location: "Vezneciler - İst. Ü. 1"),
      Station(10016, category: "M2", location: "Vezneciler - İst. Ü. 2"),
      Station(10017, category: "M2", location: "Haliç 1"),
      Station(10018, category: "M2", location: "Haliç 2"),
      Station(10019, category: "M2", location: "Şişhane 1"),
      Station(10020, category: "M2", location: "Şişhane 2"),
      Station(10021, category: "M2", location: "Taksim 1"),
      Station(10022, category: "M2", location: "Taksim 2"),
      Station(10023, category: "M2", location: "Taksim 3"),
      Station(10024, category: "M2", location: "Taksim 4"),
      Station(10025, category: "M2", location: "Taksim 5"),
      Station(10026, category: "M2", location: "Osmanbey 1"),
      Station(10027, category: "M2", location: "Osmanbey 2"),
      Station(10028, category: "M2", location: "Gayrettepe 1"),
      Station(10029, category: "M2", location: "Gayrettepe 2"),
      Station(10030, category: "M2", location: "Levent 1"),
      Station(10031, category: "M2", location: "Levent 2"),
      Station(10032, category: "M2", location: "4. Levent 1"),
      Station(10033, category: "M2", location: "4. Levent 2"),
      Station(10034, category: "M2", location: "Sanayi Mahallesi 1"),
      Station(10035, category: "M2", location: "İTÜ Ayazağa 1"),
      Station(10036, category: "M2", location: "İTÜ Ayazağa 2"),
      Station(10037, category: "M2", location: "Hacıosman 1"),
      Station(10038, category: "M3", location: "Şehir Hastanesi 1"),
      Station(10039, category: "M3", location: "Başakşehir Metrokent 1"),
      Station(10040, category: "M3", location: "İkitelli Sanayi 1"),
      Station(10041, category: "M3", location: "İncirli 1"),
      Station(10042, category: "M3", location: "Bakırköy 1"),
      Station(10043, category: "M4", location: "Sabiha Gökçen 1"),
      Station(10044, category: "M4", location: "Kurtköy 1"),
      Station(10045, category: "M4", location: "Fevzi Çakmak - Hastane 1"),
      Station(10046, category: "M4", location: "Pendik 1"),
      Station(10047, category: "M4", location: "Kartal 1"),
      Station(10048, category: "M4", location: "Kartal 2"),
      Station(10049, category: "M4", location: "Soğanlık 1"),
      Station(10050, category: "M4", location: "Hastane Adliye 1"),
      Station(10051, category: "M4", location: "Esenkent 1"),
      Station(10052, category: "M4", location: "Maltepe 1"),
      Station(10053, category: "M4", location: "Küçükyalı 1"),
      Station(10054, category: "M4", location: "Bostancı 1"),
      Station(10055, category: "M4", location: "Bostancı 2"),
      Station(10056, category: "M8", location: "Bostancı 3"),
      Station(10057, category: "M4", location: "Kozyatağı 1"),
      Station(10058, category: "M4", location: "Kozyatağı 2"),
      Station(10059, category: "M4", location: "Yenisahra 1"),
      Station(10060, category: "M4", location: "Göztepe 1"),
      Station(10061, category: "M4", location: "Ünalan 1"),
      Station(10062, category: "M4", location: "Ünalan 2"),
      Station(10063, category: "M4", location: "Ünalan 3"),
      Station(10064, category: "M4", location: "Ayrılık Çeşmesi"),
      Station(10065, category: "M4", location: "Kadıköy 1"),
      Station(10066, category: "M4", location: "Kadıköy 2"),
      Station(10067, category: "M5", location: "Üsküdar 1"),
      Station(10068, category: "M5", location: "Üsküdar 2"),
      Station(10069, category: "M5", location: "Üsküdar 3"),
      Station(10070, category: "M5", location: "Bağlarbaşı 1"),
      Station(10071, category: "M5", location: "Altunizade 1"),
      Station(10072, category: "M5", location: "Bulgurlu 1"),
      Station(10073, category: "M5", location: "Ümraniye 1"),
      Station(10074, category: "M5", location: "Çarşı 1"),
      Station(10075, category: "M5", location: "Çakmak 1"),
      Station(10076, category: "M5", location: "Altınşehir 1"),
      Station(10077, category: "M5", location: "Dudullu 1"),
      Station(10078, category: "M5", location: "Dudullu 2"),
      Station(10079, category: "M5", location: "Necip Fazıl 1"),
      Station(10080, category: "M5", location: "Çekmeköy 1"),
      Station(10081, category: "M5", location: "Sarıgazi 1"),
      Station(10082, category: "M5", location: "Sarıgazi 2"),
      Station(10083, category: "M5", location: "Sancaktepe 1"),
      Station(10084, category: "M5", location: "Samandıra Merkez 1"),
      Station(10085, category: "M6", location: "Boğaziçi Ü. Hisarüstü 1"),
      Station(10086, category: "M7", location: "Yıldız 1"),
      Station(10087, category: "M7", location: "Mecidiyeköy 1"),
      Station(10088, category: "M7", location: "Mecidiyeköy 2"),
      Station(10089, category: "M7", location: "Mecidiyeköy 3"),
      Station(10090, category: "M7", location: "Mecidiyeköy 4"),
      Station(10091, category: "M7", location: "Nurtepe 1"),
      Station(10092, category: "M7", location: "Kağıthane 1"),
      Station(10093, category: "M7", location: "Kazım Karabekir 1"),
      Station(10094, category: "M7", location: "Karadeniz Mahallesi 1"),
      Station(10095, category: "M7", location: "Göztepe Mah. 1"),
      Station(10096, category: "M7", location: "Mahmutbey 1"),
      Station(10097, category: "M9", location: "Ataköy 1"),
      Station(10098, category: "M9", location: "Yenibosna 1"),
      Station(10099, category: "M9", location: "Yenibosna 2"),
      Station(10100, category: "F1", location: "Kabataş 1"),

      // Kaymakamlık locations (11001-11021)
      Station(
        11001,
        category: "Kaymakamlık",
        location: "İstanbul - Bakırköy 1",
      ),
      Station(
        11002,
        category: "Kaymakamlık",
        location: "İstanbul - Beylikdüzü 1",
      ),
      Station(11003, category: "Kaymakamlık", location: "Konya - Beyşehir 1"),
      Station(
        11004,
        category: "Kaymakamlık",
        location: "İstanbul - Bozcaada 1",
      ),
      Station(
        11005,
        category: "Kaymakamlık",
        location: "İstanbul - Büyükçekmece 1",
      ),
      Station(
        11006,
        category: "Kaymakamlık",
        location: "İstanbul - Çayırova 1",
      ),
      Station(11007, category: "Kaymakamlık", location: "Konya - Çeltik 1"),
      Station(11008, category: "Kaymakamlık", location: "Kocaeli - Dilovası 1"),
      Station(11009, category: "Kaymakamlık", location: "Balıkesir -Edremit 1"),
      Station(11010, category: "Kaymakamlık", location: "Sakarya - Erenler"),
      Station(
        11011,
        category: "Kaymakamlık",
        location: "İstanbul - Gaziosmanpaşa",
      ),
      Station(11012, category: "Kaymakamlık", location: "Bursa - Görükle"),
      Station(11013, category: "Kaymakamlık", location: "Ankara - Kazan"),
      Station(11014, category: "Kaymakamlık", location: "İstanbul - Pendik"),
      Station(11015, category: "Kaymakamlık", location: "Ankara - Pursaklar"),
      Station(11016, category: "Kaymakamlık", location: "Çankırı - Yapraklı"),
      Station(
        11017,
        category: "Kaymakamlık",
        location: "İstanbul - Başakşehir",
      ),
      Station(11018, category: "Kaymakamlık", location: "İstanbul - Beykoz"),
      Station(11019, category: "Kaymakamlık", location: "Çankırı - Eldivan"),
      Station(11020, category: "Kaymakamlık", location: "Kocaeli - Körfez"),
      Station(
        11021,
        category: "Kaymakamlık",
        location: "İstanbul - Sancaktepe",
      ),

      // Valilik locations (12001-12003)
      Station(12001, category: "Valilik", location: "Kocaeli"),
      Station(12002, category: "Valilik", location: "Siirt"),
      Station(12003, category: "Valilik", location: "Yozgat"),

      // Noter locations (13001-13037)
      Station(13001, category: "Noter", location: "Bağcılar"),
      Station(13002, category: "Noter", location: "Bahçekent Copy Center"),
      Station(13003, category: "Noter", location: "Batışehir"),
      Station(13004, category: "Noter", location: "Cabani İş Merkezi"),
      Station(13005, category: "Noter", location: "Cafe"),
      Station(13006, category: "Noter", location: "İstoç"),
      Station(13007, category: "Noter", location: "Starcity"),
      Station(13008, category: "Noter", location: "Tümsan"),
      Station(13009, category: "Noter", location: "Yedikule"),
      Station(13010, category: "Noter", location: "Başahşehir"),
      Station(13011, category: "Noter", location: "Maslak Oto Sanayi"),
      Station(13012, category: "Noter", location: "Haramidere"),
      Station(13013, category: "Noter", location: "Yeniufuk"),
      Station(13014, category: "Noter", location: "Büyükçekmece"),
      Station(13015, category: "Noter", location: "Opet"),
      Station(13016, category: "Noter", location: "Tütüncü"),
      Station(13017, category: "Noter", location: "Kartal 1"),
      Station(13018, category: "Noter", location: "Kurtköy 1"),
      Station(13019, category: "Noter", location: "Üsküdar 1"),
      Station(13020, category: "Noter", location: "Üsküdar 2"),
      Station(13021, category: "Noter", location: "Üsküdar 3"),
      Station(13022, category: "Noter", location: "Üsküdar 4"),
      Station(13023, category: "Noter", location: "Üsküdar 5"),
      Station(13024, category: "Noter", location: "Candan Dijital"),
      Station(13025, category: "Noter", location: "Kaya Özalit"),
      Station(13026, category: "Noter", location: "Yenibosna Dilekçe"),
      Station(13027, category: "Noter", location: "Aksa Kırtasiye Ozalit"),
      Station(13028, category: "Noter", location: "Çekmeköy Takis Eğlence"),
      Station(13029, category: "Noter", location: "Otonominoter Oto Galeri"),
      Station(13030, category: "Noter", location: "İdeal Sihort"),
      Station(13031, category: "Noter", location: "Sistem Sigorta"),
      Station(13032, category: "Noter", location: "Noter yanı"),
      Station(13033, category: "Noter", location: "Balıkesir - Edremit"),
      Station(13034, category: "Noter", location: "Balıkesir - Altınoluk"),
      Station(13035, category: "Noter", location: "Sakarya"),
      Station(13036, category: "Noter", location: "Gaziantep"),
      Station(13037, category: "Noter", location: "Otosanatkarlar Oto Sanayi"),

      // Üniversite locations (14001-14008)
      Station(14001, category: "Üniversite", location: "Doğuş"),
      Station(14002, category: "Üniversite", location: "İTÜ"),
      Station(14003, category: "Üniversite", location: "Kadir Has"),
      Station(14004, category: "Üniversite", location: "Koç"),
      Station(14005, category: "Üniversite", location: "Kültür"),
      Station(14006, category: "Üniversite", location: "Okan"),
      Station(14007, category: "Üniversite", location: "Özyeğin"),
      Station(14008, category: "Üniversite", location: "Sabancı"),

      // Göç İdaresi locations (15001-15010)
      Station(
        15001,
        category: "Göç İdaresi",
        location: "Kıraç Göç Danışmanlık",
      ),
      Station(
        15002,
        category: "Göç İdaresi",
        location: "Amael Suriyeli Danışmanlık",
      ),
      Station(15003, category: "Göç İdaresi", location: "Ece Danışmanlık"),
      Station(15004, category: "Göç İdaresi", location: "Fi Danışmanlık"),
      Station(15005, category: "Göç İdaresi", location: "Gezgin Danışmanlık"),
      Station(
        15006,
        category: "Göç İdaresi",
        location: "Türk Permit Danışmanlık",
      ),
      Station(15007, category: "Göç İdaresi", location: "Öz İstanbul"),
      Station(15008, category: "Göç İdaresi", location: "İzmir Göç İdaresi"),
      Station(15009, category: "Göç İdaresi", location: "Esra Tercüme"),
      Station(15010, category: "Göç İdaresi", location: "Barış Tercüme"),

      // Havalimanı locations (16001-16006)
      Station(
        16001,
        category: "Havalimanı",
        location: "Havalimanı - 157 - İç hat",
      ),
      Station(
        16002,
        category: "Havalimanı",
        location: "Havalimanı - 257 - Dış hat",
      ),
      Station(
        16003,
        category: "Havalimanı",
        location: "Havalimanı - 357 - İç hat",
      ),
      Station(
        16004,
        category: "Havalimanı",
        location: "Havalimanı - 457 İç Hat",
      ),
      Station(
        16005,
        category: "Havalimanı",
        location: "THY Bakırköy Genel Merkez",
      ),
      Station(16006, category: "Havalimanı", location: "THY Operasyon Merkezi"),

      // Vize locations (17001-17002)
      Station(17001, category: "Vize", location: "Doğan Kırtasiye"),
      Station(17002, category: "Vize", location: "Göktuğ Vize"),

      // Otogar location (18001)
      Station(18001, category: "Otogar", location: "Aşti Otogar"),

      // AVM locations (19001-19004)
      Station(19001, category: "AVM", location: "AVM Buyaka"),
      Station(19002, category: "AVM", location: "Tepe Nautilius Avm"),
      Station(19003, category: "AVM", location: "İstinye Park AVM 1"),
      Station(19004, category: "AVM", location: "İstinye Park AVM 2"),

      // Adliye location (20001)
      Station(20001, category: "Adliye", location: "Çağlayan Adliyesi"),

      // iDATA locations (21001-21009)
      Station(21001, category: "iDATA", location: "iDATA - Ankara"),
      Station(21002, category: "iDATA", location: "iDATA - Antalya"),
      Station(21003, category: "iDATA", location: "iDATA - Bursa"),
      Station(21004, category: "iDATA", location: "iDATA - Gaziantep"),
      Station(21005, category: "iDATA", location: "iDATA - İzmir"),
      Station(21006, category: "iDATA", location: "iDATA - Trabzon"),
      Station(21007, category: "iDATA", location: "iDATA - İstanbul 1"),
      Station(21008, category: "iDATA", location: "iDATA - İstanbul 2"),
      Station(21009, category: "iDATA", location: "iDATA - İstanbul 3"),

      // Diğer locations (22001-22005)
      Station(22001, category: "Diğer", location: "Halk Eğitim Merkezi"),
      Station(22002, category: "Diğer", location: "Vakıfbank Genel Merkez"),
      Station(22003, category: "Diğer", location: "İncirlik Üssü"),
      Station(22004, category: "Diğer", location: "Kıbrıs - Girne"),
      Station(22005, category: "Diğer", location: "Kıbrıs - Lefkoşa"),

      // PhotoXbox locations (23001-23004)
      Station(23001, category: "PhotoXbox", location: "Tem Trafik"),
      Station(23002, category: "PhotoXbox", location: "Dünyam Ofis Kırtasiye"),
      Station(23003, category: "PhotoXbox", location: "Kartal 34 Noter"),
      Station(23004, category: "PhotoXbox", location: "Kartal 36 Noter"),
    ];
  }
}
