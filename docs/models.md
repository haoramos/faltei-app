# 🧱 Modelos de Dados (Entities)

Este arquivo define as classes Dart (Models) utilizadas no aplicativo Notifaltas para persistência e manipulação de dados, seguindo o padrão MVVM.

## Modelos Chave (Camada `lib/models`)

| Modelo (Classe Dart) | Propósito | Exemplo de Propriedades |
| :--- | :--- | :--- |
| **`Disciplina`** | Representa uma matéria cadastrada, sendo a entidade principal do aplicativo. | `id` (int, chave primária), `nome` (String), `totalAulas` (int), `limiteFaltas` (int), `cor` (String/int, para exibição na UI). |
| **`Frequencia`** | Representa um registro de presença ou falta em uma aula específica. | `id` (int, chave primária), `disciplinaId` (int, chave estrangeira), `dataRegistro` (DateTime), `tipo` (Enum/int: PRESENTE/FALTA). |
| **`Horario`** | Representa o agendamento semanal de uma aula, permitindo várias aulas por semana. | `id` (int, chave primária), `disciplinaId` (int, chave estrangeira), `diaSemana` (int, 1=Segunda, etc.), `horaInicio` (TimeOfDay/String), `horaFim` (TimeOfDay/String). |