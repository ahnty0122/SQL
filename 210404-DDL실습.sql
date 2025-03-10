-- CREATE DATABASE TEST

USE TEST;


CREATE TABLE DEPT
(
	DEPT_NO INT PRIMARY KEY,
	DEPT_NAME CHAR(10) NOT NULL,
	CONSTRAINT VALID_NAME CHECK(DEPT_NAME IN ('인사부', '총무부', '연구부', '홍보부'))
);

CREATE TABLE EMP
(
	EMP_NO INT NOT NULL,
	EMP_NAME CHAR(10) NOT NULL,
	DEPT_IN INT,
	PRIMARY KEY(EMP_NO),
	FOREIGN KEY(DEPT_IN) REFERENCES DEPT(DEPT_NO)
)

INSERT INTO DEPT VALUES(1, '인사부')
INSERT INTO DEPT VALUES(2, '연구부')
INSERT INTO DEPT VALUES(3, '홍보부')

SELECT * FROM DEPT;

INSERT INTO EMP VALUES(1001, 'KIM', 3)
INSERT INTO EMP VALUES(1002, 'LEE', 1)
INSERT INTO EMP VALUES(1003, 'MIN', 2)

SELECT * FROM EMP

DELETE FROM DEPT WHERE DEPT_NO = 1

-- 제약조건 변경
ALTER TABLE EMP DROP FK__EMP__DEPT_IN__3E52440B


-- 제약조건 변경후 DELETE 실행하면 DEPT, EMP에서 연쇄삭제 
ALTER TABLE EMP
ADD CONSTRAINT FK_123 FOREIGN KEY(DEPT_IN) REFERENCES DEPT(DEPT_NO) ON DELETE CASCADE

ALTER TABLE EMP DROP FK_123

-- 이렇게 테이블 속성 바꾼 후 다시 위에 DELETE 문 실행하면 DEPT에선 지워지는데 EMP 테이블에서는 DEPT_IN이 NULL값으로 변경되고 삭제는 안됨
-- 테이블 CREATE 할 때 DEPT_IN NOT NULL로 했으면 안 됨
ALTER TABLE EMP
ADD CONSTRAINT FK_123 FOREIGN KEY(DEPT_IN) REFERENCES DEPT(DEPT_NO) ON DELETE SET NULL
