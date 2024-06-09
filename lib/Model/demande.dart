enum DemandeStatus { accepte, enAttente, rejete }

class Demande {
  DateTime? dateDebut;
  DateTime? dateFin;
  String? type;
  String? commentaire;
  int? justificatifId;
  String? status;
  int? id;
  int? userId;
  double? count;
  String? repCommentaire;

  Demande(
      {this.dateDebut,
      this.dateFin,
      this.type,
      this.commentaire,
      this.justificatifId,
      this.status,
      this.id,
      this.userId,
      this.count,
      this.repCommentaire});

  Demande.fromJson(Map<String, dynamic> json) {
    dateDebut =
        json['date_debut'] != null ? DateTime.parse(json['date_debut']) : null;
    dateFin =
        json['date_fin'] != null ? DateTime.parse(json['date_fin']) : null;
    type = json['type'];
    commentaire = json['commentaire'];
    justificatifId = json['justificatifId'];
    status = json['status'];
    id = json['id'];
    userId = json['userId'];
    count = json['count'] != null ? json['count'].toDouble() : 0.0;
    repCommentaire = json['repCommentaire'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date_debut'] =
        dateDebut != null ? dateDebut!.toIso8601String() : null;
    data['date_fin'] =
        this.dateFin != null ? this.dateFin!.toIso8601String() : null;
    data['type'] = this.type;
    data['commentaire'] = this.commentaire;
    data['justificatifId'] = this.justificatifId;
    data['status'] = this.status;
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['count'] = this.count;
    data['repCommentaire'] = repCommentaire;

    return data;
  }
}
