class GameOdd {
  String homeOd;
  String drawOd;
  String awayOd;

  GameOdd({required this.homeOd, required this.drawOd, required this.awayOd});

  factory GameOdd.fromJson(Map<String, dynamic> json) {
   return  GameOdd(
      homeOd: json['home_od'],
      drawOd: json['draw_od'],
      awayOd: json['away_od'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['home_od'] = homeOd;
    data['draw_od'] = drawOd;
    data['away_od'] = awayOd;
    return data;
  }
}
