-- 오손 읽기(DIRTY READ) : T1이 쓰기 작업을 하는 T2가
-- 작업한 중간 데이터를 읽기 때문에 발생하는 문제
-- 오손 읽기 발생하지 않도록 고립 레벨 올려주면 됨.
-- read uncommitted 에서 read committed로

-- 반복불가능읽기 (NON-REPEATABLE READ)
-- 트랜잭션 T1이 데이터 읽고 T2가 데이터 갱신한 상태에서 
-- 트랜잭션 T1이 다시 한번 데이터 읽을 때 발생하는 문제
-- T1이 읽기 작업을 반복할 경우, 이전의 결과와 다른 결과가 나옴

-- 고립 레벨을 REPEATABLE READ로 바꿔보기
-- 트랜잭션 T1이 읽고 T2가 갱신하려고 하면 막아줌

-- 유령데이터읽기(PHANTOM READ)
-- 트랜잭션 T1이 데이터를 읽고 T2가 쓰기연산을 했을 때
-- 그 후 트랜잭션 T1이 다시 한 번 데이터를 읽을 때 생기는 문제
-- 읽기 작업을 반복할 경우 이전에 없던 데이터, 즉 유령데이터가
-- 나타나는 현상

-- 고립 수준(레벨 3) 가장 높은 SERIALIZABLE 사용해보기
BEGIN TRAN
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;
-- 트랜잭션의 고립 수준 결정
-- read uncommitted 모드는 레벨이 0번 -> 고립 수준 가장 낮은 명령어
-- 읽기 작업만 할건데 읽는 데이터에는 공유락조차 걸지않음
-- 다른 트랜잭션이 공유락을 걸던 전용락을 걸던 uncommitted 상태에서 읽겠다는 의미

SELECT * FROM Users
WHERE AGE BETWEEN 10 AND 30

commit