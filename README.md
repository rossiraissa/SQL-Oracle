# Scripts de Pacotes PL/SQL para Sistema Acadêmico

Este repositório contém scripts PL/SQL que implementam funcionalidades para gerenciamento de dados em um sistema acadêmico, incluindo operações relacionadas a alunos, disciplinas e professores.

## Pacotes Implementados

### 1. PKG_ALUNO
Pacote responsável pelo gerenciamento de alunos.
- **Procedure `excluir_aluno(p_id_aluno IN NUMBER)`**: Remove um aluno específico e todas as suas matrículas associadas.
- **Cursor `alunos_maiores_18`**: Lista os alunos com mais de 18 anos.
- **Cursor `alunos_por_curso(p_id_curso IN NUMBER)`**: Lista os alunos matriculados em um curso específico.

### 2. PKG_DISCIPLINA
Pacote responsável pelo gerenciamento de disciplinas.
- **Procedure `cadastrar_disciplina(p_nome IN VARCHAR2, p_descricao IN VARCHAR2, p_carga_horaria IN NUMBER)`**: Cadastra uma nova disciplina.
- **Cursor `total_alunos_por_disciplina`**: Retorna o total de alunos por disciplina, considerando apenas disciplinas com mais de 10 alunos.
- **Cursor `media_idade_por_disciplina(p_id_disciplina IN NUMBER)`**: Calcula a média de idade dos alunos matriculados em uma disciplina específica.
- **Procedure `listar_alunos_disciplina(p_id_disciplina IN NUMBER)`**: Lista todos os alunos matriculados em uma disciplina.

### 3. PKG_PROFESSOR
Pacote responsável pelo gerenciamento de professores.
- **Cursor `total_tur
