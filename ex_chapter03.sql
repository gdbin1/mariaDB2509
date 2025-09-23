-- ----과제 ch03
SHOW DATABASES;
-- ch03 데이터베이스 생성
CREATE DATABASE ch03;
-- ch03 데이터베이스 사용
USE ch03;
-- ch03에 있는 테이블 보기
SHOW TABLES;
-- memberTBL 테이블생성
CREATE TABLE memberTBL(
	memberID CHAR(8) NOT NULL,
	memberName CHAR(15) NOT NULL,
	memberAddress CHAR(60)
);
-- memberTBL 테이블에 값 대입
INSERT INTO membertbl VALUES('Dang','당탕이','경기도 부천시 중동');
INSERT INTO membertbl VALUES('Jee','지운이','서울 은평구 중산동');
INSERT INTO membertbl VALUES('Han','한주연','인천 남구 주안동');
INSERT INTO membertbl VALUES('Sang','상길이','경기 성남시 분당구');
-- 테이블 제거 - drop table 테이블명;
-- DROP TABLE membertbl;

-- productTBL 테이블 생성
CREATE TABLE productTBL(
	productName CHAR(12) NOT NULL,
	cost INT NOT NULL,
	MAKEDATE DATE,
	company CHAR(15),
	amount INT NOT null
);
-- productTBL테이블에 값 대입
INSERT INTO producttbl VALUES('컴퓨터', 10, '2013.1.1', '삼성', 17);
INSERT INTO producttbl VALUES('세탁기', 20, '2014.9.1', 'LG', 3);
INSERT INTO producttbl VALUES('냉장고', 5, '2015.2.1', '대우', 22);

-- 각 테이블 열과 행 전체 확인
SELECT * FROM membertbl;
SELECT * FROM producttbl;
-- 각 테이블의 갯수 확인
SELECT COUNT(*) FROM membertbl;
SELECT COUNT(*) FROM producttbl;
-- 지운이 찾기
SELECT * FROM membertbl WHERE memberName = '지운이';
SELECT memberName, memberAddress FROM membertbl;




