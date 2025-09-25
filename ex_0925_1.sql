-- 스토어드 프로시저

USE ch03;
SHOW TABLES;

SELECT * FROM membertbl;

SELECT * FROM producttbl;

-- 프로시저 생성
DELIMITER //
CREATE PROCEDURE myproc()
BEGIN
	SELECT * FROM membertbl WHERE memberName = '당탕이';
	SELECT * FROM producttbl WHERE productname = '냉장고';
END //
DELIMITER ;
CALL myproc(); -- 스토어드 프로시저 실행은 -> Call 스토어드프로시저이름();

-- 트리거
INSERT INTO membertbl VALUES('Figure', '연아', '경기도 군포시 당정동'); -- 회원테이블 추가

UPDATE membertbl SET memberAddress = '서울 강남구 역삼동' -- -<여기로 변경 
WHERE memberName = '연아'; -- 이름이 '연아'인 회원 주소를
-- 연아 회원이 탈퇴해서 정보 삭제
DELETE FROM membertbl WHERE membername = '연아';

-- 이렇게 되면 '연아'가 회원이었다는 정보가 어디에도 남지않음
-- 이런 사례를 방지하기위한 아래 예시 코드

-- 지워진 데이터 보관할 테이블 생성
CREATE TABLE deletedMemberTBL(
	memberID CHAR(8),
	merberName CHAR(5),
	memberAddress CHAR(20),
	deletedDate DATE -- 삭제한 날짜
);

-- memberTBL에 DELETE 작업이 일어나면 deletedMemberTBL에 지워진 데이터가 기록되는 트리거생성

DELIMITER //
CREATE TRIGGER	trg_deletedMemberTBL -- 트리거 이름
	AFTER DELETE -- 삭제 후에 작동하게 지정
	ON membertbl -- 트리거를 부착할 테이블
	FOR EACH ROW -- 각 행마다 적용시킴
BEGIN
	-- old 테이블의 내용을 백업 테이블에 삽입
	INSERT INTO deletedMemberTBL VALUES(
		OLD.memberID, OLD.memberName, OLD.memberAddress, CURDATE()
		);
END //
DELIMITER ;

-- 삭제된 데이터가 백업테이블에 들어갔는지 확인하기
SELECT * FROM membertbl;

DELETE FROM membertbl WHERE memberNAME = '당탕이'; -- 삭제됨

SELECT * FROM deletedmembertbl; -- 백업테이블에 저장됨


s



















