CREATE DATABASE LabAula08_Ex02

CREATE TABLE Produtos(
	codigo				INT,
	nome				VARCHAR(100),
	valor_unitario		DECIMAL(7,2),
	qtd_estoque			INT
	PRIMARY KEY(codigo) 
)

CREATE FUNCTION fn_quantidade_abaixo(@qtd INT)
RETURNS INT
AS 
BEGIN
	DECLARE @qtd_estoque	INT,
			@soma			INT
	SET @soma = 0;

	SELECT @qtd_estoque = p.qtd_estoque 
	FROM Produtos as p

	IF(@qtd_estoque < @qtd)
	BEGIN
		SET @soma = @soma+1
	END

	RETURN @soma
END


CREATE FUNCTION fn_estoque(@qtd INT)
RETURNS @table TABLE(
	codigo			INT,
	nome			VARCHAR(100),
	qtd_estoque		INT
)
AS
BEGIN
	INSERT INTO @table (codigo, nome, qtd_estoque)
		SELECT p.codigo, p.nome, p.qtd_estoque
		FROM Produtos as P
		WHERE p.qtd_estoque < @qtd

	RETURN 
END