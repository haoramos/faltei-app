import 'package:faltei/models/disciplina.dart';
import 'package:faltei/viewmodels/disciplina_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DisciplinaRegistrationScreen extends StatefulWidget {
  final Disciplina? disciplina;

  const DisciplinaRegistrationScreen({super.key, this.disciplina});

  @override
  State<DisciplinaRegistrationScreen> createState() =>
      _DisciplinaRegistrationScreenState();
}

class _DisciplinaRegistrationScreenState
    extends State<DisciplinaRegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nomeController;
  late TextEditingController _aulasController;
  late TextEditingController _faltasController;

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
  void initState() {
    super.initState();
    _nomeController = TextEditingController(
      text: widget.disciplina?.nome ?? '',
    );
    _aulasController = TextEditingController(
      text: widget.disciplina?.totalAulas.toString() ?? '',
    );
    _faltasController = TextEditingController(
      text: widget.disciplina?.limiteFaltas.toString() ?? '',
    );
    if (widget.disciplina != null) {
      _selectedColor = widget.disciplina!.cor;
    }
  }

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
        id: widget.disciplina?.id,
        nome: _nomeController.text,
        totalAulas: int.parse(_aulasController.text),
        limiteFaltas: int.parse(_faltasController.text),
        cor: _selectedColor,
      );

      final viewModel = context.read<DisciplinaViewModel>();

      if (widget.disciplina == null) {
        await viewModel.addDisciplina(disciplina);
      } else {
        await viewModel.updateDisciplina(disciplina);
      }

      if (!mounted) return;

      if (viewModel.error != null) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(viewModel.error!)));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              widget.disciplina == null
                  ? 'Disciplina cadastrada!'
                  : 'Disciplina atualizada!',
            ),
          ),
        );
        Navigator.pop(context);
      }
    }
  }

  Future<void> _deleteDisciplina() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Excluir Disciplina'),
        content: const Text('Tem certeza? Essa ação não pode ser desfeita.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Excluir', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirmed == true && widget.disciplina?.id != null) {
      if (!mounted) return;
      final viewModel = context.read<DisciplinaViewModel>();
      await viewModel.deleteDisciplina(widget.disciplina!.id!);

      if (!mounted) return;
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.disciplina == null ? 'Nova Disciplina' : 'Editar Disciplina',
        ),
        actions: [
          if (widget.disciplina != null)
            IconButton(
              icon: const Icon(Icons.delete_outline, color: Colors.red),
              onPressed: _deleteDisciplina,
            ),
        ],
      ),
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
                    : Text(
                        widget.disciplina == null
                            ? 'Salvar Disciplina'
                            : 'Atualizar Disciplina',
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
