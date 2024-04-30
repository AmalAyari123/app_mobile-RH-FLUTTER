import 'package:flutter/material.dart';
import 'package:myapp/Model/autorisation.dart';
import 'package:myapp/Model/demande.dart';
import 'package:myapp/Model/departement.dart';
import 'package:myapp/Model/user.dart';

class ProviderUser extends ChangeNotifier {
  List<User>? _employes;
  User? _currentUser;

  List<User>? get employes => _employes;
  User? get currentUser => _currentUser;

  setEmployes(List<User> employes) {
    _employes = employes;
    notifyListeners();
  }

  void setCurrentUser(User user) {
    _currentUser = user; // Set currentUser
    notifyListeners();
  }

  String? _token;

  String? get token => _token;

  settoken(String? token) {
    _token = token;
    notifyListeners();
  }

  List<Demande>? _demandes;

  List<Demande>? get demandes => _demandes;

  setDemande(List<Demande> demandes) {
    _demandes = demandes;
    notifyListeners();
  }

  List<Autorisation>? _autorisations;

  List<Autorisation>? get autorisations => _autorisations;

  setAutorisation(List<Autorisation> autorisations) {
    _autorisations = autorisations;
    notifyListeners();
  }

  List<Demande>? _demandesD;

  List<Demande>? get demandesD => _demandesD;

  setDemandeD(List<Demande> demandesD) {
    _demandesD = demandesD;
    notifyListeners();
  }
}

class ProviderDepartement extends ChangeNotifier {
  List<Departement>? _departements;

  List<Departement>? get departements => _departements;

  setDepartements(List<Departement> departements) {
    _departements = departements;
    notifyListeners();
  }
}
