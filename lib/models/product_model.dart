import 'dart:convert';

class ProductModel {
  final String id;
  final String idSeller;
  final String nameSeller;
  final String namePd;
  final String pricePd;
  final String detailPd;
  final String imagesPd;
  ProductModel({
    required this.id,
    required this.idSeller,
    required this.nameSeller,
    required this.namePd,
    required this.pricePd,
    required this.detailPd,
    required this.imagesPd,
  });

  ProductModel copyWith({
    String? id,
    String? idSeller,
    String? nameSeller,
    String? namePd,
    String? pricePd,
    String? detailPd,
    String? imagesPd,
  }) {
    return ProductModel(
      id: id ?? this.id,
      idSeller: idSeller ?? this.idSeller,
      nameSeller: nameSeller ?? this.nameSeller,
      namePd: namePd ?? this.namePd,
      pricePd: pricePd ?? this.pricePd,
      detailPd: detailPd ?? this.detailPd,
      imagesPd: imagesPd ?? this.imagesPd,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'idSeller': idSeller,
      'nameSeller': nameSeller,
      'namePd': namePd,
      'pricePd': pricePd,
      'detailPd': detailPd,
      'imagesPd': imagesPd,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'],
      idSeller: map['idSeller'],
      nameSeller: map['nameSeller'],
      namePd: map['namePd'],
      pricePd: map['pricePd'],
      detailPd: map['detailPd'],
      imagesPd: map['imagesPd'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) => ProductModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ProductModel(id: $id, idSeller: $idSeller, nameSeller: $nameSeller, namePd: $namePd, pricePd: $pricePd, detailPd: $detailPd, imagesPd: $imagesPd)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is ProductModel &&
      other.id == id &&
      other.idSeller == idSeller &&
      other.nameSeller == nameSeller &&
      other.namePd == namePd &&
      other.pricePd == pricePd &&
      other.detailPd == detailPd &&
      other.imagesPd == imagesPd;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      idSeller.hashCode ^
      nameSeller.hashCode ^
      namePd.hashCode ^
      pricePd.hashCode ^
      detailPd.hashCode ^
      imagesPd.hashCode;
  }
}
