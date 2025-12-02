enum TipoFrequencia { presente, falta }

class Frequencia {
  final int? id;
  final int disciplinaId;
  final DateTime dataRegistro;
  final TipoFrequencia tipo;

  Frequencia({
    this.id,
    required this.disciplinaId,
    required this.dataRegistro,
    required this.tipo,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'disciplinaId': disciplinaId,
      'dataRegistro': dataRegistro.toIso8601String(),
      'tipo': tipo.index,
    };
  }

  factory Frequencia.fromMap(Map<String, dynamic> map) {
    return Frequencia(
      id: map['id'],
      disciplinaId: map['disciplinaId'],
      dataRegistro: DateTime.parse(map['dataRegistro']),
      tipo: TipoFrequencia.values[map['tipo']],
    );
  }
}
