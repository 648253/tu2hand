import 'dart:convert';

class SQLiteModel {
  int? id;
  final String idSeller;
  final String idPd;
  final String name;
  final String price;
  final String amount;
  final String sum;
  SQLiteModel({
    this.id,
    required this.idSeller,
    required this.idPd,
    required this.name,
    required this.price,
    required this.amount,
    required this.sum,
  });



  SQLiteModel copyWith({
    int? id,
    String? idSeller,
    String? idPd,
    String? name,
    String? price,
    String? amount,
    String? sum,
  }) {
    return SQLiteModel(
      id: id ?? this.id,
      idSeller: idSeller ?? this.idSeller,
      idPd: idPd ?? this.idPd,
      name: name ?? this.name,
      price: price ?? this.price,
      amount: amount ?? this.amount,
      sum: sum ?? this.sum,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'idSeller': idSeller,
      'idPd': idPd,
      'name': name,
      'price': price,
      'amount': amount,
      'sum': sum,
    };
  }

  factory SQLiteModel.fromMap(Map<String, dynamic> map) {
    return SQLiteModel(
      id: map['id'],
      idSeller: map['idSeller'],
      idPd: map['idPd'],
      name: map['name'],
      price: map['price'],
      amount: map['amount'],
      sum: map['sum'],
    );
  }

  String toJson() => json.encode(toMap());

  factory SQLiteModel.fromJson(String source) => SQLiteModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'SQLiteModel(id: $id, idSeller: $idSeller, idPd: $idPd, name: $name, price: $price, amount: $amount, sum: $sum)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is SQLiteModel &&
      other.id == id &&
      other.idSeller == idSeller &&
      other.idPd == idPd &&
      other.name == name &&
      other.price == price &&
      other.amount == amount &&
      other.sum == sum;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      idSeller.hashCode ^
      idPd.hashCode ^
      name.hashCode ^
      price.hashCode ^
      amount.hashCode ^
      sum.hashCode;
  }
}