import 'dart:convert';

class ExpensesIncomeModel {
  final int expenses;
  final int income;

  ExpensesIncomeModel({
    required this.expenses,
    required this.income,
  });

  Map<String, dynamic> toMap() {
    return {
      'expenses': expenses,
      'income': income,
    };
  }

  factory ExpensesIncomeModel.fromMap(Map<String, dynamic> map) {
    return ExpensesIncomeModel(
      expenses: map['expenses']?.toInt() ?? 0,
      income: map['income']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory ExpensesIncomeModel.fromJson(String source) =>
      ExpensesIncomeModel.fromMap(json.decode(source));
}
