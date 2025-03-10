USE K_LEAGUE;

SELECT PLAYER_NAME AS 선수명, TEAM_NAME AS 소속팀명
FROM PLAYER, TEAM
WHERE TEAM.TEAM_ID = PLAYER.TEAM_ID

-- 위랑 결과 같음
SELECT PLAYER_NAME AS 선수명, TEAM_NAME AS 소속팀명
FROM PLAYER INNER JOIN TEAM
ON TEAM.TEAM_ID = PLAYER.TEAM_ID


SELECT PLAYER_NAME 선수명, BACK_NO 백넘버, REGION_NAME 연고지, TEAM_NAME 팀명
FROM PLAYER A, TEAM B
WHERE A.TEAM_ID = B.TEAM_ID AND A.POSITION = 'GK'

SELECT A.PLAYER_NAME 선수명, A.POSITION 포지션,
B.REGION_NAME 연고지, B.TEAM_NAME 팀명,
C.STADIUM_NAME 구장명
FROM PLAYER A, TEAM B, STADIUM C
WHERE B.TEAM_ID = A.TEAM_ID AND C.STADIUM_ID = B.STADIUM_ID

SELECT A.TEAM_NAME, A.STADIUM_ID, B.STADIUM_NAME
FROM TEAM A JOIN STADIUM B
ON B.STADIUM_ID = A.STADIUM_ID
ORDER BY A.STADIUM_ID

SELECT A.STADIUM_NAME, A.STADIUM_ID, A.SEAT_COUNT, A.HOMETEAM_ID,
B.TEAM_NAME
FROM STADIUM A  JOIN TEAM B
ON B.TEAM_ID = A.HOMETEAM_ID

USE COMPANY;
CREATE TABLE SAL_GRADE
(
GRADE SMALLINT PRIMARY KEY,
LOSAL DECIMAL(7, 2),
HISAL DECIMAL(7, 2)
)INSERT INTO SAL_GRADE VALUES(1, 700, 1200)
INSERT INTO SAL_GRADE VALUES(2, 1201, 1400)
INSERT INTO SAL_GRADE VALUES(3, 1401, 2000)
INSERT INTO SAL_GRADE VALUES(4, 2001, 3000)
INSERT INTO SAL_GRADE VALUES(5, 3001, 9999)SELECT A.ENAME 사원명, A.SAL 급여, B.GRADE 급여등급
FROM EMP A, SAL_GRADE B
WHERE A.SAL BETWEEN B.LOSAL AND B.HISAL
ORDER BY 급여등급SELECT A.EMPNO, A.ENAME, B.DEPTNO, B.DNAME
FROM EMP A JOIN DEPT B ON B.DEPTNO = A.DEPTNO
WHERE B.DEPTNO = 30

SELECT A.EMPNO, A.ENAME, B.DEPTNO, B.DNAME
FROM EMP A JOIN DEPT B
ON B.DEPTNO = A.DEPTNO AND A.MGR = 7698

SELECT * INTO DEPT_TEMP FROM DEPT;

UPDATE DEPT_TEMP
SET DNAME = 'CONSULTING'
WHERE DNAME = 'RESEARCH'

UPDATE DEPT_TEMP
SET DNAME = 'MARKETING'
WHERE DNAME = 'SALES'

SELECT A.EMPNO, A.DEPTNO, B.DNAME, C.DNAME NEW_DNAME
FROM EMP A JOIN DEPT B ON B.DEPTNO = A.DEPTNO
JOIN DEPT_TEMP C ON C.DEPTNO = B.DEPTNO

SELECT A.EMPNO, A.DEPTNO, B.DNAME, C.DNAME NEW_DNAME
FROM EMP A, DEPT B, DEPT_TEMP C
WHERE B.DEPTNO = A.DEPTNO AND C.DEPTNO = B.DEPTNO

SELECT A.ENAME, B.DNAME
FROM EMP A CROSS JOIN DEPT B
ORDER BY A.ENAMEUPDATE DEPT_TEMP

SET DEPTNO += 20

SELECT * FROM DEPT_TEMP

SELECT *
FROM DEPT A FULL OUTER JOIN DEPT_TEMP B
ON B.DEPTNO = A.DEPTNO