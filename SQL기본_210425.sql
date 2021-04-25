-- 6

-- Instructor 테이블에서 유일한 dept_name 출력
use University;
select distinct dept_name from instructor;
-- Instructor 테이블에서 이름, salary, 1.1% 인상한 salary 출력 (별칭: 이름, 인상전, 인상후)
select name as 이름, salary as 인상전, salary * 1.1 as 인상후 from instructor;

-- Instructor 테이블에서 name 이름, salary(연봉)을 이용한 월급을 2번째 자리까지 반올림한 결과(월급여) 출력
select name 이름, salary 인상전, round(salary / 12, 2) 월급여 from instructor;

-- 0 학과 0 학생의 취득학점은 0 의 형식으로 출력. Dept_name(학과), name(학생), tot_cred(취득학점, int 형임)
select dept_name + '학과 ' + name + ' 학생의 취득학점은 ' + convert(varchar, tot_cred) from student;

-- SQL Expert 대문자로, 소문자로, a의 아스키 문자, 65에 해당하는 문자, rdbms와 sql 문자열 연결
-- sql expert에서 5번째자리부터 길이 3 출력, 문자열 길이 함수, 왼쪽 공백 제거 함수(    sql expert)
select UPPER('SQL Expert');
select LOWER('SQL Expert');
select ASCII('A');
SELECT CHAR(65);
SELECT CONCAT('RDBMS', ' SQL');
SELECT SUBSTRING('SQL EXPERT', 5, 3);
SELECT LEN('SQL EXPERT');
SELECT LTRIM('   SQL EXPERT');

-- 절대값 함수, 부호 알려주는 함수 음수면 -1 0이면 0 양수면 1, 반올림 함수, 올림, 내림, 지수함수, 거듭제곱, 루트
SELECT ABS(-10);
SELECT SIGN(-1), SIGN(0), SIGN(1);
SELECT ROUND(7.537, 2);
SELECT CEILING(7.5);
SELECT FLOOR(7.5);
SELECT EXP(10);
SELECT POWER(2, 4);
SELECT SQRT(4);

-- 현재 날짜+시간 출력 함수 2가지, 요일 출력, 분기 출력, 오늘 기준 100일 뒤 날짜 구하기, 날짜 차이 구하기
-- 현재 날짜 및 시간에서 날짜만 출력
SELECT SYSDATETIME();
SELECT GETDATE();
SELECT DATENAME(WEEKDAY, GETDATE());
SELECT DATEPART(QUARTER, GETDATE());
SELECT DATEADD(DAY, 100, GETDATE());
SELECT DATEDIFF(dd, GETDATE(), '2021-04-26');
select convert(char(20), getdate(), 108);

-- 지정한 날짜 형식의 부분만 출력  emp 테이블의 ename, hiredate에서 입사년, 입사월, 입사일 출력
use company;
select ename, year(hiredate) 입사년, month(hiredate) 입사월, day(hiredate) 입사일
from emp;

select ename, datepart(year, hiredate) 입사년, datepart(month, hiredate) 입사월, datepart(day, hiredate) 입사일
from emp;

-- instructor 테이블에서 salary를 int 형식으로 출력
use University;
select convert(int, salary) as 월급
from instructor;

select cast(salary as int) as 월급
from instructor;

-- emp 테이블에서 sal이 2000 초과인 데이터는 sal로 , 아니면 2000으로 출력(개정급여로)
use COMPANY;
select case when sal > 2000 then sal else 2000 end as 개정급여
from emp;

-- emp 테이블에서 ename, sal을 개정전으로, sal이 3000초과면 sal을 1.05 인상, sal이 2000초과면 sal 1.10 인상, 아니면 sal 1.20 인상한 값을 개정후 로 출력
select ename, sal 개정전, case when sal > 3000 then sal * 1.05 when sal > 2000 then sal * 1.10 else sal * 1.20 end 개정후
from emp;

-- dept 테이블에서 loc 출력, loc이 new york이면 east로 boston이면 east로 else면 etc로 변경한 값을 area로 출력
select loc, case loc when 'new york' then 'east' when 'boston' then 'east' else 'etc' end as area 
from dept;

-- emp 테이블에서 ename 이름, sal 급여, comm 커미션, comm이 null이면 0으로 바꿔 sal과 더한 뒤 월지급액 출력
select ename 이름, sal 급여, comm 커미션, isnull(comm, 0) + sal 월지급액
from emp;

-- emp 테이블에서 ename, empno, ngr, mgr이 7698이면 null으로 아니면 그대로 nullif이름으로 출력
select ename, empno, mgr, nullif(mgr, 7698) as nulif
from emp;

-- player 테이블에서 player_name이 장으로 시작하는 player_name 선수명, position 포지션, back_no 백넘버, height 키 출력
use K_LEAGUE;
select player_name as 선수명, position as 포지션, back_no as 백넘버, height as 키
from player
where player_name LIKE '장%';

-- player 테이블에서 player_name 가운데 이름이 인인 사람 player_name 선수명, position 포지션, back_no 백넘버, height 키 출력
select player_name as 선수명, position as 포지션, back_no as 백넘버, height as 키
from player
where player_name like '_인_';

-- player 테이블에서 position이 null 인 player_name 선수명, position 포지션, back_no 백넘버, height 키 출력
select player_name as 선수명, position as 포지션, back_no as 백넘버, height as 키 
from player
where position is null;

-- player 테이블에서 team_id가 k02, k07 안에 있고 position이 mf고 height가 170-180 사이인 팀id, 선수명, 포지션, 백넘버, 키 출력
select team_id, player_name, position, back_no, height
from player
where team_id in ('K02', 'K09') and position = 'mf' and height between 170 and 180;

-- player 테이블에서 team_id가 k02이고 position이 mf이 아니고 height가 175-185 아닌 사람의 선수명, 포지션, 백넘버, 키 출력
select player_name, position, back_no, height
from player
where team_id = 'K02' and not position != 'mf' and not height between 175 and 185;

-- Player 테이블에서 nation이 null이 아닌 player_name과 nation 출력
select player_name, nation
from player
where nation is not null;

-- player 테이블에서 전체 행수, 키 건수(height), 최대키, 최소키, 평균키 출력
select count(*) as 전체행수, count(height) 키건수, max(height) 최대키, min(height), avg(height)
from player;

-- position이 있는 선수들의 position, height 평균키를 position 별로 출력
select position, avg(height) 평균키
from player
group by POSITION;

-- height의 평균이 180 이상인 선수들의 position, 평균키를 position 별로 출력
select position, avg(height)
from player
group by position
having avg(height) >= 180

-- team_id가 k02, k09인 선수들의 팀 id, 인원수를 팀별로 분류 (where, having 버전 두개)
select team_id, count(*) as 인원수
from player
where team_id in ('k02', 'k09')
group by team_id;

select team_id, count(*) as 인원수
from player
group by team_id
having team_id in ('k02', 'k09');

-- team별로 position이 fw이면 1으로 아니면 그대로해서 합한 값fw와 team_id 출력
select team_id, sum(case position when 'fw' then 1 end) as fw
from player
group by team_id;

-- 위에서 position이 null이면 0으로 바꿔서 출력
select team_id, isnull(sum(case position when 'fw' then 1 end), 0) as fw
from player
group by team_id;

-- 위에서 fw, mf, df, gk 포지션 별로 출력
select team_id, isnull(sum(case position when 'fw' then 1 end), 0) as fw,
isnull(sum(case position when 'mf' then 1 end), 0) as mf,
isnull(sum(case position when 'df' then 1 end), 0) as df,
isnull(sum(case position when 'gk' then 1 end), 0) as gk
from player
group by team_id;

-- player테이블에서 back_no가 null이 아닌 player의 선수명, 포지션, 백넘버 출력하는데 백넘버, 포지션, 선수명 으로 내림차순 정렬 (숫자로!)
SELECT PLAYER_NAME, POSITION, BACK_NO
FROM PLAYER
WHERE BACK_NO IS NOT NULL
ORDER BY 3 DESC, 2, 1;

-- emp 테이블에서 job, 인원수, sal 평균급여 출력하는 데 job 별로 묶고 sal 평균급여가 2500이 초과인 사람 출력. 
-- Sal 평균 급여 내림차순으로 출력
USE COMPANY;
SELECT JOB, COUNT(*) 인원수, AVG(SAL) 평균급여
FROM EMP
GROUP BY JOB
HAVING AVG(SAL) > 2500
ORDER BY AVG(SAL) DESC;

-- team이랑 player 테이블 team.id 기준으로 inner 조인 후 player_name 선수명, team_name 소속팀명 출력 
-- (2가지 버전: equi join, ansi/iso sql 표준 조인  inner는 생략 가능)
USE K_LEAGUE;
SELECT PLAYER_NAME, TEAM_NAME
FROM TEAM, PLAYER
WHERE TEAM.TEAM_ID = PLAYER.TEAM_ID;

SELECT PLAYER_NAME, TEAM_NAME
FROM TEAM JOIN PLAYER
ON TEAM.TEAM_ID = PLAYER.TEAM_ID;

-- 위에서 equi join 중 player 를 a로 team을 b로 별칭 주기
SELECT PLAYER_NAME, TEAM_NAME
FROM PLAYER A, TEAM B
WHERE A.TEAM_ID = B.TEAM_ID;

-- player와 team 테이블에서 team_id가 같고 a의 position이 ‘gk’인 데이터를 대상으로 player_name 선수명, back_no 백넘버, region_name 연고지, team_name 팀명 출력
SELECT PLAYER_NAME, BACK_NO, REGION_NAME
FROM PLAYER A, TEAM B
WHERE A.TEAM_ID = B.TEAM_ID AND A.POSITION = 'GK';

-- EMP A 테이블와 SAL_GRADE B 테이블에서 비교연산자로 JOIN
-- EMP의 ENAME, SAL, SAL_GRADE의 GRADE 급여등급 출력
-- EMP의 SAL이 B의 LOSAL과 HISAL 사이에 있을 때 급여등급 기준 오름차순 조회
USE COMPANY;
SELECT A.ENAME, A.SAL, B.GRADE 급여등급
FROM EMP A, SAL_GRADE B
WHERE A.SAL BETWEEN B.LOSAL AND B.HISAL
ORDER BY 급여등급;

-- 3개 이상 테이블 조인, player a의 team_id과 team b의 team_id가 같고 stadium c와 b의 stadium_id가 같은 데이터 조인
USE K_LEAGUE;
SELECT *
FROM PLAYER A, TEAM B, STADIUM C
WHERE A.TEAM_ID = B.TEAM_ID AND C.STADIUM_ID = B.STADIUM_ID;

-- emp A의 deptno와 dept B의 deptno를 기준으로 b의 deptno가 30인 데이터 중 a의 empno, a의 ename, b의 deptno, dname 출력
USE COMPANY;
SELECT A.DEPTNO, A.ENAME, B.DEPTNO, B.DNAME
FROM EMP A, DEPT B
WHERE A.DEPTNO = B.DEPTNO AND B.DEPTNO = 30

SELECT A.DEPTNO, A.ENAME, B.DEPTNO, B.DNAME
FROM EMP A INNER JOIN DEPT B ON A.DEPTNO = B.DEPTNO 
WHERE B.DEPTNO = 30

-- emp A의 deptno와 dept B의 deptno를 기준으로 a의 mgr이 7698인 데이터 중 a의 empno, a의 ename, b의 deptno, dname 출력
SELECT A.EMPNO, A.ENAME, B.DEPTNO, B.DNAME
FROM EMP A INNER JOIN DEPT B 
ON A.DEPTNO = B.DEPTNO
WHERE A.MGR = 7698

-- player a테이블, team B 테이블, stadium C 테이블 조인, a의 position이 ‘gk’일 때, a의 player_name 기준으로 정렬
USE K_LEAGUE;
SELECT * FROM PLAYER;
SELECT * FROM TEAM;
SELECT * FROM STADIUM;

SELECT *
FROM PLAYER A JOIN TEAM B
ON A.TEAM_ID = B.TEAM_ID JOIN STADIUM C ON C.STADIUM_ID = B.STADIUM_ID
WHERE A.POSITION = 'GK'
ORDER BY A.PLAYER_NAME;

-- EMP A와 DEPT B 카티션 프로덕트, A의 ENAME 기준으로 정렬. A의 ENAME이랑 B의 DNAME 조회
USE COMPANY;
SELECT A.ENAME, B.DNAME
FROM EMP A CROSS JOIN DEPT B
ORDER BY A.ENAME;

-- STADIUM A, TEAM B 왼쪽 아우터 조인하는데 A의 STADIUM_NAME, A.STADIUM_ID, A.SEAT_COUNT, A.HOMETEAM_ID, B.TEAM_NAME 조회
USE K_LEAGUE;
SELECT A.STADIUM_NAME, A.STADIUM_ID, A.SEAT_COUNT, A.HOMETEAM_ID, B.TEAM_NAME
FROM STADIUM A LEFT OUTER JOIN TEAM B
ON A.HOMETEAM_ID = B.TEAM_ID;

SELECT * FROM STADIUM;
SELECT * FROM TEAM;

-- DEPT로부터 DEPT_TEMP 복사하기
USE COMPANY;
SELECT * INTO DEPT_TEMP FROM DEPT;

-- DEPT_TEMP 에서 DNAME이 RESEARCH 인 데이터 CONSULTING으로 바꾸기
UPDATE DEPT_TEMP
SET DNAME = 'CONSULTING'
WHERE DNAME = 'RESEARCH';

-- DEPT_TEMP 에서 DEPTNO에 20 더한 값으로 바꾸기
UPDATE DEPT_TEMP
SET DEPTNO += 20;