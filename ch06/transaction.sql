DROP DATABASE IF EXISTS bank;
CREATE DATABASE bank;
USE bank;

CREATE TABLE accounts (
    account_id INT PRIMARY KEY,
    name VARCHAR(50),
    balance INT NOT NULL
);

INSERT INTO accounts VALUES
    (1, 'Alice', 100000),
    (2, 'Bob', 50000);

SELECT * FROM accounts;

-- 실습 예제 1.
-- 수동으로 트랜잭션 시작
start transaction;
update accounts set balance = balance - 30000 where account_id = 1;
update accounts set balance = balance + 30000 where account_id = 2;

-- 성공 : COMMIT
-- commit;
-- 실패 : ROLLBACK
-- rollback;
update accounts set balance = balance - 30000 where account_id = 1;
SELECT '롤백 전' AS 시점, account_id, balance from accounts where account_id = 1;

-- 오류가 발생하더라도 자동 취소는 안된다. 직접 rollback을 처리해야한다.
update accounts set balance = null where account_id = 2;
rollback;
SELECT '롤백 후' AS 시점, account_id, balance from accounts where account_id = 1;

-- 잔액 부족시 처리 방법
start transaction;
update accounts
set balance = balance - 200000
where account_id = 1 and balance >= 200000;

-- 적용된 row count 확인 명령어
select row_count() as 변경된행수;