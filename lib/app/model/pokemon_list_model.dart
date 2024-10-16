class PokemonListModel {
  List<PokemonModel>? list;
  int? page;
  int? pageSize;
  int? count;
  int? totalCount;

  PokemonListModel(
      {this.list, this.page, this.pageSize, this.count, this.totalCount});

  PokemonListModel.fromJson(Map<String, dynamic> json) {
    list = json["data"] == null
        ? null
        : (json["data"] as List).map((e) => PokemonModel.fromJson(e)).toList();
    page = json["page"];
    pageSize = json["pageSize"];
    count = json["count"];
    totalCount = json["totalCount"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (list != null) {
      data["data"] = list?.map((e) => e.toJson()).toList();
    }
    data["page"] = page;
    data["pageSize"] = pageSize;
    data["count"] = count;
    data["totalCount"] = totalCount;
    return data;
  }

  PokemonListModel copyWith({
    List<PokemonModel>? list,
    int? page,
    int? pageSize,
    int? count,
    int? totalCount,
  }) =>
      PokemonListModel(
        list: list ?? this.list,
        page: page ?? this.page,
        pageSize: pageSize ?? this.pageSize,
        count: count ?? this.count,
        totalCount: totalCount ?? this.totalCount,
      );
}

class PokemonModel {
  String? id;
  String? name;
  String? supertype;
  List<String>? subtypes;
  String? hp;
  List<String>? types;
  String? evolvesFrom;
  List<Attacks>? attacks;
  List<Weaknesses>? weaknesses;
  List<Resistances>? resistances;
  List<String>? retreatCost;
  int? convertedRetreatCost;
  Set? set;
  String? number;
  String? artist;
  String? rarity;
  String? flavorText;
  List<int>? nationalPokedexNumbers;
  Legalities1? legalities;
  Images1? images;
  Tcgplayer? tcgplayer;
  Cardmarket? cardmarket;

  PokemonModel(
      {this.id,
      this.name,
      this.supertype,
      this.subtypes,
      this.hp,
      this.types,
      this.evolvesFrom,
      this.attacks,
      this.weaknesses,
      this.resistances,
      this.retreatCost,
      this.convertedRetreatCost,
      this.set,
      this.number,
      this.artist,
      this.rarity,
      this.flavorText,
      this.nationalPokedexNumbers,
      this.legalities,
      this.images,
      this.tcgplayer,
      this.cardmarket});

  PokemonModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"] ?? "";
    supertype = json["supertype"] ?? "-";
    subtypes =
        json["subtypes"] == null ? null : List<String>.from(json["subtypes"]);
    hp = json["hp"] ?? "";
    types = json["types"] == null ? null : List<String>.from(json["types"]);
    evolvesFrom = json["evolvesFrom"] ??"-";
    attacks = json["attacks"] == null
        ? null
        : (json["attacks"] as List).map((e) => Attacks.fromJson(e)).toList();
    weaknesses = json["weaknesses"] == null
        ? null
        : (json["weaknesses"] as List)
            .map((e) => Weaknesses.fromJson(e))
            .toList();
    resistances = json["resistances"] == null
        ? null
        : (json["resistances"] as List)
            .map((e) => Resistances.fromJson(e))
            .toList();
    retreatCost = json["retreatCost"] == null
        ? null
        : List<String>.from(json["retreatCost"]);
    convertedRetreatCost = json["convertedRetreatCost"];
    set = json["set"] == null ? null : Set.fromJson(json["set"]);
    number = json["number"] ?? "-";
    artist = json["artist"] ?? "-";
    rarity = json["rarity"] ?? "-";
    flavorText = json["flavorText"] ?? "";
    nationalPokedexNumbers = json["nationalPokedexNumbers"] == null
        ? null
        : List<int>.from(json["nationalPokedexNumbers"]);
    legalities = json["legalities"] == null
        ? null
        : Legalities1.fromJson(json["legalities"]);
    images = json["images"] == null ? null : Images1.fromJson(json["images"]);
    tcgplayer = json["tcgplayer"] == null
        ? null
        : Tcgplayer.fromJson(json["tcgplayer"]);
    cardmarket = json["cardmarket"] == null
        ? null
        : Cardmarket.fromJson(json["cardmarket"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["name"] = name;
    data["supertype"] = supertype;
    if (subtypes != null) {
      data["subtypes"] = subtypes;
    }
    data["hp"] = hp;
    if (types != null) {
      data["types"] = types;
    }
    data["evolvesFrom"] = evolvesFrom;
    if (attacks != null) {
      data["attacks"] = attacks?.map((e) => e.toJson()).toList();
    }
    if (weaknesses != null) {
      data["weaknesses"] = weaknesses?.map((e) => e.toJson()).toList();
    }
    if (resistances != null) {
      data["resistances"] = resistances?.map((e) => e.toJson()).toList();
    }
    if (retreatCost != null) {
      data["retreatCost"] = retreatCost;
    }
    data["convertedRetreatCost"] = convertedRetreatCost;
    if (set != null) {
      data["set"] = set?.toJson();
    }
    data["number"] = number;
    data["artist"] = artist;
    data["rarity"] = rarity;
    data["flavorText"] = flavorText;
    if (nationalPokedexNumbers != null) {
      data["nationalPokedexNumbers"] = nationalPokedexNumbers;
    }
    if (legalities != null) {
      data["legalities"] = legalities?.toJson();
    }
    if (images != null) {
      data["images"] = images?.toJson();
    }
    if (tcgplayer != null) {
      data["tcgplayer"] = tcgplayer?.toJson();
    }
    if (cardmarket != null) {
      data["cardmarket"] = cardmarket?.toJson();
    }
    return data;
  }

  PokemonModel copyWith({
    String? id,
    String? name,
    String? supertype,
    List<String>? subtypes,
    String? hp,
    List<String>? types,
    String? evolvesFrom,
    List<Attacks>? attacks,
    List<Weaknesses>? weaknesses,
    List<Resistances>? resistances,
    List<String>? retreatCost,
    int? convertedRetreatCost,
    Set? set,
    String? number,
    String? artist,
    String? rarity,
    String? flavorText,
    List<int>? nationalPokedexNumbers,
    Legalities1? legalities,
    Images1? images,
    Tcgplayer? tcgplayer,
    Cardmarket? cardmarket,
  }) =>
      PokemonModel(
        id: id ?? this.id,
        name: name ?? this.name,
        supertype: supertype ?? this.supertype,
        subtypes: subtypes ?? this.subtypes,
        hp: hp ?? this.hp,
        types: types ?? this.types,
        evolvesFrom: evolvesFrom ?? this.evolvesFrom,
        attacks: attacks ?? this.attacks,
        weaknesses: weaknesses ?? this.weaknesses,
        resistances: resistances ?? this.resistances,
        retreatCost: retreatCost ?? this.retreatCost,
        convertedRetreatCost: convertedRetreatCost ?? this.convertedRetreatCost,
        set: set ?? this.set,
        number: number ?? this.number,
        artist: artist ?? this.artist,
        rarity: rarity ?? this.rarity,
        flavorText: flavorText ?? this.flavorText,
        nationalPokedexNumbers:
            nationalPokedexNumbers ?? this.nationalPokedexNumbers,
        legalities: legalities ?? this.legalities,
        images: images ?? this.images,
        tcgplayer: tcgplayer ?? this.tcgplayer,
        cardmarket: cardmarket ?? this.cardmarket,
      );
}

class Cardmarket {
  String? url;
  String? updatedAt;
  Prices1? prices;

  Cardmarket({this.url, this.updatedAt, this.prices});

  Cardmarket.fromJson(Map<String, dynamic> json) {
    url = json["url"] ?? "";
    updatedAt = json["updatedAt"];
    prices = json["prices"] == null ? null : Prices1.fromJson(json["prices"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["url"] = url;
    data["updatedAt"] = updatedAt;
    if (prices != null) {
      data["prices"] = prices?.toJson();
    }
    return data;
  }

  Cardmarket copyWith({
    String? url,
    String? updatedAt,
    Prices1? prices,
  }) =>
      Cardmarket(
        url: url ?? this.url,
        updatedAt: updatedAt ?? this.updatedAt,
        prices: prices ?? this.prices,
      );
}

class Prices1 {
  double? averageSellPrice;
  double? lowPrice;
  double? trendPrice;
  dynamic germanProLow;
  dynamic suggestedPrice;
  double? reverseHoloSell;
  double? reverseHoloLow;
  double? reverseHoloTrend;
  double? lowPriceExPlus;
  double? avg1;
  double? avg7;
  double? avg30;
  double? reverseHoloAvg1;
  double? reverseHoloAvg7;
  double? reverseHoloAvg30;

  Prices1(
      {this.averageSellPrice,
      this.lowPrice,
      this.trendPrice,
      this.germanProLow,
      this.suggestedPrice,
      this.reverseHoloSell,
      this.reverseHoloLow,
      this.reverseHoloTrend,
      this.lowPriceExPlus,
      this.avg1,
      this.avg7,
      this.avg30,
      this.reverseHoloAvg1,
      this.reverseHoloAvg7,
      this.reverseHoloAvg30});

  Prices1.fromJson(Map<String, dynamic> json) {
    averageSellPrice = json["averageSellPrice"];
    lowPrice = json["lowPrice"];
    trendPrice = json["trendPrice"];
    germanProLow = json["germanProLow"];
    suggestedPrice = json["suggestedPrice"];
    reverseHoloSell = json["reverseHoloSell"];
    reverseHoloLow = json["reverseHoloLow"];
    reverseHoloTrend = json["reverseHoloTrend"];
    lowPriceExPlus = json["lowPriceExPlus"];
    avg1 = json["avg1"];
    avg7 = json["avg7"];
    avg30 = json["avg30"];
    reverseHoloAvg1 = json["reverseHoloAvg1"];
    reverseHoloAvg7 = json["reverseHoloAvg7"];
    reverseHoloAvg30 = json["reverseHoloAvg30"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["averageSellPrice"] = averageSellPrice;
    data["lowPrice"] = lowPrice;
    data["trendPrice"] = trendPrice;
    data["germanProLow"] = germanProLow;
    data["suggestedPrice"] = suggestedPrice;
    data["reverseHoloSell"] = reverseHoloSell;
    data["reverseHoloLow"] = reverseHoloLow;
    data["reverseHoloTrend"] = reverseHoloTrend;
    data["lowPriceExPlus"] = lowPriceExPlus;
    data["avg1"] = avg1;
    data["avg7"] = avg7;
    data["avg30"] = avg30;
    data["reverseHoloAvg1"] = reverseHoloAvg1;
    data["reverseHoloAvg7"] = reverseHoloAvg7;
    data["reverseHoloAvg30"] = reverseHoloAvg30;
    return data;
  }

  Prices1 copyWith({
    double? averageSellPrice,
    double? lowPrice,
    double? trendPrice,
    dynamic germanProLow,
    dynamic suggestedPrice,
    double? reverseHoloSell,
    double? reverseHoloLow,
    double? reverseHoloTrend,
    double? lowPriceExPlus,
    double? avg1,
    double? avg7,
    double? avg30,
    double? reverseHoloAvg1,
    double? reverseHoloAvg7,
    double? reverseHoloAvg30,
  }) =>
      Prices1(
        averageSellPrice: averageSellPrice ?? this.averageSellPrice,
        lowPrice: lowPrice ?? this.lowPrice,
        trendPrice: trendPrice ?? this.trendPrice,
        germanProLow: germanProLow ?? this.germanProLow,
        suggestedPrice: suggestedPrice ?? this.suggestedPrice,
        reverseHoloSell: reverseHoloSell ?? this.reverseHoloSell,
        reverseHoloLow: reverseHoloLow ?? this.reverseHoloLow,
        reverseHoloTrend: reverseHoloTrend ?? this.reverseHoloTrend,
        lowPriceExPlus: lowPriceExPlus ?? this.lowPriceExPlus,
        avg1: avg1 ?? this.avg1,
        avg7: avg7 ?? this.avg7,
        avg30: avg30 ?? this.avg30,
        reverseHoloAvg1: reverseHoloAvg1 ?? this.reverseHoloAvg1,
        reverseHoloAvg7: reverseHoloAvg7 ?? this.reverseHoloAvg7,
        reverseHoloAvg30: reverseHoloAvg30 ?? this.reverseHoloAvg30,
      );
}

class Tcgplayer {
  String? url;
  String? updatedAt;
  Prices? prices;

  Tcgplayer({this.url, this.updatedAt, this.prices});

  Tcgplayer.fromJson(Map<String, dynamic> json) {
    url = json["url"];
    updatedAt = json["updatedAt"];
    prices = json["prices"] == null ? null : Prices.fromJson(json["prices"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["url"] = url;
    data["updatedAt"] = updatedAt;
    if (prices != null) {
      data["prices"] = prices?.toJson();
    }
    return data;
  }

  Tcgplayer copyWith({
    String? url,
    String? updatedAt,
    Prices? prices,
  }) =>
      Tcgplayer(
        url: url ?? this.url,
        updatedAt: updatedAt ?? this.updatedAt,
        prices: prices ?? this.prices,
      );
}

class Prices {
  Holofoil? holofoil;
  Holofoil? reverseHolofoil;

  Prices({this.holofoil, this.reverseHolofoil});

  Prices.fromJson(Map<String, dynamic> json) {
    holofoil =
        json["holofoil"] == null ? null : Holofoil.fromJson(json["holofoil"]);
    reverseHolofoil = json["reverseHolofoil"] == null
        ? null
        : Holofoil.fromJson(json["reverseHolofoil"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (holofoil != null) {
      data["holofoil"] = holofoil?.toJson();
    }
    if (reverseHolofoil != null) {
      data["reverseHolofoil"] = reverseHolofoil?.toJson();
    }
    return data;
  }

  Prices copyWith({
    Holofoil? holofoil,
    Holofoil? reverseHolofoil,
  }) =>
      Prices(
        holofoil: holofoil ?? this.holofoil,
        reverseHolofoil: reverseHolofoil ?? this.reverseHolofoil,
      );
}

class Holofoil {
  double? low;
  dynamic mid;
  double? high;
  double? market;
  dynamic directLow;

  Holofoil({this.low, this.mid, this.high, this.market, this.directLow});

  Holofoil.fromJson(Map<String, dynamic> json) {
    low = json["low"];
    mid = json["mid"];
    high = json["high"];
    market = json["market"];
    directLow = json["directLow"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["low"] = low;
    data["mid"] = mid;
    data["high"] = high;
    data["market"] = market;
    data["directLow"] = directLow;
    return data;
  }

  Holofoil copyWith({
    double? low,
    dynamic mid,
    double? high,
    double? market,
    dynamic directLow,
  }) =>
      Holofoil(
        low: low ?? this.low,
        mid: mid ?? this.mid,
        high: high ?? this.high,
        market: market ?? this.market,
        directLow: directLow ?? this.directLow,
      );
}

class Images1 {
  String? small;
  String? large;

  Images1({this.small, this.large});

  Images1.fromJson(Map<String, dynamic> json) {
    small = json["small"];
    large = json["large"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["small"] = small;
    data["large"] = large;
    return data;
  }

  Images1 copyWith({
    String? small,
    String? large,
  }) =>
      Images1(
        small: small ?? this.small,
        large: large ?? this.large,
      );
}

class Legalities1 {
  String? unlimited;

  Legalities1({this.unlimited});

  Legalities1.fromJson(Map<String, dynamic> json) {
    unlimited = json["unlimited"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["unlimited"] = unlimited;
    return data;
  }

  Legalities1 copyWith({
    String? unlimited,
  }) =>
      Legalities1(
        unlimited: unlimited ?? this.unlimited,
      );
}

class Set {
  String? id;
  String? name;
  String? series;
  int? printedTotal;
  int? total;
  Legalities? legalities;
  String? ptcgoCode;
  String? releaseDate;
  String? updatedAt;
  Images? images;

  Set(
      {this.id,
      this.name,
      this.series,
      this.printedTotal,
      this.total,
      this.legalities,
      this.ptcgoCode,
      this.releaseDate,
      this.updatedAt,
      this.images});

  Set.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    series = json["series"];
    printedTotal = json["printedTotal"];
    total = json["total"];
    legalities = json["legalities"] == null
        ? null
        : Legalities.fromJson(json["legalities"]);
    ptcgoCode = json["ptcgoCode"];
    releaseDate = json["releaseDate"];
    updatedAt = json["updatedAt"];
    images = json["images"] == null ? null : Images.fromJson(json["images"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["name"] = name;
    data["series"] = series;
    data["printedTotal"] = printedTotal;
    data["total"] = total;
    if (legalities != null) {
      data["legalities"] = legalities?.toJson();
    }
    data["ptcgoCode"] = ptcgoCode;
    data["releaseDate"] = releaseDate;
    data["updatedAt"] = updatedAt;
    if (images != null) {
      data["images"] = images?.toJson();
    }
    return data;
  }

  Set copyWith({
    String? id,
    String? name,
    String? series,
    int? printedTotal,
    int? total,
    Legalities? legalities,
    String? ptcgoCode,
    String? releaseDate,
    String? updatedAt,
    Images? images,
  }) =>
      Set(
        id: id ?? this.id,
        name: name ?? this.name,
        series: series ?? this.series,
        printedTotal: printedTotal ?? this.printedTotal,
        total: total ?? this.total,
        legalities: legalities ?? this.legalities,
        ptcgoCode: ptcgoCode ?? this.ptcgoCode,
        releaseDate: releaseDate ?? this.releaseDate,
        updatedAt: updatedAt ?? this.updatedAt,
        images: images ?? this.images,
      );
}

class Images {
  String? symbol;
  String? logo;

  Images({this.symbol, this.logo});

  Images.fromJson(Map<String, dynamic> json) {
    symbol = json["symbol"];
    logo = json["logo"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["symbol"] = symbol;
    data["logo"] = logo;
    return data;
  }

  Images copyWith({
    String? symbol,
    String? logo,
  }) =>
      Images(
        symbol: symbol ?? this.symbol,
        logo: logo ?? this.logo,
      );
}

class Legalities {
  String? unlimited;

  Legalities({this.unlimited});

  Legalities.fromJson(Map<String, dynamic> json) {
    unlimited = json["unlimited"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["unlimited"] = unlimited;
    return data;
  }

  Legalities copyWith({
    String? unlimited,
  }) =>
      Legalities(
        unlimited: unlimited ?? this.unlimited,
      );
}

class Resistances {
  String? type;
  String? value;

  Resistances({this.type, this.value});

  Resistances.fromJson(Map<String, dynamic> json) {
    type = json["type"];
    value = json["value"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["type"] = type;
    data["value"] = value;
    return data;
  }

  Resistances copyWith({
    String? type,
    String? value,
  }) =>
      Resistances(
        type: type ?? this.type,
        value: value ?? this.value,
      );
}

class Weaknesses {
  String? type;
  String? value;

  Weaknesses({this.type, this.value});

  Weaknesses.fromJson(Map<String, dynamic> json) {
    type = json["type"];
    value = json["value"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["type"] = type;
    data["value"] = value;
    return data;
  }

  Weaknesses copyWith({
    String? type,
    String? value,
  }) =>
      Weaknesses(
        type: type ?? this.type,
        value: value ?? this.value,
      );
}

class Attacks {
  String? name;
  List<String>? cost;
  int? convertedEnergyCost;
  String? damage;
  String? text;

  Attacks(
      {this.name, this.cost, this.convertedEnergyCost, this.damage, this.text});

  Attacks.fromJson(Map<String, dynamic> json) {
    name = json["name"];
    cost = json["cost"] == null ? null : List<String>.from(json["cost"]);
    convertedEnergyCost = json["convertedEnergyCost"];
    damage = json["damage"];
    text = json["text"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["name"] = name;
    if (cost != null) {
      data["cost"] = cost;
    }
    data["convertedEnergyCost"] = convertedEnergyCost;
    data["damage"] = damage;
    data["text"] = text;
    return data;
  }

  Attacks copyWith({
    String? name,
    List<String>? cost,
    int? convertedEnergyCost,
    String? damage,
    String? text,
  }) =>
      Attacks(
        name: name ?? this.name,
        cost: cost ?? this.cost,
        convertedEnergyCost: convertedEnergyCost ?? this.convertedEnergyCost,
        damage: damage ?? this.damage,
        text: text ?? this.text,
      );
}
