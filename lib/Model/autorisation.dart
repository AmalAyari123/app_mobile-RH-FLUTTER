class Autorisation {
  DateTime? heureDebut;
  DateTime? heureFin;
  DateTime? jour;

  String? status;
  int? id;
  int? userId;

  Autorisation(
      {this.heureDebut,
      this.heureFin,
      this.status,
      this.id,
      this.userId,
      this.jour});

  Autorisation.fromJson(Map<String, dynamic> json) {
    heureDebut = json['heure_debut'] != null
        ? DateTime.parse(json['heure_debut'])
        : null;
    jour = json['jour'] != null ? DateTime.parse(json['jour']) : null;
    heureFin =
        json['heure_fin'] != null ? DateTime.parse(json['heure_fin']) : null;

    status = json['status'];
    id = json['id'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['heure_debut'] =
        this.heureDebut != null ? this.heureDebut!.toIso8601String() : null;
    data['heure_fin'] =
        this.heureFin != null ? this.heureFin!.toIso8601String() : null;
    data['jour'] = this.jour != null ? this.jour!.toIso8601String() : null;

    data['status'] = this.status;
    data['id'] = this.id;
    data['userId'] = this.userId;

    return data;
  }
}
