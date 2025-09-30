
class ClientModel {
  final int id;
  final int clientNumber;
  final String breed;
  final String name;
  final String? tel1;
  final String? tel2;
  final String? tel3;
  final String? email;
  final String ownerName;
  final String firstVisitDate;
  final String created;
  final String updated;
  final List<VisitModel> visits;

  ClientModel({
    required this.id,
    required this.clientNumber,
    required this.breed,
    required this.name,
    this.tel1,
    this.tel2,
    this.tel3,
    this.email,
    required this.ownerName,
    required this.firstVisitDate,
    required this.created,
    required this.updated,
    required this.visits,
  });

  factory ClientModel.fromJson(Map<String, dynamic> json) {
    return ClientModel(
      id: json['id'],
      clientNumber: json['clientNumber'],
      breed: json['breed'],
      name: json['name'],
      tel1: json['tel1'],
      tel2: json['tel2'],
      tel3: json['tel3'],
      email: json['email'],
      ownerName: json['ownerName'],
      firstVisitDate: json['firstVisitDate'],
      created: json['created'],
      updated: json['updated'],
      visits: (json['visits'] as List<dynamic>?)?.map((v) => VisitModel.fromJson(v)).toList() ?? [],
    );
  }
}

class VisitModel {
  final int id;
  final String visitDate;
  final String visitHour;
  final String description;
  final double price;
  final String serviceType;
  final String knife;
  final bool withHair;
  final int duration;
  final String created;
  final String updated;

  VisitModel({
    required this.id,
    required this.visitDate,
    required this.visitHour,
    required this.description,
    required this.price,
    required this.serviceType,
    required this.knife,
    required this.withHair,
    required this.duration,
    required this.created,
    required this.updated,
  });

  factory VisitModel.fromJson(Map<String, dynamic> json) {
    return VisitModel(
      id: json['id'],
      visitDate: json['visitDate'],
      visitHour: json['visitHour'],
      description: json['description'],
      price: (json['price'] as num).toDouble(),
      serviceType: json['serviceType'],
      knife: json['knife'],
      withHair: json['withHair'],
      duration: json['duration'],
      created: json['created'],
      updated: json['updated'],
    );
  }
}

// Mock data for demo
final List<ClientModel> mockClients = [
  ClientModel.fromJson({
    "id": 1,
    "clientNumber": 12345,
    "breed": "Golden Retriever",
    "name": "Burek",
    "tel1": "123-456-789",
    "tel2": "987-654-321",
    "tel3": null,
    "email": "jan.kowalski@example.com",
    "ownerName": "Jan Kowalski",
    "firstVisitDate": "2023-01-15",
    "created": "2023-01-15T10:30:00",
    "updated": "2023-10-26T14:00:00",
    "visits": [
      {
        "id": 101,
        "visitDate": "2023-10-26",
        "visitHour": "14:00",
        "description": "Strzyżenie i kąpiel",
        "price": 150.50,
        "serviceType": "FULL",
        "knife": "L6_5",
        "withHair": true,
        "duration": 90,
        "created": "2023-10-26T14:00:00",
        "updated": "2023-10-26T14:00:00"
      },
      {
        "id": 102,
        "visitDate": "2023-08-20",
        "visitHour": "11:00",
        "description": "Trymowanie",
        "price": 120.00,
        "serviceType": "TRYM",
        "knife": "L3_5",
        "withHair": false,
        "duration": 75,
        "created": "2023-08-20T11:00:00",
        "updated": "2023-08-20T11:00:00"
      }
    ]
  })
];
