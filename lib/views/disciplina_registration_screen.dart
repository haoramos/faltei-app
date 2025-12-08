import 'package:faltei/models/disciplina.dart';
import 'package:faltei/viewmodels/disciplina_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DisciplinaRegistrationScreen extends StatefulWidget {
  const DisciplinaRegistrationScreen({super.key});

  @override
  State<DisciplinaRegistrationScreen> createState() =>
      _DisciplinaRegistrationScreenState();
}

class _DisciplinaRegistrationScreenState
    extends State<DisciplinaRegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _aulasController = TextEditingController();
  final _faltasController = TextEditingController();

  String _selectedColor = '#607D8B'; // Default BlueGrey

  final List<String> _colors = [
    '#607D8B', // BlueGrey
    '#F44336', // Red
    '#4CAF50', // Green
    '#2196F3', // Blue
    '#FFC107', // Amber
    '#9C27B0', // Purple
    '#795548', // Brown
    '#000000', // Black
  ];

  @override
  void dispose() {
    _nomeController.dispose();
    _aulasController.dispose();
    _faltasController.dispose();
    super.dispose();
  }

  Future<void> _saveDisciplina() async {
    if (_formKey.currentState!.validate()) {
      final disciplina = Disciplina(
        nome: _nomeController.text,
        totalAulas: int.parse(_aulasController.text),
        limiteFaltas: int.parse(_faltasController.text),
        cor: _selectedColor,
      );

      final viewModel = context.read<DisciplinaViewModel>();
      await viewModel.addDisciplina(disciplina);

      if (!mounted) return;

      if (viewModel.error != null) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(viewModel.error!)));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Disciplina cadastrada com sucesso!')),
        );
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nova Disciplina')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _nomeController,
                decoration: const InputDecoration(
                  labelText: 'Nome da Disciplina',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o nome';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _aulasController,
                      decoration: const InputDecoration(
                        labelText: 'Total de Aulas',
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Obrigatório';
                        }
                        if (int.tryParse(value) == null) {
                          return 'Inválido';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      controller: _faltasController,
                      decoration: const InputDecoration(
                        labelText: 'Limite de Faltas',
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Obrigatório';
                        }
                        if (int.tryParse(value) == null) {
                          return 'Inválido';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              const Text(
                'Cor de Identificação',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: _colors.map((colorHex) {
                  final color = Color(
                    int.parse(colorHex.replaceAll('#', '0xFF')),
                  );
                  final isSelected = _selectedColor == colorHex;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedColor = colorHex;
                      });
                    },
                    child: Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: color,
                        shape: BoxShape.circle,
                        border: isSelected
                            ? Border.all(color: Colors.grey[900]!, width: 3)
                            : null,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.1),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: isSelected
                          ? const Icon(Icons.check, color: Colors.white)
                          : null,
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: context.watch<DisciplinaViewModel>().isLoading
                    ? null
                    : _saveDisciplina,
                child: context.watch<DisciplinaViewModel>().isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('Salvar Disciplina'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
