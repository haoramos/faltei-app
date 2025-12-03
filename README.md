# 🔔 Faltei - Gerenciador Inteligente de Faltas Universitárias

## 💡 Sobre o Projeto

O **Faltei** é um aplicativo mobile desenvolvido em **Flutter** com o objetivo de auxiliar estudantes universitários a manterem o controle rigoroso de sua frequência em disciplinas. O foco principal é a **automação do registro de faltas** através de **notificações agendadas**.

O projeto segue a arquitetura **MVVM (Model-View-ViewModel)** utilizando o pacote **Provider** para gerenciamento de estado e **Sqflite/Hive** para persistência local de dados.

## ✨ Funcionalidades (MVP - Produto Mínimo Viável)

O aplicativo **Faltei** é capaz de:

* **Cadastro de Disciplinas:** Permite adicionar o nome da matéria, total de aulas e o limite máximo de faltas.
* **Agendamento de Aulas:** Permite cadastrar o dia e o horário de início/término de cada aula.
* **Notificações Inteligentes:** Envia uma **notificação local persistente** no horário exato do término da aula.
* **Registro Rápido:** Permite registrar Presença ou Falta diretamente na notificação, sem precisar abrir o aplicativo.
* **Controle Visual:** Exibe o número de faltas acumuladas, a porcentagem de frequência e **alertas visuais (cores)** quando o limite de faltas estiver próximo ou for excedido.

---

## 🏗️ Arquitetura e Estrutura

O projeto adota a arquitetura **MVVM** e é organizado para facilitar a escalabilidade e manutenção do código.

## 🛠️ Tecnologias Utilizadas (Stack)

* **Framework:** Flutter (Versão 3.38.3)
* **Linguagem:** Dart (Versão 3.10.1)
* **Arquitetura:** MVVM (Model-View-ViewModel)
* **Gerenciamento de Estado:** `provider`
* **Persistência Local:** Sqflite / Hive (a definir)
* **Notificações:** `flutter_local_notifications`
