-- 사용자 추가
use master
create login test2 with password = '1234', default_database = madang

use madang
create user test2 for login test2 with default_schema = dbo

-- 권한 부여
grant select on book to test1

grant select, update on customer to test2 with grant option 

grant select on orders to public 

-- select만 권한 줘서 insert 등등은 안됨

-- 권한 뺏기
revoke select on book from test1

revoke select on customer from test1 --부여할 수 있는 권한을 취소하거나 거부하려면 CASCADE 옵션을 지정하십시오.
revoke select on customer from test1 cascade

-- role 추가
create role programmer

grant select, update on book to programmer
grant select, insert on orders to programmer

exec sp_addrolemember programmer, test1 -- 저장표시자
exec sp_addrolemember programmer, test2 -- 저장표시자

exec sp_droprolemember programmer, test1 -- 롤 드랍
exec sp_droprolemember programmer, test2 -- 롤 드랍

-- role 삭제
drop role programmer