import 'dart:convert';

class OrderModel {
  String id;
  String idSeller;
  String idPd;
  String nameShop;
  String namePd;
  String pricePd;
  String amountPd;
  String sumPd;
  String idBuyer;
  String nameBuyer;
  String addressBuyer;
  String phoneBuyer;
  String dateTime;
  String status;
  OrderModel({
    required this.id,
    required this.idSeller,
    required this.idPd,
    required this.nameShop,
    required this.namePd,
    required this.pricePd,
    required this.amountPd,
    required this.sumPd,
    required this.idBuyer,
    required this.nameBuyer,
    required this.addressBuyer,
    required this.phoneBuyer,
    required this.dateTime,
    required this.status,
  });

  OrderModel copyWith({
    String? id,
    String? idSeller,
    String? idPd,
    String? nameShop,
    String? namePd,
    String? pricePd,
    String? amountPd,
    String? sumPd,
    String? idBuyer,
    String? nameBuyer,
    String? addressBuyer,
    String? phoneBuyer,
    String? dateTime,
    String? status,
  }) {
    return OrderModel(
      id: id ?? this.id,
      idSeller: idSeller ?? this.idSeller,
      idPd: idPd ?? this.idPd,
      nameShop: nameShop ?? this.nameShop,
      namePd: namePd ?? this.namePd,
      pricePd: pricePd ?? this.pricePd,
      amountPd: amountPd ?? this.amountPd,
      sumPd: sumPd ?? this.sumPd,
      idBuyer: idBuyer ?? this.idBuyer,
      nameBuyer: nameBuyer ?? this.nameBuyer,
      addressBuyer: addressBuyer ?? this.addressBuyer,
      phoneBuyer: phoneBuyer ?? this.phoneBuyer,
      dateTime: dateTime ?? this.dateTime,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'idSeller': idSeller,
      'idPd': idPd,
      'nameShop': nameShop,
      'namePd': namePd,
      'pricePd': pricePd,
      'amountPd': amountPd,
      'sumPd': sumPd,
      'idBuyer': idBuyer,
      'nameBuyer': nameBuyer,
      'addressBuyer': addressBuyer,
      'phoneBuyer': phoneBuyer,
      'dateTime': dateTime,
      'status': status,
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      id: map['id'],
      idSeller: map['idSeller'],
      idPd: map['idPd'],
      nameShop: map['nameShop'],
      namePd: map['namePd'],
      pricePd: map['pricePd'],
      amountPd: map['amountPd'],
      sumPd: map['sumPd'],
      idBuyer: map['idBuyer'],
      nameBuyer: map['nameBuyer'],
      addressBuyer: map['addressBuyer'],
      phoneBuyer: map['phoneBuyer'],
      dateTime: map['dateTime'],
      status: map['status'],
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderModel.fromJson(String source) => OrderModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'OrderModel(id: $id, idSeller: $idSeller, idPd: $idPd, nameShop: $nameShop, namePd: $namePd, pricePd: $pricePd, amountPd: $amountPd, sumPd: $sumPd, idBuyer: $idBuyer, nameBuyer: $nameBuyer, addressBuyer: $addressBuyer, phoneBuyer: $phoneBuyer, dateTime: $dateTime, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is OrderModel &&
      other.id == id &&
      other.idSeller == idSeller &&
      other.idPd == idPd &&
      other.nameShop == nameShop &&
      other.namePd == namePd &&
      other.pricePd == pricePd &&
      other.amountPd == amountPd &&
      other.sumPd == sumPd &&
      other.idBuyer == idBuyer &&
      other.nameBuyer == nameBuyer &&
      other.addressBuyer == addressBuyer &&
      other.phoneBuyer == phoneBuyer &&
      other.dateTime == dateTime &&
      other.status == status;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      idSeller.hashCode ^
      idPd.hashCode ^
      nameShop.hashCode ^
      namePd.hashCode ^
      pricePd.hashCode ^
      amountPd.hashCode ^
      sumPd.hashCode ^
      idBuyer.hashCode ^
      nameBuyer.hashCode ^
      addressBuyer.hashCode ^
      phoneBuyer.hashCode ^
      dateTime.hashCode ^
      status.hashCode;
  }
}
