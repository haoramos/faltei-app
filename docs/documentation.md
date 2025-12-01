# 📚 Documentação do Projeto: Notifaltas - Controle de Faltas Universitárias

## Visão Geral do Aplicativo

O **Notifaltas** é um aplicativo mobile focado em ajudar estudantes universitários a monitorar e gerenciar suas faltas por disciplina, enviando notificações agendadas para garantir o registro preciso da frequência.

---

## 🎓 1. Histórias de Usuário (User Stories)

| ID | História de Usuário | Foco |
| :--- | :--- | :--- |
| **HU-001** | Como um **estudante**, eu quero **cadastrar uma nova disciplina**, para que eu possa acompanhar minhas faltas nela. | Configuração |
| **HU-002** | Como um **estudante**, eu quero **definir o número total de aulas e o limite de faltas** de cada disciplina, para que o aplicativo possa calcular minha situação. | Configuração |
| **HU-003** | Como um **estudante**, eu quero **cadastrar o horário de início e término** das minhas aulas, para que o aplicativo saiba quando enviar as notificações. | Configuração |
| **HU-004** | Como um **estudante**, eu quero **receber uma notificação na hora de término de cada aula**, perguntando se eu estava presente ou ausente, para registrar a frequência rapidamente. | Notificação |
| **HU-005** | Como um **estudante**, eu quero **adicionar ou remover uma falta manualmente** em qualquer disciplina, caso eu esqueça de responder a notificação ou cometa um erro de registro. | Gestão Manual |
| **HU-006** | Como um **estudante**, eu quero **visualizar o número atual de faltas** e a **porcentagem de frequência** de cada disciplina, para saber se estou perto do limite. | Visualização |
| **HU-007** | Como um **estudante**, eu quero **ver um alerta visual (ex: vermelho)** quando minhas faltas ultrapassarem o limite permitido (ou estiverem muito próximas dele), para tomar uma atitude. | Alerta |

---

## ⚙️ 2. Requisitos Funcionais (RF)

| ID | Requisito Funcional |
| :--- | :--- |
| **RF-001** | O sistema deve permitir o cadastro, edição e exclusão de disciplinas. |
| **RF-002** | O sistema deve permitir o registro de, no mínimo, um horário semanal para cada disciplina. |
| **RF-003** | O sistema deve armazenar o total de aulas e o limite máximo de faltas de cada disciplina. |
| **RF-004** | O sistema deve emitir uma **notificação local persistente** no horário de término de cada aula agendada. |
| **RF-005** | A notificação deve oferecer **opções interativas** ("Presente" / "Faltei") para registro imediato. |
| **RF-006** | O sistema deve calcular e exibir a **porcentagem de frequência** e o número de faltas restantes. |
| **RF-007** | O sistema deve permitir a alteração **manual** do contador de faltas de qualquer disciplina. |
| **RF-008** | O sistema deve exibir uma lista de todas as disciplinas com seu **status de frequência** (OK / Alerta / Reprovado por falta). |
| **RF-009** | O sistema deve armazenar todos os dados das disciplinas e registros de falta **localmente** no dispositivo. |

---

## 🛡️ 3. Requisitos Não Funcionais (RNF)

| ID | Requisito Não Funcional | Categoria |
| :--- | :--- | :--- |
| **RNF-001** | O aplicativo deve ter uma interface **limpa e intuitiva**, com fluxos de cadastro claros. | Usabilidade |
| **RNF-002** | O aplicativo deve carregar a lista de disciplinas e seus status em **menos de 1 segundo**. | Desempenho |
| **RNF-003** | O agendamento de notificações deve ser mantido e disparado **mesmo que o aplicativo esteja fechado ou o telefone reiniciado**. | Confiabilidade |
| **RNF-004** | O aplicativo deve ser compatível com as **últimas duas versões** estáveis do Android. | Compatibilidade |
| **RNF-005** | O aplicativo deve ter um tamanho de download **inferior a 20MB**. | Desempenho |

---

## 🛑 4. Restrições e Limitações do Escopo (MVP)

As seguintes funcionalidades estão **fora do escopo inicial** (MVP - Minimum Viable Product) do Notifaltas:

| Restrição | Descrição |
| :--- | :--- |
| **R-001** | **Sem Sincronização em Nuvem:** Os dados serão armazenados apenas localmente no dispositivo. Não haverá sincronização online. |
| **R-002** | **Sem Login/Conta de Usuário:** Não haverá necessidade de login, autenticação ou gerenciamento de contas. |
| **R-003** | **Sem Integração de Terceiros:** Não haverá integração com o calendário nativo do telefone, APIs de faculdades, ou sistemas de ensino (LMS). |
| **R-004** | **Sem Recurso de Backup/Exportação:** Não haverá funcionalidade inicial para exportar ou importar dados de frequência. |
| **R-005** | **Foco Exclusivo em Faltas:** O aplicativo não incluirá funcionalidades para notas, cálculo de média, tarefas ou material de estudo. |