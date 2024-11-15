--EXERCÍCIOS DE DQL (ORACLE SQL)


--1. Listar alunos ordenados por nome e data de nascimento
SELECT *
FROM aluno
ORDER BY nome ASC, data_nascimento DESC;

--2. Listar professores e suas especialidades em ordem decrescente
SELECT nome, especialidade
FROM professor
ORDER BY nome DESC;

--3. Listar disciplinas ordenadas por carga horária
SELECT nome, carga_horaria
FROM disciplina
ORDER BY carga_horaria DESC;

--4. Contar o número de alunos em cada status de matrícula
SELECT status, COUNT(id_matricula) AS numero_de_alunos
FROM matricula
GROUP BY status;

--5. Listar cursos com a soma total da carga horária de suas disciplinas
SELECT c.nome AS nome_curso, SUM(d.carga_horaria) AS carga_horaria_total
FROM curso c
JOIN disciplina d ON c.id_curso = d.id_curso
GROUP BY c.nome;

--6. Contar quantos professores estão lecionando mais de 3 turmas
SELECT p.nome
FROM professor p
JOIN turma t ON p.id_professor = t.id_professor
GROUP BY p.nome
HAVING COUNT(t.id_turma) > 3;

--7. Listar os alunos matriculados em mais de uma disciplina
SELECT a.nome
FROM aluno a
JOIN matricula m ON a.id_aluno = m.id_aluno
GROUP BY a.nome
HAVING COUNT(m.id_disciplina) > 1
ORDER BY COUNT(m.id_disciplina) DESC;

--8. Listar cursos com mais de 2000 horas de carga horária
SELECT c.nome AS nome_curso, SUM(d.carga_horaria) AS total_carga_horaria
FROM curso c
JOIN disciplina d ON c.id_curso = d.id_curso
GROUP BY c.id_curso, c.nome
HAVING SUM(d.carga_horaria) > 2000;

--9. Contar o número total de turmas e listar por professor
SELECT p.nome, COUNT(t.id_turma) AS total_turmas
FROM professor p
JOIN turma t ON p.id_professor = t.id_professor
GROUP BY p.nome
ORDER BY total_turmas DESC;

--10. Listar disciplinas e a média da carga horária por curso
SELECT c.nome AS nome_curso, AVG(d.carga_horaria) AS media_carga_horaria
FROM curso c
JOIN disciplina d ON c.id_curso = d.id_curso
GROUP BY c.nome;

--11. Exibir os alunos e seus respectivos status de matrícula, ordenados pelo status e pela data de matrícula
SELECT a.nome AS nome_aluno, m.status, m.data_matricula
FROM aluno a
JOIN matricula m ON a.id_aluno = m.id_aluno
ORDER BY m.status DESC, m.data_matricula DESC;

--12. Exibir a idade dos alunos ordenados da maior para a menor idade
SELECT a.nome, 
       TRUNC(MONTHS_BETWEEN(SYSDATE, a.data_nascimento) / 12) AS idade
FROM aluno a
ORDER BY idade DESC;

--13. Exibir as disciplinas e o número de alunos matriculados em cada uma
SELECT d.nome AS nome_disciplina, COUNT(m.id_aluno) AS numero_de_alunos
FROM disciplina d
LEFT JOIN matricula m ON d.id_disciplina = m.id_disciplina
GROUP BY d.nome
ORDER BY numero_de_alunos DESC;

--14. Listar as turmas com o nome dos professores e disciplinas, ordenadas por horário
SELECT p.nome AS nome_professor, 
       d.nome AS nome_disciplina, 
       t.horario
FROM turma t
JOIN professor p ON t.id_professor = p.id_professor
JOIN disciplina d ON t.id_disciplina = d.id_disciplina
ORDER BY t.horario;

--15. Contar quantas disciplinas têm carga horária superior a 80 horas
SELECT COUNT(*) AS disciplinas_maior_80
FROM disciplina
WHERE carga_horaria > 80;

--16. Listar os cursos e a quantidade de disciplinas que cada curso possui
SELECT c.nome AS nome_curso, COUNT(d.id_disciplina) AS qtd_disciplinas
FROM curso c
LEFT JOIN disciplina d ON c.id_curso = d.id_curso
GROUP BY c.nome;

--17. Exibir os professores que têm mais de 2 disciplinas com carga horária superior a 100 horas
SELECT p.nome AS nome_professor
FROM professor p
JOIN turma t ON p.id_professor = t.id_professor
JOIN disciplina d ON t.id_disciplina = d.id_disciplina
WHERE d.carga_horaria > 100
GROUP BY p.id_professor, p.nome
HAVING COUNT(d.id_disciplina) > 2;

--18. Listar disciplinas que tenham pelo menos 5 alunos matriculados
SELECT d.nome AS nome_disciplina
FROM disciplina d
JOIN matricula m ON d.id_disciplina = m.id_disciplina
GROUP BY d.nome
HAVING COUNT(m.id_aluno) >= 5;

--19. Exibir o número de alunos por status, ordenando pelos status com mais alunos
SELECT m.status, COUNT(m.id_aluno) AS numero_de_alunos
FROM matricula m
GROUP BY m.status
ORDER BY numero_de_alunos DESC;

--20. Listar professores e a soma da carga horária das disciplinas que lecionam
SELECT p.nome AS nome_professor, SUM(d.carga_horaria) AS soma_carga_horaria
FROM professor p
JOIN turma t ON p.id_professor = t.id_professor
JOIN disciplina d ON t.id_disciplina = d.id_disciplina
GROUP BY p.nome
ORDER BY soma_carga_horaria DESC;
