SET STATISTICS TIME ON 
SET STATISTICS IO ON
SELECT * FROM Houses WHERE Addres = N'456 Trần Hưng Đạo, Q.5'
-- logical reads 2 & elapsed time = 3 ms. - 3 dong du lieu 
CREATE NONCLUSTERED INDEX IX_Houses_Addres
ON dbo.Houses (Addres ASC);
DROP INDEX IF EXISTS IX_Houses_Addres ON dbo.Houses;
