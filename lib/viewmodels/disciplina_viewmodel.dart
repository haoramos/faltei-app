import 'package:faltei/models/disciplina.dart';
import 'package:faltei/services/database_service.dart';
import 'package:flutter/material.dart';

class DisciplinaViewModel extends ChangeNotifier {
  final DatabaseService _databaseService;

  // Dependency injection for easier testing
  DisciplinaViewModel({DatabaseService? databaseService})
    : _databaseService = databaseService ?? DatabaseService();

  List<Disciplina> _disciplinas = [];
  bool _isLoading = false;
  String? _error;

  List<Disciplina> get disciplinas => _disciplinas;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadDisciplinas() async {
    _setLoading(true);
    try {
      _disciplinas = await _databaseService.getDisciplinas();
      _error = null;
    } catch (e) {
      _error = 'Erro ao carregar disciplinas: $e';
    } finally {
      _setLoading(false);
    }
  }

  Future<void> addDisciplina(Disciplina disciplina) async {
    _setLoading(true);
    try {
      await _databaseService.insertDisciplina(disciplina);
      await loadDisciplinas(); // Reload list
      _error = null;
    } catch (e) {
      _error = 'Erro ao adicionar disciplina: $e';
      _setLoading(false);
    }
  }

  Future<void> updateDisciplina(Disciplina disciplina) async {
    _setLoading(true);
    try {
      await _databaseService.updateDisciplina(disciplina);
      await loadDisciplinas(); // Reload list
      _error = null;
    } catch (e) {
      _error = 'Erro ao atualizar disciplina: $e';
      _setLoading(false);
    }
  }

  Future<void> deleteDisciplina(int id) async {
    _setLoading(true);
    try {
      await _databaseService.deleteDisciplina(id);
      await loadDisciplinas(); // Reload list
      _error = null;
    } catch (e) {
      _error = 'Erro ao deletar disciplina: $e';
      _setLoading(false);
    }
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
