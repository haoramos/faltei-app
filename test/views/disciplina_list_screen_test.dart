import 'package:faltei/models/disciplina.dart';
import 'package:faltei/viewmodels/disciplina_viewmodel.dart';
import 'package:faltei/views/disciplina_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import 'disciplina_list_screen_test.mocks.dart';

@GenerateMocks([DisciplinaViewModel])
void main() {
  late MockDisciplinaViewModel mockViewModel;

  setUp(() {
    mockViewModel = MockDisciplinaViewModel();
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: ChangeNotifierProvider<DisciplinaViewModel>.value(
        value: mockViewModel,
        child: const DisciplinaListScreen(),
      ),
    );
  }

  testWidgets('Shows loading indicator when loading', (WidgetTester tester) async {
    when(mockViewModel.isLoading).thenReturn(true);
    when(mockViewModel.error).thenReturn(null);
    when(mockViewModel.disciplinas).thenReturn([]);
    when(mockViewModel.loadDisciplinas()).thenAnswer((_) async {});

    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('Shows empty message when list is empty', (WidgetTester tester) async {
    when(mockViewModel.isLoading).thenReturn(false);
    when(mockViewModel.error).thenReturn(null);
    when(mockViewModel.disciplinas).thenReturn([]);
    when(mockViewModel.loadDisciplinas()).thenAnswer((_) async {});

    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.text('Nenhuma disciplina cadastrada'), findsOneWidget);
    expect(find.byIcon(Icons.school_outlined), findsOneWidget);
  });

  testWidgets('Shows error message when error occurs', (WidgetTester tester) async {
    when(mockViewModel.isLoading).thenReturn(false);
    when(mockViewModel.error).thenReturn('Erro de conexão');
    when(mockViewModel.disciplinas).thenReturn([]);
    when(mockViewModel.loadDisciplinas()).thenAnswer((_) async {});

    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.text('Erro ao carregar disciplinas'), findsOneWidget);
    expect(find.text('Erro de conexão'), findsOneWidget);
    expect(find.text('Tentar Novamente'), findsOneWidget);
  });

  testWidgets('Shows list of disciplines when data is available', (WidgetTester tester) async {
    final disciplinas = [
      Disciplina(id: 1, nome: 'Matemática', totalAulas: 60, limiteFaltas: 15, cor: '#FF0000'),
      Disciplina(id: 2, nome: 'História', totalAulas: 40, limiteFaltas: 10, cor: '#00FF00'),
    ];

    when(mockViewModel.isLoading).thenReturn(false);
    when(mockViewModel.error).thenReturn(null);
    when(mockViewModel.disciplinas).thenReturn(disciplinas);
    when(mockViewModel.loadDisciplinas()).thenAnswer((_) async {});

    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.byType(ListView), findsOneWidget);
    expect(find.text('Matemática'), findsOneWidget);
    expect(find.text('História'), findsOneWidget);
    expect(find.text('60 aulas • Limite: 15 faltas'), findsOneWidget);
  });
}
