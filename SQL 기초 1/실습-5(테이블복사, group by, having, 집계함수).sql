-- 테이블을 복사하는 방법
use sqldb;
drop table if exists buytbl_copy;
-- buytbl의 데이터 전부를 쿼리를 해서 새로운 테이블인 buytbl_copy로 복사해라.
create table buytbl_copy(
	select *
      from buytbl
);

select *
  from buytbl_copy;
-- 하지만, 테이블을 복사를 하게 되더라도 PK, FK등의 제약조건은 복사가 되지 않는다.
desc buytbl_copy;
desc buytbl;

-- 기본적 쿼리문 순서(매우 중요함)
-- 무조건 아래와 같은 순서로 작성을 해야한다.
--   select ...
--     from ...
--    where ...
-- group by ...
--   having ...
-- order by ...

-- 고객이 구매한 건수를 확인해보는 쿼리문이다.문제는 중복되는게 많이 나온다.
-- 아울러, 집계가 되지 않아서 한 눈에 보기 어렵다.
-- 하여, group by절을 이용하면 편리하다.
select userid, amount
  from buytbl
order by userid;

-- 아래 쿼리를 실행해보면 고객별로 구매한 건수가 한 눈에 들어온다.
-- 여기서 sum()이 나왔는데 이것은 집계함수이며, 아울러 group by를 할 때
-- 즉, 그룹을 지을 때 userid로 하겠다라는 의미이다. 일단, 집계함수류가 나오면
-- 무조건 group by절이 들어가야 한다는 것을 기억을 하도록 하자.
-- 현업에서 정말 많이 쓴다.
select userid, sum(amount)
  from buytbl
group by userid
order by sum(amount) desc;


-- 아래는 알리아스를 사용하여 컬럼명을 바꾸어서 출력해봄
select userid as '아이디', sum(amount) as '구매 건수'
  from buytbl
group by userid
order by sum(amount) desc;

-- 이제는 총 구매액을 한번 집계를 해보자
-- 총구매액은 총구매수량 * 단가가 될 것이다.
select *
  from buytbl;
 
-- 아래 쿼리는 고객별로 총구매액을 기준으로 내림차순으로 정렬하는 쿼리이다.
select userid as '아이디', sum(price*amount) as '총 구매액'
  from buytbl
group by userid
order by sum(price*amount) desc;

-- 아래 쿼리는 고객별로 평균 구매갯수를 알아보는 쿼리이다.
select userid as '아이디', avg(amount) as '평균 구매갯수'
  from buytbl
group by userid
order by avg(amount) desc;

-- 아래 쿼리는 모든 고객을 대상으로 평균 구매갯수를 알아보는 쿼리이다.
select avg(amount)
  from buytbl;

-- max(), min()
select name, height
  from usertbl;

-- 아래와 같이 쿼리를 치게 되면 원하는 값을 얻을 수 없다.
-- name별로 group by절을 적용시키니 당연히 10개의 데이터가 다 나온다.
select name, max(height), min(height)
  from usertbl
 group by name;

-- 아래 서브쿼리를 이용하면 적절히 원하는 값을 도출할 수가 있다.
select name, height
  from usertbl
 where height = (
	select max(height)
	  from usertbl) 
	or height = (
	select min(height)
	  from usertbl);

-- 건수를 집계하는 count()대해서 살펴보자
select count(*)
  from usertbl;
  
select count(*) as '휴대폰이 있는 사람'
  from usertbl
where mobile1 is not null;

use employees;
select *
  from employees;
  
select count(*)
  from employees;
use sqldb;
-- 총 구매액으로 내림차순 정렬을 해놓은 쿼리문이다.
-- 근데 총구매액이 1000만원 이상만 보고싶다면 어떻게 하면 될까?
-- where절에 조건문을 제시하니깐 에러가 났다. where조건절에는 집계함수를 사용할 수가 없다.(매우 중요하다)
-- group by된 절들은 having조건을 줘야 한다.
select userid as '아이디', sum(price*amount) as '총 구매액'
  from buytbl
where sum(price*amount) > 1000
group by userid
order by sum(price*amount) desc;

-- having은 조건절이다.
select userid as '아이디', sum(price*amount) as '총 구매액'
  from buytbl
group by userid
having sum(price*amount) > 1000
order by sum(price*amount) desc;

-- with roll up : 분류별로 소합계 내주고 마지막에 총합계 보여줌
-- num 추가하게 되면 건별로 소합계 나오고 총합계 나옴
select num, groupname, sum(price*amount)
  from buytbl
 group by groupname, num
 with rollup; 

select groupname, sum(price*amount)
  from buytbl
 group by groupname
 with rollup; 