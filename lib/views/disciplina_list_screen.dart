import 'package:faltei/viewmodels/disciplina_viewmodel.dart';
import 'package:faltei/views/disciplina_registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DisciplinaListScreen extends StatefulWidget {
  const DisciplinaListScreen({super.key});

  @override
  State<DisciplinaListScreen> createState() => _DisciplinaListScreenState();
}

class _DisciplinaListScreenState extends State<DisciplinaListScreen> {
  @override
  void initState() {
    super.initState();
    // Load disciplines when screen initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<DisciplinaViewModel>().loadDisciplinas();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DisciplinaViewModel>(
      builder: (context, viewModel, child) {
        if (viewModel.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (viewModel.error != null) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Erro ao carregar disciplinas',
                  style: TextStyle(color: Colors.red[700], fontSize: 16),
                ),
                const SizedBox(height: 8),
                Text(viewModel.error!, style: const TextStyle(fontSize: 12)),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => viewModel.loadDisciplinas(),
                  child: const Text('Tentar Novamente'),
                ),
              ],
            ),
          );
        }

        if (viewModel.disciplinas.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.school_outlined, size: 64, color: Colors.grey[400]),
                const SizedBox(height: 16),
                Text(
                  'Nenhuma disciplina cadastrada',
                  style: TextStyle(color: Colors.grey[600], fontSize: 16),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: viewModel.disciplinas.length,
          itemBuilder: (context, index) {
            final disciplina = viewModel.disciplinas[index];
            final color = Color(
              int.parse(disciplina.cor.replaceAll('#', '0xFF')),
            );

            return Card(
              elevation: 0,
              margin: const EdgeInsets.only(bottom: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(color: Colors.grey[200]!),
              ),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          DisciplinaRegistrationScreen(disciplina: disciplina),
                    ),
                  );
                },
                borderRadius: BorderRadius.circular(12),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: color,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              disciplina.nome,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${disciplina.totalAulas} aulas • Limite: ${disciplina.limiteFaltas} faltas',
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(Icons.chevron_right, color: Colors.grey[400]),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
