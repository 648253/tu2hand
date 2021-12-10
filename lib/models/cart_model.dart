import 'dart:convert';

class CartModel {
  String id;
  String idBuyer;
  String idSeller;
  String idPd;
  String nameSeller;
  String namePd;
  String pricePd;
  String amountPd;
  String sumPd;
  String imgPd;
  CartModel({
    required this.id,
    required this.idBuyer,
    required this.idSeller,
    required this.idPd,
    required this.nameSeller,
    required this.namePd,
    required this.pricePd,
    required this.amountPd,
    required this.sumPd,
    required this.imgPd,
  });

  CartModel copyWith({
    String? id,
    String? idBuyer,
    String? idSeller,
    String? idPd,
    String? nameSeller,
    String? namePd,
    String? pricePd,
    String? amountPd,
    String? sumPd,
    String? imgPd,
  }) {
    return CartModel(
      id: id ?? this.id,
      idBuyer: idBuyer ?? this.idBuyer,
      idSeller: idSeller ?? this.idSeller,
      idPd: idPd ?? this.idPd,
      nameSeller: nameSeller ?? this.nameSeller,
      namePd: namePd ?? this.namePd,
      pricePd: pricePd ?? this.pricePd,
      amountPd: amountPd ?? this.amountPd,
      sumPd: sumPd ?? this.sumPd,
      imgPd: imgPd ?? this.imgPd,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'idBuyer': idBuyer,
      'idSeller': idSeller,
      'idPd': idPd,
      'nameSeller': nameSeller,
      'namePd': namePd,
      'pricePd': pricePd,
      'amountPd': amountPd,
      'sumPd': sumPd,
      'imgPd': imgPd,
    };
  }

  factory CartModel.fromMap(Map<String, dynamic> map) {
    return CartModel(
      id: map['id'],
      idBuyer: map['idBuyer'],
      idSeller: map['idSeller'],
      idPd: map['idPd'],
      nameSeller: map['nameSeller'],
      namePd: map['namePd'],
      pricePd: map['pricePd'],
      amountPd: map['amountPd'],
      sumPd: map['sumPd'],
      imgPd: map['imgPd'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CartModel.fromJson(String source) =>
      CartModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CartModel(id: $id, idBuyer: $idBuyer, idSeller: $idSeller, idPd: $idPd, nameSeller: $nameSeller, namePd: $namePd, pricePd: $pricePd, amountPd: $amountPd, sumPd: $sumPd, imgPd: $imgPd)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CartModel &&
        other.id == id &&
        other.idBuyer == idBuyer &&
        other.idSeller == idSeller &&
        other.idPd == idPd &&
        other.nameSeller == nameSeller &&
        other.namePd == namePd &&
        other.pricePd == pricePd &&
        other.amountPd == amountPd &&
        other.sumPd == sumPd &&
        other.imgPd == imgPd;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        idBuyer.hashCode ^
        idSeller.hashCode ^
        idPd.hashCode ^
        nameSeller.hashCode ^
        namePd.hashCode ^
        pricePd.hashCode ^
        amountPd.hashCode ^
        sumPd.hashCode ^
        imgPd.hashCode;
  }
}
