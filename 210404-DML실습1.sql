SELECT ID AS 사번, dept_name '소속 학과', name as 이름, salary 급여
FROM instructor

SELECT ALL DEPT_NAME
FROM instructor

SELECT DISTINCT DEPT_NAME
FROM instructor

SELECT NAME AS 이름, ROUND(salary/12, 2) AS 월급여
FROM INSTRUCTOR

-- 문자열에 문자열 더하기 (VARCHAR을 NUMERIC으로 변환하는 중 오류)
SELECT dept_name + '학과 ' + '학생의 취득 학점은 ' + tot_cred AS 학생정보
FROM student

-- 왼쪽의 문자열을 숫자로 변환하던가 오른쪽의 숫자를 문자형으로 변환하면 오류X
SELECT dept_name + '학과 ' + '학생의 취득 학점은 ' + CONVERT(VARCHAR, tot_cred) AS 학생정보
FROM student