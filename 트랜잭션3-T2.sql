BEGIN TRAN
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;

SELECT BOOKID, BOOKNAME, PUBLISHER, PRICE
FROM BOOK
WHERE BOOKID = 1;

SELECT SUM(PRICE) �Ѿ�
FROM BOOK;

UPDATE BOOK
SET PRICE = PRICE + 500
WHERE BOOKID = 1;

SELECT SUM(PRICE) �Ѿ�
FROM BOOK;

COMMIT;

