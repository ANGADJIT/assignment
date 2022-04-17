import 'package:assignment_app/data/models/expenses_income_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ExpensesIncomeDb {
  final CollectionReference _instance =
      FirebaseFirestore.instance.collection('users');

  /// This add income and expenses into database
  ///
  /// Accepts [ExpensesIncomeModel] as arg
  Future<void> add(ExpensesIncomeModel incomeModel) async {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    await _instance
        .doc(uid)
        .collection('income_expenses')
        .add(incomeModel.toMap());
  }

  /// This get income and expenses from database
  ///
  /// And return as List of [ExpensesIncomeDb]
  Future<List<ExpensesIncomeModel>> getExpenses() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    final result = await _instance.doc(uid).collection('income_expenses').get();
    final expenses = result.docs;

    final List<ExpensesIncomeModel> modeledExpenses = [];

    for (var expense in expenses) {
      final map = expense.data();
      modeledExpenses.add(ExpensesIncomeModel.fromMap(map));
    }

    return modeledExpenses.reversed.toList();
  }
}
