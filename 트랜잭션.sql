begin tran; -- Ʈ����� ����
update book
set price = price + 100
where bookid = 1;

update book
set price = price + 100
where bookid = 2;

commit;