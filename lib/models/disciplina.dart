class Disciplina {
  final int? id;
  final String nome;
  final int totalAulas;
  final int limiteFaltas;
  final String cor;

  Disciplina({
    this.id,
    required this.nome,
    required this.totalAulas,
    required this.limiteFaltas,
    required this.cor,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'totalAulas': totalAulas,
      'limiteFaltas': limiteFaltas,
      'cor': cor,
    };
  }

  factory Disciplina.fromMap(Map<String, dynamic> map) {
    return Disciplina(
      id: map['id'],
      nome: map['nome'],
      totalAulas: map['totalAulas'],
      limiteFaltas: map['limiteFaltas'],
      cor: map['cor'],
    );
  }
}
