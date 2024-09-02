CREATE DATABASE LabAula08_Ex03

CREATE TABLE Cliente (
    Codigo			INT,
    Nome			VARCHAR(100)
	PRIMARY KEY(Codigo)
);

CREATE TABLE Produto (
    Codigo			INT,
    Nome			VARCHAR(100),
    Valor			DECIMAL(10, 2)
	PRIMARY KEY(Codigo)
);

CREATE FUNCTION fn_tabela(@codigoC int, @codigoP int, @quantidade int)
RETURNS @table TABLE(
	Nome_Cliente	VARCHAR(100),
	Nome_Produto	VARCHAR(100),
	Quantidade		INT,
	Valor_Total		INT,
	Data_Hoje		DATE
)
AS
BEGIN
	INSERT INTO @table(Nome_Cliente)
	SELECT nome 
	FROM Cliente
	WHERE Cliente.Codigo = @codigoC

	UPDATE @table SET Nome_Produto = (SELECT Nome FROM Produto WHERE Codigo = @codigoP)
	UPDATE @table SET Quantidade = @quantidade
	UPDATE @table SET Valor_Total = (SELECT Valor FROM Produto WHERE Codigo = @codigoP) * @quantidade
	UPDATE @table SET Data_Hoje = GETDATE()

	RETURN 
END

INSERT INTO Cliente VALUES (1, 'Carlos')
INSERT INTO Cliente VALUES (2, 'Ricardo')
INSERT INTO Cliente VALUES (3, 'Manuela')
INSERT INTO Cliente VALUES (4, 'Miguel')

INSERT INTO Produto VALUES (1,'Chuteira', 450)
INSERT INTO Produto VALUES (2,'Chuteira NIKE', 600)
INSERT INTO Produto VALUES (3,'Chuteira ARDIDAS', 50)
INSERT INTO Produto VALUES (4,'Chuteira FUMA', 30)

SELECT *
FROM fn_tabela (2, 4, 5)
