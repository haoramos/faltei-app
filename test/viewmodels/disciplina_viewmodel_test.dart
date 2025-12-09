import 'package:faltei/models/disciplina.dart';
import 'package:faltei/services/database_service.dart';
import 'package:faltei/viewmodels/disciplina_viewmodel.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  setUpAll(() {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  });

  setUp(() async {
    final db = await DatabaseService().database;
    await db.delete('disciplinas');
  });

  test('Initial state is correct', () {
    final viewModel = DisciplinaViewModel();
    expect(viewModel.disciplinas, isEmpty);
    expect(viewModel.isLoading, false);
    expect(viewModel.error, null);
  });

  test('Add and Load Disciplina', () async {
    final viewModel = DisciplinaViewModel();
    final disciplina = Disciplina(
      nome: 'Física',
      totalAulas: 80,
      limiteFaltas: 20,
      cor: '#FFFF00',
    );

    await viewModel.addDisciplina(disciplina);

    expect(viewModel.disciplinas.length, 1);
    expect(viewModel.disciplinas.first.nome, 'Física');
    expect(viewModel.error, null);
  });

  test('Update Disciplina', () async {
    final viewModel = DisciplinaViewModel();
    final disciplina = Disciplina(
      nome: 'Química',
      totalAulas: 50,
      limiteFaltas: 12,
      cor: '#00FFFF',
    );
    await viewModel.addDisciplina(disciplina);
    final createdDisciplina = viewModel.disciplinas.first;

    final updatedDisciplina = Disciplina(
      id: createdDisciplina.id,
      nome: 'Química Orgânica',
      totalAulas: 50,
      limiteFaltas: 12,
      cor: '#00FFFF',
    );

    await viewModel.updateDisciplina(updatedDisciplina);

    expect(viewModel.disciplinas.first.nome, 'Química Orgânica');
  });

  test('Delete Disciplina', () async {
    final viewModel = DisciplinaViewModel();
    final disciplina = Disciplina(
      nome: 'Biologia',
      totalAulas: 40,
      limiteFaltas: 10,
      cor: '#00FF00',
    );
    await viewModel.addDisciplina(disciplina);
    final id = viewModel.disciplinas.first.id!;

    await viewModel.deleteDisciplina(id);

    expect(viewModel.disciplinas, isEmpty);
  });
}
