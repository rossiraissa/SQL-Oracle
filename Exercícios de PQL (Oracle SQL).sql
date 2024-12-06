PACKAGE PKG_ALUNO AS 
    -- Procedure de exclusão de aluno 
    PROCEDURE excluir_aluno(p_id_aluno IN NUMBER); 
     
    -- Cursor de listagem de alunos maiores de 18 anos 
    CURSOR alunos_maiores_18 IS 
        SELECT nome, data_nascimento 
        FROM alunos 
        WHERE SYSDATE - data_nascimento > 18 * 365; 
     
--1.Pacote PKG_ALUNO
    

-- Cursor com filtro por curso 
    CURSOR alunos_por_curso(p_id_curso IN NUMBER) IS 
        SELECT nome 
        FROM alunos a 
        JOIN matriculas m ON a.id_aluno = m.id_aluno 
        WHERE m.id_curso = p_id_curso; 
END PKG_ALUNO;

PACKAGE BODY PKG_ALUNO AS 
    -- Procedure de exclusão de aluno 
    PROCEDURE excluir_aluno(p_id_aluno IN NUMBER) IS 
    BEGIN 
        -- Exclui todas as matrículas associadas ao aluno 
        DELETE FROM matriculas WHERE id_aluno = p_id_aluno; 
         
        -- Exclui o aluno 
        DELETE FROM alunos WHERE id_aluno = p_id_aluno; 
    END excluir_aluno; 
     
END PKG_ALUNO;





--2.Pacote PKG_DISCIPLINA
CREATE OR REPLACE PACKAGE PKG_DISCIPLINA AS
    -- Procedure de cadastro de disciplina
    PROCEDURE cadastrar_disciplina(p_nome IN VARCHAR2, p_descricao IN VARCHAR2, p_carga_horaria IN NUMBER);
    
    -- Cursor para total de alunos por disciplina
    CURSOR total_alunos_por_disciplina IS
        SELECT d.nome, COUNT(m.id_aluno) AS total_alunos
        FROM disciplinas d
        LEFT JOIN matriculas m ON d.id_disciplina = m.id_disciplina
        GROUP BY d.id_disciplina, d.nome
        HAVING COUNT(m.id_aluno) > 10;
    
    -- Cursor com média de idade por disciplina
    CURSOR media_idade_por_disciplina(p_id_disciplina IN NUMBER) IS
        SELECT AVG(SYSDATE - a.data_nascimento) / 365 AS media_idade
        FROM alunos a
        JOIN matriculas m ON a.id_aluno = m.id_aluno
        WHERE m.id_disciplina = p_id_disciplina;
    
    -- Procedure para listar alunos de uma disciplina
    PROCEDURE listar_alunos_disciplina(p_id_disciplina IN NUMBER);
END PKG_DISCIPLINA;


CREATE OR REPLACE PACKAGE BODY PKG_DISCIPLINA AS
    -- Procedure de cadastro de disciplina
    PROCEDURE cadastrar_disciplina(p_nome IN VARCHAR2, p_descricao IN VARCHAR2, p_carga_horaria IN NUMBER) IS
    BEGIN
        INSERT INTO disciplinas (nome, descricao, carga_horaria)
        VALUES (p_nome, p_descricao, p_carga_horaria);
    END cadastrar_disciplina;
    
    -- Procedure para listar alunos de uma disciplina
    PROCEDURE listar_alunos_disciplina(p_id_disciplina IN NUMBER) IS
    BEGIN
        FOR aluno IN (SELECT a.nome
                      FROM alunos a
                      JOIN matriculas m ON a.id_aluno = m.id_aluno
                      WHERE m.id_disciplina = p_id_disciplina) LOOP
            DBMS_OUTPUT.PUT_LINE('Aluno: ' || aluno.nome);
        END LOOP;
    END listar_alunos_disciplina;

END PKG_DISCIPLINA;




--3 Pacote PKG_PROFESSOR

CREATE OR REPLACE PACKAGE PKG_PROFESSOR AS
    -- Cursor para total de turmas por professor
    CURSOR total_turmas_por_professor IS
        SELECT p.nome, COUNT(t.id_turma) AS total_turmas
        FROM professores p
        JOIN turmas t ON p.id_professor = t.id_professor
        GROUP BY p.id_professor, p.nome
        HAVING COUNT(t.id_turma) > 1;
    
    -- Function para total de turmas de um professor
    FUNCTION total_turmas(p_id_professor IN NUMBER) RETURN NUMBER;
    
    -- Function para professor de uma disciplina
    FUNCTION professor_disciplina(p_id_disciplina IN NUMBER) RETURN VARCHAR2;
END PKG_PROFESSOR;


CREATE OR REPLACE PACKAGE BODY PKG_PROFESSOR AS
    -- Function para total de turmas de um professor
    FUNCTION total_turmas(p_id_professor IN NUMBER) RETURN NUMBER IS
        v_total NUMBER;
    BEGIN
        SELECT COUNT(t.id_turma)
        INTO v_total
        FROM turmas t
        WHERE t.id_professor = p_id_professor;
        
        RETURN v_total;
    END total_turmas;

    -- Function para professor de uma disciplina
    FUNCTION professor_disciplina(p_id_disciplina IN NUMBER) RETURN VARCHAR2 IS
        v_nome_professor VARCHAR2(100);
    BEGIN
        SELECT p.nome
        INTO v_nome_professor
        FROM professores p
        JOIN turmas t ON p.id_professor = t.id_professor
        WHERE t.id_disciplina = p_id_disciplina;
        
        RETURN v_nome_professor;
    END professor_disciplina;
    
END PKG_PROFESSOR;

