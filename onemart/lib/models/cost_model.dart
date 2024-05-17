class RajaOngkirResponse {
  RajaOngkir rajaongkir;

  RajaOngkirResponse({required this.rajaongkir});

  factory RajaOngkirResponse.fromJson(Map<String, dynamic> json) {
    return RajaOngkirResponse(rajaongkir: RajaOngkir.fromJson(json['rajaongkir']));
  }
}

class RajaOngkir {
  Query query;
  Status status;
  OriginDetails originDetails;
  DestinationDetails destinationDetails;
  List<ShippingResult> results;

  RajaOngkir({
    required this.query,
    required this.status,
    required this.originDetails,
    required this.destinationDetails,
    required this.results,
  });

  factory RajaOngkir.fromJson(Map<String, dynamic> json) {
    return RajaOngkir(
      query: Query.fromJson(json['query']),
      status: Status.fromJson(json['status']),
      originDetails: OriginDetails.fromJson(json['origin_details']),
      destinationDetails: DestinationDetails.fromJson(json['destination_details']),
      results: List<ShippingResult>.from(json['results'].map((result) => ShippingResult.fromJson(result))),
    );
  }
}

class Query {
  String origin;
  String destination;
  int weight;
  String courier;

  Query({
    required this.origin,
    required this.destination,
    required this.weight,
    required this.courier,
  });

  factory Query.fromJson(Map<String, dynamic> json) {
    return Query(
      origin: json['origin'],
      destination: json['destination'],
      weight: json['weight'],
      courier: json['courier'],
    );
  }
}

class Status {
  int code;
  String description;

  Status({
    required this.code,
    required this.description,
  });

  factory Status.fromJson(Map<String, dynamic> json) {
    return Status(
      code: json['code'],
      description: json['description'],
    );
  }
}

class OriginDetails {
  String cityId;
  String provinceId;
  String province;
  String type;
  String cityName;
  String postalCode;

  OriginDetails({
    required this.cityId,
    required this.provinceId,
    required this.province,
    required this.type,
    required this.cityName,
    required this.postalCode,
  });

  factory OriginDetails.fromJson(Map<String, dynamic> json) {
    return OriginDetails(
      cityId: json['city_id'],
      provinceId: json['province_id'],
      province: json['province'],
      type: json['type'],
      cityName: json['city_name'],
      postalCode: json['postal_code'],
    );
  }
}

class DestinationDetails {
  String cityId;
  String provinceId;
  String province;
  String type;
  String cityName;
  String postalCode;

  DestinationDetails({
    required this.cityId,
    required this.provinceId,
    required this.province,
    required this.type,
    required this.cityName,
    required this.postalCode,
  });

  factory DestinationDetails.fromJson(Map<String, dynamic> json) {
    return DestinationDetails(
      cityId: json['city_id'],
      provinceId: json['province_id'],
      province: json['province'],
      type: json['type'],
      cityName: json['city_name'],
      postalCode: json['postal_code'],
    );
  }
}

class ShippingResult {
  String code;
  String name;
  List<ShippingCost> costs;

  ShippingResult({
    required this.code,
    required this.name,
    required this.costs,
  });

  factory ShippingResult.fromJson(Map<String, dynamic> json) {
    return ShippingResult(
      code: json['code'],
      name: json['name'],
      costs: List<ShippingCost>.from(json['costs'].map((cost) => ShippingCost.fromJson(cost))),
    );
  }
}

class ShippingCost {
  String service;
  String description;
  List<ShippingDetail> cost;

  ShippingCost({
    required this.service,
    required this.description,
    required this.cost,
  });

  factory ShippingCost.fromJson(Map<String, dynamic> json) {
    return ShippingCost(
      service: json['service'],
      description: json['description'],
      cost: List<ShippingDetail>.from(json['cost'].map((detail) => ShippingDetail.fromJson(detail))),
    );
  }
}

class ShippingDetail {
  int value;
  String etd;
  String note;

  ShippingDetail({
    required this.value,
    required this.etd,
    required this.note,
  });

  factory ShippingDetail.fromJson(Map<String, dynamic> json) {
    return ShippingDetail(
      value: json['value'],
      etd: json['etd'],
      note: json['note'],
    );
  }
}
