-- 7.

-- 서브쿼리
-- player 테이블에서 정남일 선수의 팀의 player_name 선수명, position 포지션, back_no 백넘버 출력, player_name으로 정렬
USE K_LEAGUE;
SELECT PLAYER_NAME, POSITION, BACK_NO
FROM PLAYER
WHERE TEAM_ID = (SELECT TEAM_ID FROM PLAYER WHERE PLAYER_NAME = '정남일')
ORDER BY PLAYER_NAME;

-- player 테이블에서 선수들 평균키 (height이용)보다 큰 키를 가진 선수들의 player_name, position, back_no 출력, player_name으로 정렬
SELECT PLAYER_NAME, POSITION, BACK_NO
FROM PLAYER
WHERE HEIGHT > (SELECT AVG(HEIGHT) FROM PLAYER)
ORDER BY PLAYER_NAME;

-- team 테이블에서 정현수 선수가 속한 팀의 region_name, team_name, e_team_name 출력
SELECT REGION_NAME, TEAM_NAME, E_TEAM_NAME
FROM TEAM
WHERE TEAM_ID IN (SELECT TEAM_ID FROM PLAYER WHERE PLAYER_NAME = '정현수');

-- player a와 team b 테이블에서 team_id 별로, a의 team_id 팀의 선수들의 평균키보다 a의 height가 작은 데이터 중 
-- b의 team_name, a의 player_name, a의 position, a의 back_no, a의 height 출력
SELECT B.TEAM_NAME, A.PLAYER_NAME, A.POSITION, A.BACK_NO, A.HEIGHT
FROM PLAYER A, TEAM B
WHERE A.HEIGHT < (SELECT AVG(HEIGHT) FROM PLAYER X WHERE X.TEAM_ID = A.TEAM_ID GROUP BY X.TEAM_ID) 
AND B.TEAM_ID = A.TEAM_ID
ORDER BY A.PLAYER_NAME;

-- stadium a 테이블과 schedule x 테이블에서 x와 a의 stadium_id가 같은 값을 만족하고 x의 sche_date가 20120501 과 20120502 사이에 
-- 있는 데이터의 a의 stadium_id, stadium_name 출력
SELECT A.STADIUM_ID, A.STADIUM_NAME
FROM STADIUM A, SCHEDULE X
WHERE A.STADIUM_ID = X.STADIUM_ID AND X.SCHE_DATE BETWEEN 20120501 AND 20120502;

SELECT A.STADIUM_ID, A.STADIUM_NAME
FROM STADIUM A
WHERE EXISTS (SELECT * FROM SCHEDULE X WHERE X.STADIUM_ID = A.STADIUM_ID AND X.SCHE_DATE BETWEEN '20120501' AND '20120502')

-- player a 테이블에서 player_name, height, team_id 팀평균키 출력
SELECT * FROM PLAYER
SELECT A.PLAYER_NAME, A.HEIGHT, A.TEAM_ID, (SELECT AVG(HEIGHT) FROM PLAYER X WHERE X.TEAM_ID = A.TEAM_ID) 팀평균키
FROM PLAYER A;

-- player 테이블에서 position이 mf인 테이블을 a라고 명칭, team을 b라고 별칭 주고 두 table의 team_id가 같을 때 join, 
-- a의 player_name 기준 정렬
SELECT *
FROM (SELECT * FROM PLAYER WHERE POSITION = 'MF') A, team B
WHERE A.TEAM_ID = B.TEAM_ID
ORDER BY A.PLAYER_NAME;

-- player a 테이블와 team b 테이블에서 a의 team_id, b의 team_name, a의 평균키 출력하는데 a의 team_id, b의 team_name 별로 그루핑,
-- 삼성블루윙즈를 team_name으로 가지는 team_id에 속하는 team의 평균키보다 a의 height가 큰 것만 출력
-- 각 팀의 평균키가 삼성블루윙즈 팀의 평균키보다 작은 팀을 대상으로 A.TEAM_ID, B.TEAM_NAME, 평균키 선택
 SELECT A.TEAM_ID, B.TEAM_NAME, AVG(A.HEIGHT)
 FROM PLAYER A, TEAM B
 GROUP BY A.TEAM_ID, B.TEAM_NAME
 HAVING AVG(A.HEIGHT) <  (SELECT AVG(HEIGHT) FROM PLAYER X WHERE X.TEAM_ID IN 
 (SELECT TEAM_ID FROM TEAM WHERE TEAM_NAME = '삼성블루윙즈'));


-- player a와 team b 테이블에서 b와 a의 team_id 가 같은 것만 조인한 a의 player_name, position, back_no, b의 team id, 
-- team_name 출력한 결과를 뷰(v_player_Team)로 생성
CREATE VIEW V_PLAYER_TEAM AS 
(SELECT A.PLAYER_NAME, A.POSITION, A.BACK_NO, B.TEAM_ID, B.TEAM_NAME FROM PLAYER A, TEAM B WHERE B.TEAM_ID = A.TEAM_ID);

-- v_player_team에서 position이 ‘gk’, ‘mf’ 인 player_name, position, back_no, team_name 출력결과를 v_player_team_filter 뷰로 정의
CREATE VIEW V_PLAYER_TEAM_FILTER
AS (SELECT PLAYER_NAME, POSITION, BACK_NO, TEAM_NAME FROM V_PLAYER_TEAM WHERE POSITION IN ('GK', 'MF'))

-- (합집합) player 테이블에서 team_id가 ‘k07’인 player_name, back_no 결과와 ‘k09’인 결과 출력
SELECT PLAYER_NAME, BACK_NO
FROM PLAYER WHERE TEAM_ID = 'K07'
UNION
SELECT PLAYER_NAME, BACK_NO
FROM PLAYER WHERE TEAM_ID = 'K07';

-- 위에서 합집합 명령어 말고 그냥 select만 이용해서 출력해보기
SELECT DISTINCT PLAYER_NAME, BACK_NO
FROM PLAYER WHERE TEAM_ID = 'K02' OR TEAM_ID = 'K07';

-- player 테이블에서 team_id가 ‘k02’인 team_id, player_name, position, back_no, height 결과와 position이 ‘gk’인 결과 합치기 
-- (중복 제거 버전과 중복 제거 x 버전)
SELECT TEAM_ID, PLAYER_NAME, BACK_NO, HEIGHT FROM PLAYER WHERE TEAM_ID = 'K02'
UNION
SELECT TEAM_ID, PLAYER_NAME, BACK_NO, HEIGHT FROM PLAYER WHERE POSITION = 'GK'

SELECT TEAM_ID, PLAYER_NAME, BACK_NO, HEIGHT FROM PLAYER WHERE TEAM_ID = 'K02'
UNION ALL
SELECT TEAM_ID, PLAYER_NAME, BACK_NO, HEIGHT FROM PLAYER WHERE POSITION = 'GK'

-- player 테이블에서 position 별로 ‘P’ 구분코드, position, height 평균키 출력한 결과와 team_id 별로 ‘t’ 구분코드
-- team_id, height 평균키 출력 결과 합친 후 p와 t 구분코드 순서대로 정렬
SELECT  'P' 구분코드, POSITION, AVG(HEIGHT) FROM PLAYER GROUP BY POSITION
UNION ALL
SELECT  'T' 구분코드, TEAM_ID, AVG(HEIGHT) FROM PLAYER GROUP BY TEAM_ID
ORDER BY 1, 2 DESC;

-- player 테이블에서 team_id가 ‘k02’인 team_id, player_name, position, back_no, height 중에서 position이 mf인 값 빼기
SELECT TEAM_ID, PLAYER_NAME, POSITION, BACK_NO, HEIGHT FROM PLAYER WHERE TEAM_ID = 'K02'
EXCEPT SELECT * FROM PLAYER WHERE POSITION = 'MF';

-- Emp a 테이블과 dept b 테이블에서 a의 deptno와 b의 deptno가 같은 값들 b의 dname과 a의 job 별로 출력 
-- (b.dame, a.job, count(*) emp_cnt, sum(a.sal) sal sum)
USE COMPANY;
SELECT B.DNAME, A.JOB, COUNT(*) EMP_CNT, SUM(A.SAL), SUM(A.SAL) SAL_SUM
FROM EMP A JOIN DEPT B ON A.DEPTNO = B.DEPTNO
GROUP BY B.DNAME, A.JOB;

-- 위에서 b.name과 a.job 별로 총합 계산 (group function)
SELECT B.DNAME, A.JOB, COUNT(*) EMP_CNT, SUM(A.SAL), SUM(A.SAL) SAL_SUM
FROM EMP A JOIN DEPT B ON A.DEPTNO = B.DEPTNO
GROUP BY ROLLUP (B.DNAME, A.JOB);


-- emp 테이블에서 ename, sal 위에서부터 2개 출력하는데 sal 기준 내림차순
SELECT TOP(2) ENAME, SAL
FROM EMP
ORDER BY SAL DESC;

-- 위에서 2등까지 표시하고 공동있으면 그것도 표시
SELECT TOP(2) WITH TIES ENAME, SAL
FROM EMP
ORDER BY SAL DESC;

-- ename, sal 출력하는데 sal, empno로 정렬하고 5개 행 건너뛰고 조회
SELECT ENAME, SAL
FROM EMP
ORDER BY SAL, EMPNO
OFFSET 5 ROWS

-- emp 테이블에서 ename, sal 조회 sal 내림차순 기준, empno 기준 5개행만 출력
SELECT ENAME, SAL
FROM EMP
ORDER BY SAL DESC,
EMPNO OFFSET 0 ROWS FETCH NEXT 5 ROWS ONLY;

-- 셀프조인하면서 조회, emp 테이블 a, b 조인하는데 jones가 매니저인 직원 조회  empno, ename, mgr 출력
SELECT A.EMPNO, A.ENAME, A.MGR 
FROM EMP A, EMP B
WHERE A.MGR = B.EMPNO AND B.ENAME = 'JONES'

-- emp a, b, c 셀프 조인하는데 매니저가 jones인 애들을 매니저로 두는 직원 출력 empno, ename, mgr
SELECT C.EMPNO, C.ENAME, C.MGR
FROM EMP A, EMP B, EMP C
WHERE A.MGR = B.EMPNO AND B.ENAME = 'JONES' AND C.MGR = A.EMPNO

-- emp a, b, c 셀프 조인 smith의 매니저인	 애들의 매니저 출력
SELECT C.EMPNO, C.ENAME, C.MGR
FROM EMP A, EMP B, EMP C
WHERE A.ENAME = 'SMITH' AND B.EMPNO = A.MGR AND C.EMPNO = B.MGR