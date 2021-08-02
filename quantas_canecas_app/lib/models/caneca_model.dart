class CanecaModel {
  int id;
  int quantidade;

  CanecaModel({required this.id, required this.quantidade});

  factory CanecaModel.fromJson(Map<String, dynamic> json) {
    return CanecaModel(id: json["id"], quantidade: json["quantidade"]);
  }
}
