class Horario {
  final int? id;
  final int disciplinaId;
  final int diaSemana; // 1 = Segunda, 7 = Domingo
  final String horaInicio; // Format: "HH:mm"
  final String horaFim; // Format: "HH:mm"

  Horario({
    this.id,
    required this.disciplinaId,
    required this.diaSemana,
    required this.horaInicio,
    required this.horaFim,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'disciplinaId': disciplinaId,
      'diaSemana': diaSemana,
      'horaInicio': horaInicio,
      'horaFim': horaFim,
    };
  }

  factory Horario.fromMap(Map<String, dynamic> map) {
    return Horario(
      id: map['id'],
      disciplinaId: map['disciplinaId'],
      diaSemana: map['diaSemana'],
      horaInicio: map['horaInicio'],
      horaFim: map['horaFim'],
    );
  }
}
