import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:mcm/models/user_model.dart';
import 'package:mcm/services/database_services.dart';

class AuthServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create user object based on firebase
  mcmUser? _userFromFirebaseUser(User? user) {
    return user != null ? mcmUser(uid: user.uid) : null;
  }

  //auth change user stream
  Stream<mcmUser?> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  // register with email and password
  Future registerWithEmailAndPassword({
    String? createdDate,
    String? companyName,
    String? governmentRegistered,
    String? companyRegistrationNo,
    String? country,
    String? currency,
    String? companyTelNo,
    int? capitalAmount,
    String? firstName,
    String? lastName,
    String? govIdNumber,
    String? email,
    String? password,
    String? userId,
    bool? isUser,
    bool? isAdmin,
    bool? isSuperAdmin,
    List? accountIds,
    List? debt,
    List? paidDebt,
    List? ownAccounts,
    bool? viewCustomer,
    bool? viewAgent,
    bool? deposits,
    bool? newLoans,
    bool? expenses,
    bool? accounts,
    bool? statistics,
    bool? downloads,
  }) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email!, password: password!);
      User user = result.user!;
      await DatabaseServices(uid: user.uid).updateUserData(
        createdDate: createdDate,
        userId: userId,
        companyName: companyName,
        governmentRegistered: governmentRegistered,
        companyRegistrationNo: companyRegistrationNo,
        country: country,
        currency: currency,
        companyTelNo: companyTelNo,
        capitalAmount: capitalAmount,
        firstName: firstName,
        lastName: lastName,
        govIdNumber: govIdNumber,
        email: email,
        password: password,
        isUser: isUser,
        isAdmin: isAdmin,
        isSuperAdmin: isSuperAdmin,
        accountIds: accountIds,
        debt: debt,
        paidDebt: paidDebt,
        ownAccounts: ownAccounts,
        viewCustomer: viewCustomer,
        viewAgent: viewAgent,
        deposits: deposits,
        newLoans: newLoans,
        expenses: expenses,
        accounts: accounts,
        statistics: statistics,
        downloads: downloads,
      );
      print('uid: ' + user.uid.toString());
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return e;
    }
  }

  //sign in with email and password
  Future signInWithEmailAndPassword({String? email, String? password}) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email!, password: password!);
      User user = result.user!;
      print('uid: ' + user.uid.toString());
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign out
  Future signOut() async {
    try {
      print('Signed out');
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
