-- ����� �߰�
use master
create login test2 with password = '1234', default_database = madang

use madang
create user test2 for login test2 with default_schema = dbo

-- ���� �ο�
grant select on book to test1

grant select, update on customer to test2 with grant option 

grant select on orders to public 

-- select�� ���� �༭ insert ����� �ȵ�

-- ���� ����
revoke select on book from test1

revoke select on customer from test1 --�ο��� �� �ִ� ������ ����ϰų� �ź��Ϸ��� CASCADE �ɼ��� �����Ͻʽÿ�.
revoke select on customer from test1 cascade

-- role �߰�
create role programmer

grant select, update on book to programmer
grant select, insert on orders to programmer

exec sp_addrolemember programmer, test1 -- ����ǥ����
exec sp_addrolemember programmer, test2 -- ����ǥ����

exec sp_droprolemember programmer, test1 -- �� ���
exec sp_droprolemember programmer, test2 -- �� ���

-- role ����
drop role programmer