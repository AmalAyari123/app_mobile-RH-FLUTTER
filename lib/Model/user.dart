import 'package:myapp/Model/demande.dart';
import 'package:myapp/Model/departement.dart';

class User {
  int? id;
  String? name;
  String? email;
  int? numTel;
  int? numCIN;
  String? companyGroup;
  double? soldeConge;
  double? solde1;
  String? profilePic;
  Departement? departement;
  String? userrole;
  int? DepartmentId;
  List<Demande>? demandes;

  User(
      {this.id,
      this.name,
      this.email,
      this.numTel,
      this.numCIN,
      this.companyGroup,
      this.soldeConge,
      this.solde1,
      this.profilePic,
      this.departement,
      this.userrole,
      this.DepartmentId,
      this.demandes});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    numTel = json['NumTel'];
    numCIN = json['NumCIN'];
    companyGroup = json['CompanyGroup'];
    soldeConge = json['SoldeConge']?.toDouble();
    solde1 = json['Solde1']?.toDouble();
    profilePic = json['profilePic'];
    departement = json['departement'] != null
        ? Departement.fromJson(json['departement'])
        : null;
    userrole = json['userrole'];
    DepartmentId =
        json['departement'] != null ? json['departement']['id'] : null;
    /* departmentId = json['departmentId']; */
    if (json['demandes'] != null) {
      List<Demande> demandes = [];
      json['demandes'].forEach((v) {
        demandes.add(Demande.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['NumTel'] = numTel;
    data['NumCIN'] = numCIN;
    data['CompanyGroup'] = companyGroup;
    data['SoldeConge'] = soldeConge;
    data['Solde1'] = solde1;
    data['profilePic'] = profilePic;
    if (departement != null) {
      data['departement'] = departement!.toJson();
      // Convert Departement object to JSON
    }
    data['userrole'] = userrole;
    if (DepartmentId != null) {
      data['DepartmentId'] = DepartmentId; // Convert Departement object to JSON
    }
    return data;
  }
}
