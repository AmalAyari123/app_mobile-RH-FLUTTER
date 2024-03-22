class User {
  int? id;
  String? name;
  String? email;
  int? numTel;
  int? numCIN;
  String? companyGroup;
  int? soldeConge;
  int? solde1;
  String? profilePic;

  User(
      {this.id,
      this.name,
      this.email,
      this.numTel,
      this.numCIN,
      this.companyGroup,
      this.soldeConge,
      this.solde1,
      this.profilePic});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    numTel = json['NumTel'];
    numCIN = json['NumCIN'];
    companyGroup = json['CompanyGroup'];
    soldeConge = json['SoldeConge'];
    solde1 = json['Solde1'];
    profilePic = json['profilePic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['NumTel'] = this.numTel;
    data['NumCIN'] = this.numCIN;
    data['CompanyGroup'] = this.companyGroup;
    data['SoldeConge'] = this.soldeConge;
    data['Solde1'] = this.solde1;
    data['profilePic'] = this.profilePic;
    return data;
  }
}
