-- DELIMITER(구분자) : "여기까지가 한 문장" 이라는 표시를 바꾸는 명령
-- MySQL에서는 세미콜론(;)을 만나면 문장이 문장이 끝났다고 생각해 자동으로 실행한다.
-- 그런데 프로시저 구문 안에도 세미콜론이 여러 개 나올 수 있어서 다 읽기 전에 구문을 실행할 수 있다.
-- 그래서 잠시 구분자를 ;에서 //로 바꿔두는 작업이다.

DELIMITER //

-- 아무 이름이나 상관 없음. 심지어 송금하기() 형태도 가능하다.
create procedure 송금하기() 
begin
	start transaction;
    update accounts set balance = balance - 20000 
    where account_id = 1 and balance >= 20000;
	
    if row_count() = 0 
    then rollback;
    select '잔액부족' as 결과;
    else 
		update accounts set balance = balance + 20000
        where account_id = 2;
        commit;
        select '송금완료' as 결과;
    end if;
END //
-- 여기까지가 프로시저의 끝

DELIMITER ;
-- 다시 구분자를 ;으로 변경

-- 프로시저 호출해서 사용하기
CALL 송금하기();
select * from accounts;