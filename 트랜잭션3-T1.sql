BEGIN TRAN
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;

SELECT SUM(PRICE) 총액
FROM BOOK;

SELECT SUM(PRICE) 총액
FROM BOOK;

COMMIT;

-- 반복 불가능 읽기 문제 발생!
-- 발생하지 않도록 하려면 REPEATABLE READ 로 변경