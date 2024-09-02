CREATE DATABASE LabAula08_Ex01

CREATE TABLE Funcionario(
	Codigo					INT,
	Nome					VARCHAR(100),
	Salario					DECIMAL(6,2)
	PRIMARY KEY(Codigo)
)

CREATE TABLE Dependente(
	Codigo_Dep				INT,
	Codigo_Funcionario		INT,
	Nome_Dependente			VARCHAR(100),
	Salario_Dependente		DECIMAL(6,2)
	PRIMARY KEY(Codigo_Dep, Codigo_Funcionario)
	FOREIGN KEY(Codigo_Funcionario) REFERENCES Funcionario(Codigo) 
)

CREATE FUNCTION fn_tabela()
RETURNS @tabela TABLE(
	Nome_Dep				VARCHAR(100),
	Nome_Funrionario		VARCHAR(100),
	Salario_Funcionario		DECIMAL(6,2),
	Salario_Dependente		DECIMAL(6,2)
)
AS
BEGIN
	INSERT INTO @tabela(Nome_Dep,Nome_Funrionario,Salario_Funcionario,Salario_Dependente)
		SELECT d.Nome_Dependente, f.Nome, f.Salario, d.Salario_Dependente
		FROM Dependente AS d
		JOIN Funcionario AS f
		ON Codigo_Funcionario = Codigo
	RETURN
END



CREATE FUNCTION fn_somaSalario()
RETURNS DECIMAL(8,2)
AS
BEGIN
	DECLARE @soma	DECIMAL(8,2),
			@salFun	DECIMAL(6,2),
			@salDep	DECIMAL(6,2)

	SELECT @salFun = f.Salario, @salDep = d.Salario_Dependente
	FROM Dependente as d
	JOIN Funcionario as f
	ON d.Codigo_Funcionario = f.Codigo

	SET @soma = @salDep + @salFun

	RETURN @soma
END

