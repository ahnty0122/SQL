begin tran; -- 트랜잭션 시작
update book
set price = price + 100
where bookid = 1;

update book
set price = price + 100
where bookid = 2;

commit;