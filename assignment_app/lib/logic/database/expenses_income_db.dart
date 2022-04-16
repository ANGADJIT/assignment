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
}
