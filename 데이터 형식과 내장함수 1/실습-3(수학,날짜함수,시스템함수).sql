-- 수학함수
-- 절대값
select abs(-777);
-- ceiling()는 무조건 올림, floor()함수는 무조건 내림, round()반올림 함수
select ceiling(10.1), floor(10.9), round(10.5);
-- conv()는 진법변환을 해줌. 16진수->2진수, 10진수->8진수
select conv('FF', 16, 2), conv(100, 10, 8);
-- mod(), %(이항연산자) 나머지값을 구해준다.
select mod(228, 10), 228%10, 228 mod 10;
-- pow()는 거듭제곱을 구함, sqrt()제곱근을 구하는 함수
select pow(3, 3), sqrt(25);
-- rand()함수는 0.000000~0.999999사이의 임의값을 출력함(시간을 기준)
-- 우측 컬럼은 주사위의 눈을 랜덤으로 구하는 공식
select rand(), floor(1 + (rand() * 6));
-- sign()함수는 양수인지 0인지 음수인지를 확인하는 함수이다.
select sign(123),sign(0),sign(-123);
-- truncate()는 해당 자릿수까지만 출력하고 나머지는 버린다.
select truncate(2222.2272,2), truncate(2222.2272,-2);

-- 날짜 함수들
-- adddate()함수의 단위로 day, month, year단위 interval을 주게되면
-- 주어진 날짜로 부터 뒷날 리턴함(더하는 개념)
select adddate('2020-02-01', interval 15 day);
select adddate('2020-02-01', interval 15 month);
select adddate('2020-02-01', interval 15 year);

-- subdate()함수의 단위로 day, month, year단위 interval을 주게되면
-- 주어진 날짜로 부터 앞날 리턴함(빼는 개념)
select subdate('2020-02-01', interval 15 day);
select subdate('2020-02-01', interval 15 month);
select subdate('2020-02-01', interval 15 year);

-- addtime은 시간을 더하는 함수이다.
select addtime('10:10:10', '1:1:1');

-- subtime은 시간을 빼는 함수이다.
select subtime('10:10:10', '1:1:1');

-- 현재날짜, 현재시간, 현재날짜시간, 현재날짜시간
select curdate(), curtime(), now(), sysdate();
-- year()는 날짜, month()함수는 월, day()는 일을 추출해서 출력한다.
select year(curdate()), month(curdate()), day(curdate());

select hour(curtime()), minute(curtime()), second(curtime());
-- 현재부터 인자값까지의 날짜 차이를 리턴한다.
select datediff('20200101', sysdate());
select datediff(now(), '20200101');

-- 시간의 차이를 구한다.
select timediff('10:10:10', curtime());
select timediff(curtime(), '10:10:10');
-- dayofweek()요일을 리턴하는데 상수값을 리턴한다. 일요일 1을, 월요일 2...
-- monthname()함수는 달의 이름을 영어로 출력을 해준다.
-- dayofyear()함수는 1년 중에 몇일 째인지 리턴을 해준다.
select dayofweek(curdate()), monthname(curdate()), dayofyear(curdate());
-- last_day() 주어진 달의 마지막날을 구해준다.
select last_day(curdate());
select last_day('20200101');
-- makedate()함수는 2020년에서 60일째 되는 날을 리턴을 해준다.
select makedate(2020, 60);
-- maketime() 인자값으로 시간을 만들어 리턴한다.
select maketime(12,10,10);

select period_add('202001', 11), period_diff(202001, 201812);

-- quarter() 몇사분기인지 리턴을 해준다.
select concat(quarter(curdate()), '사분기') as '분기';
-- 시간을 초로 환산해준다.
select time_to_sec('12:12:12');

-- 시스템 함수
use sqldb;
select current_user(), database();

select *
  from buytbl;
-- found_rows()는 이전 조회된 rows의 건수를 리턴한다.
select found_rows();

update buytbl
   set price = price/2;
-- row_count() 이전 update,delete,insert한 건수를 리턴한다.(버전별로 상이함)
select row_count();

-- sleep()는 주어진 인자값만큼 멈추어준다.
select sleep(5);
select '5초후에 이게 보입니다';




