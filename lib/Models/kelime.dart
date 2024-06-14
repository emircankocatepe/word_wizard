class Kelime {
  String turkce;
  String ingilizce;
  bool ogrenildi;
  int correction = 0;
  Kelime(this.turkce, this.ingilizce, this.ogrenildi);

  Map<String, dynamic> toMap() {
    return {
      "turkce": turkce,
      "ingilizce": ingilizce,
      "ogrenildi": ogrenildi,
    };
  }

  Kelime.fromMap(Map<String, dynamic> map)
      : turkce = map["turkce"],
        ingilizce = map["ingilizce"],
        ogrenildi = map["ogrenildi"];
}
