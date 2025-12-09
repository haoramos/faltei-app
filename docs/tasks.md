# 📋 Plano de Sprints - Projeto Faltei (Controle de Faltas)

Este documento contém a lista completa de tarefas (Issues) organizadas por Sprints. As tarefas estão em formato de lista de afazeres para fácil rastreamento na sua IDE e no GitHub.

---

## 📅 Sprint 0: Setup e Arquitetura (Base)

O objetivo é preparar o ambiente e estabelecer a fundação arquitetural MVVM.

### ⚙️ Tarefas de Configuração

- **0.1** Configuração do Ambiente Flutter no Fedora 41 (SDKs e licenças).
- **0.2** Criação do Projeto Flutter e configuração inicial.
- **0.3** Definição da Arquitetura MVVM (Instalação e configuração do pacote `provider`).
- **0.4** Estrutura de Pastas e criação dos modelos de dados (`Disciplina`, `Frequencia`, `Horario`).
- **0.5** Configuração do Banco de Dados Local (Instalação e inicialização do `sqflite`).

---

## 🚀 Sprint 1: Core Data e CRUD de Disciplinas

O foco é o gerenciamento de dados das disciplinas e a interface de cadastro.

### 🎓 Histórias de Usuário Atendidas (HU-001, HU-002)

- **1.1** Implementação dos Modelos (Models) para Disciplina (nome, total aulas, limite faltas).
- **1.2** Criação do ViewModel de Disciplinas (Usando `ChangeNotifier`).
- **1.3** Implementação Completa do CRUD (Create, Read, Update, Delete) no DatabaseService. (RF-009)
- **1.4** Tela de Cadastro/Edição de Disciplina (Formulário inicial). (RF-001)
- **1.5** Tela de Listagem de Disciplinas (Exibição inicial). (RF-008)

---

## ⏳ Sprint 2: Agendamento de Aulas e Gestão Manual

Adição da dimensão tempo e a capacidade de o usuário ajustar os dados manualmente.

### 📚 Histórias de Usuário Atendidas (HU-003, HU-005, HU-006)

- **2.1** Adicionar Lógica de Horário ao Model Disciplina e DatabaseService. (HU-003, RF-002)
- **2.2** Atualização da Tela de Cadastro para incluir os campos de horário (uso de Time Pickers). (RF-002)
- **2.3** Implementação da Lógica de Cálculo no ViewModel (somar faltas e calcular a porcentagem). (HU-006, RF-006)
- **2.4** Tela de Ajuste Manual: Implementação de modal/tela para adicionar/remover faltas manualmente. (HU-005, RF-007)

---

## 🔔 Sprint 3: Notificações e Funcionalidade Core

Implementação do recurso central do aplicativo: o sistema de notificações agendadas.

### 🚨 Histórias de Usuário Atendidas (HU-004)

- **3.1** Configuração do Pacote de Notificações Locais (`flutter_local_notifications`). (RNF-003)
- **3.2** Agendamento de Notificações: Função para agendar a notificação na hora de término de cada aula cadastrada. (RF-004, RNF-003)
- **3.3** Implementação das Ações na Notificação: Configurar a notificação com botões interativos ("Presente" / "Faltei"). (RF-005)
- **3.4** Lógica de Resposta da Notificação: Implementar o código que, ao receber o clique, atualiza o contador de faltas. (RF-007)
- **3.5** Exibição Detalhada da Disciplina: Mostrar faltas atuais, total de aulas e percentual de frequência. (HU-006, RF-006)

---

## ✅ Sprint 4: UX/UI, Alertas e Testes (Finalização do MVP)

Foco em polimento, qualidade visual e preparação para lançamento.

### ✨ Histórias de Usuário Atendidas (HU-007)

- **4.1** Implementação de Alerta de Limite: Aplicar lógica e estilo visual (cores) para indicar status de Alerta/Reprovado por falta. (HU-007, RF-008)
- **4.2** Refinamento da UI/UX de todas as telas (cores, fontes, navegação) para atender ao RNF-001.
- **4.3** Testes Funcionais: Testar todos os fluxos de cadastro, cálculo, agendamento de notificações e respostas. (RF-004, RF-005, RF-006)
- **4.4** Testes de Desempenho e otimização de *build* para garantir RNF-002 e RNF-005.
- **4.5** Geração do APK (Android Package) para teste final em dispositivo real. (RNF-004)