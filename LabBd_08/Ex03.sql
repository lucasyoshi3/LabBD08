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

CREATE TABLE Venda (
    CodigoCliente	INT,
    CodigoProduto	INT,
    Quantidade		INT,
    DataVenda		DATE,
    FOREIGN KEY (CodigoCliente) REFERENCES Cliente(Codigo),
    FOREIGN KEY (CodigoProduto) REFERENCES Produto(Codigo)
);

CREATE FUNCTION fn_tabela()
RETURNS @table TABLE(
	Nome_Cliente	VARCHAR(100),
	Nome_Produto	VARCHAR(100),
	Quantidade		INT,
	Valor_Total		INT,
	Data_Hoje		DATE
)
AS
BEGIN
	INSERT INTO @table(Nome_Cliente,Nome_Produto,Quantidade,Valor_Total,Data_Hoje)
	SELECT
        c.Nome,
        p.Nome,
        v.Quantidade,
        p.Valor * v.Quantidade,
        GETDATE()
    FROM
        Venda v
        JOIN Cliente c 
		ON v.CodigoCliente = c.Codigo
        JOIN Produto p 
		ON v.CodigoProduto = p.Codigo

	RETURN 
END
