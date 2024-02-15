class LocationResponse {
  List<Location> locations;

  LocationResponse({required this.locations});

  factory LocationResponse.fromJson(Map<String, dynamic> json) {
    var locationList = json['locations'] as List;
    List<Location> locations =
        locationList.map((i) => Location.fromJson(i)).toList();

    return LocationResponse(locations: locations);
  }
}

class Location {
  LocationData locationData;
  double distanceMeters;

  Location({required this.locationData, required this.distanceMeters});

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      locationData: LocationData.fromJson(json['location']),
      distanceMeters: json['distance_meters'].toDouble(),
    );
  }
}

class LocationData {
  String uid;
  String address;
  bool chargingWhenClosed;
  String city;
  Coordinates coordinates;
  String country;
  String countryCode;
  List<String> directions;
  List<Evse> evses;
  List<String> facilities;
  List<String> images;
  String lastUpdated;
  String name;
  OpeningTimes openingTimes;
  Operator operator;
  String owner;
  String parkingType;
  String postalCode;
  List<String> relatedLocations;
  String state;
  String suboperator;
  String timeZone;
  bool publish;
  String entityCode;

  LocationData({
    required this.uid,
    required this.address,
    required this.chargingWhenClosed,
    required this.city,
    required this.coordinates,
    required this.country,
    required this.countryCode,
    required this.directions,
    required this.evses,
    required this.facilities,
    required this.images,
    required this.lastUpdated,
    required this.name,
    required this.openingTimes,
    required this.operator,
    required this.owner,
    required this.parkingType,
    required this.postalCode,
    required this.relatedLocations,
    required this.state,
    required this.suboperator,
    required this.timeZone,
    required this.publish,
    required this.entityCode,
  });

  factory LocationData.fromJson(Map<String, dynamic> json) {
    var evseList = json['evses'] as List;
    List<Evse> evses = evseList.map((i) => Evse.fromJson(i)).toList();

    return LocationData(
      uid: json['uid'],
      address: json['address'],
      chargingWhenClosed: json['charging_when_closed'],
      city: json['city'],
      coordinates: Coordinates.fromJson(json['coordinates']),
      country: json['country'],
      countryCode: json['country_code'],
      directions: json['directions'].cast<String>(),
      evses: evses,
      facilities: json['facilities'].cast<String>(),
      images: json['images'].cast<String>(),
      lastUpdated: json['last_updated'],
      name: json['name'],
      openingTimes: OpeningTimes.fromJson(json['opening_times']),
      operator: Operator.fromJson(json['operator']),
      owner: json['owner'],
      parkingType: json['parking_type'],
      postalCode: json['postal_code'],
      relatedLocations: json['related_locations'].cast<String>(),
      state: json['state'],
      suboperator: json['suboperator'],
      timeZone: json['time_zone'],
      publish: json['publish'],
      entityCode: json['entity_code'],
    );
  }
}

class Coordinates {
  String latitude;
  String longitude;

  Coordinates({required this.latitude, required this.longitude});

  factory Coordinates.fromJson(Map<String, dynamic> json) {
    return Coordinates(
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }
}

class Evse {
  List<String> capabilities;
  List<Connector> connectors;
  dynamic coordinates; // Change the type accordingly if there's a specific type for coordinates
  String directions;
  String evseId;
  String floorLevel;
  List<String> images;
  String lastUpdated;
  dynamic parkingRestrictions; // Change the type accordingly if there's a specific type for parking restrictions
  String physicalReference;
  String uid;
  String protocol;

  Evse({
    required this.capabilities,
    required this.connectors,
    required this.coordinates,
    required this.directions,
    required this.evseId,
    required this.floorLevel,
    required this.images,
    required this.lastUpdated,
    required this.parkingRestrictions,
    required this.physicalReference,
    required this.uid,
    required this.protocol,
  });

  factory Evse.fromJson(Map<String, dynamic> json) {
    var connectorList = json['connectors'] as List;
    List<Connector> connectors =
        connectorList.map((i) => Connector.fromJson(i)).toList();

    return Evse(
      capabilities: json['capabilities'].cast<String>(),
      connectors: connectors,
      coordinates: json['coordinates'], // Change if there's a specific type for coordinates
      directions: json['directions'],
      evseId: json['evse_id'],
      floorLevel: json['floor_level'],
      images: json['images'].cast<String>(),
      lastUpdated: json['last_updated'],
      parkingRestrictions: json['parking_restrictions'], // Change if there's a specific type for parking restrictions
      physicalReference: json['physical_reference'],
      uid: json['uid'],
      protocol: json['protocol'],
    );
  }
}

class Connector {
  String format;
  String uid;
  String connectorId;
  String lastUpdated;
  int maxAmperage;
  int maxElectricPower;
  int maxVoltage;
  String powerType;
  String standard;
  List<String> tariffUids;
  ActiveTariff activeTariff;
  String termsAndConditions;
  String status;

  Connector({
    required this.format,
    required this.uid,
    required this.connectorId,
    required this.lastUpdated,
    required this.maxAmperage,
    required this.maxElectricPower,
    required this.maxVoltage,
    required this.powerType,
    required this.standard,
    required this.tariffUids,
    required this.activeTariff,
    required this.termsAndConditions,
    required this.status,
  });

  factory Connector.fromJson(Map<String, dynamic> json) {
    return Connector(
      format: json['format'],
      uid: json['uid'],
      connectorId: json['connector_id'],
      lastUpdated: json['last_updated'],
      maxAmperage: json['max_amperage'],
      maxElectricPower: json['max_electric_power'],
      maxVoltage: json['max_voltage'],
      powerType: json['power_type'],
      standard: json['standard'],
      tariffUids: json['tariff_uids'].cast<String>(),
      activeTariff: ActiveTariff.fromJson(json['active_tariff']),
      termsAndConditions: json['terms_and_conditions'],
      status: json['status'],
    );
  }
}

class ActiveTariff {
  String currency;
  String uid;
  String type;
  PricePerKwh pricePerKwh;
  PricePerMin pricePerMin;
  dynamic priceFlat;
  dynamic pricePerMinParked;

  ActiveTariff({
    required this.currency,
    required this.uid,
    required this.type,
    required this.pricePerKwh,
    required this.pricePerMin,
    required this.priceFlat,
    required this.pricePerMinParked,
  });

  factory ActiveTariff.fromJson(Map<String, dynamic> json) {
    return ActiveTariff(
      currency: json['currency'],
      uid: json['uid'],
      type: json['type'],
      pricePerKwh: PricePerKwh.fromJson(json['price_per_kwh']),
      pricePerMin: PricePerMin.fromJson(json['price_per_min']),
      priceFlat: json['price_flat'],
      pricePerMinParked: json['price_per_min_parked'],
    );
  }
}

class PricePerKwh {
  double exclVat;
  double inclVat;

  PricePerKwh({required this.exclVat, required this.inclVat});

  factory PricePerKwh.fromJson(Map<String, dynamic> json) {
    return PricePerKwh(
      exclVat: json['excl_vat'].toDouble(),
      inclVat: json['incl_vat'].toDouble(),
    );
  }
}

class PricePerMin {
  double exclVat;
  double inclVat;

  PricePerMin({required this.exclVat, required this.inclVat});

  factory PricePerMin.fromJson(Map<String, dynamic> json) {
    return PricePerMin(
      exclVat: json['excl_vat'].toDouble(),
      inclVat: json['incl_vat'].toDouble(),
    );
  }
}

class OpeningTimes {
  List<dynamic> exceptionalClosings;
  List<dynamic> exceptionalOpenings;
  List<dynamic> regularHours;
  bool twentyfourseven;

  OpeningTimes({
    required this.exceptionalClosings,
    required this.exceptionalOpenings,
    required this.regularHours,
    required this.twentyfourseven,
  });

  factory OpeningTimes.fromJson(Map<String, dynamic> json) {
    return OpeningTimes(
      exceptionalClosings: json['exceptional_closings'],
      exceptionalOpenings: json['exceptional_openings'],
      regularHours: json['regular_hours'],
      twentyfourseven: json['twentyfourseven'],
    );
  }
}

class Operator {
  String name;
  String website;
  String logo;

  Operator({
    required this.name,
    required this.website,
    required this.logo,
  });

  factory Operator.fromJson(Map<String, dynamic> json) {
    return Operator(
      name: json['name'],
      website: json['website'],
      logo: json['logo'],
    );
  }
}
