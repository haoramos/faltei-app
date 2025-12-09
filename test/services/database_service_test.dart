import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:faltei/services/database_service.dart';
import 'package:faltei/models/disciplina.dart';

void main() {
  setUpAll(() {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  });

  setUp(() async {
    final db = await DatabaseService().database;
    await db.delete('disciplinas');
  });

  test('Insert and Get Disciplina', () async {
    final service = DatabaseService();
    final disciplina = Disciplina(
      nome: 'Matemática',
      totalAulas: 60,
      limiteFaltas: 15,
      cor: '#FF0000',
    );

    final id = await service.insertDisciplina(disciplina);
    expect(id, isNonZero);

    final disciplinas = await service.getDisciplinas();
    expect(disciplinas.length, 1);
    expect(disciplinas.first.nome, 'Matemática');
    expect(disciplinas.first.id, id);
  });

  test('Update Disciplina', () async {
    final service = DatabaseService();
    final disciplina = Disciplina(
      nome: 'História',
      totalAulas: 40,
      limiteFaltas: 10,
      cor: '#00FF00',
    );
    final id = await service.insertDisciplina(disciplina);

    final updatedDisciplina = Disciplina(
      id: id,
      nome: 'História Geral',
      totalAulas: 40,
      limiteFaltas: 10,
      cor: '#00FF00',
    );

    await service.updateDisciplina(updatedDisciplina);
    final disciplinas = await service.getDisciplinas();
    expect(disciplinas.first.nome, 'História Geral');
  });

  test('Delete Disciplina', () async {
    final service = DatabaseService();
    final disciplina = Disciplina(
      nome: 'Geografia',
      totalAulas: 30,
      limiteFaltas: 8,
      cor: '#0000FF',
    );
    final id = await service.insertDisciplina(disciplina);

    await service.deleteDisciplina(id);
    final disciplinas = await service.getDisciplinas();
    expect(disciplinas, isEmpty);
  });
}
