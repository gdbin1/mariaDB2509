-- 
SHOW DATABASES;

USE ch03;

SHOW TABLES;

SELECT * FROM productTBL;

CREATE TABLE usertbl(
	userID CHAR(8) NOT NULL PRIMARY KEY,
	NAME VARCHAR(10),
	birthYear INT not NULL,
	addr CHAR(2) NOT NULL,
	mobile1 CHAR(3),
	mobile2 CHAR(8),
	height SMALLINT,
	mDate date
);

CREATE TABLE buytbl(
	num INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
	userID CHAR(8) NOT NULL,
	prodName CHAR(6) not NULL,
	groupName CHAR(4),
	price INT NOT NULL,
	amount SMALLINT NOT NULL,
	FOREIGN KEY (userID) REFERENCES usertbl(userID)
);

DESC usertbl;
DESC buytbl;

DROP TABLE usertbl;
DROP TABLE buytbl;
SELECT * FROM usertbl;
INSERT INTO usertbl VALUES('LSG','이승기',1987,'서울','011','11111111',182,'2008-8-8');
INSERT INTO usertbl VALUES('KBS','김범수',1979,'경남','011','22222222',173,'2012-4-4');
INSERT INTO usertbl VALUES('KKH','김경호',1971,'전남','019','33333333',177,'2007-7-7');
INSERT INTO usertbl VALUES('JYP','조용필',1950,'경기','011','44444444',166,'2009-4-4');
INSERT INTO usertbl VALUES('SSK','성시경',1979,'서울',NULL,NULL,186,'2013-12-12');
INSERT INTO usertbl VALUES('LJB','임재범',1963,'서울','016','66666666',182,'2009-9-9');
INSERT INTO usertbl VALUES('YJS','윤종신',1969,'경남',NULL,NULL,170,'2005-5-5');
INSERT INTO usertbl VALUES('EJW','은지원',1972,'경북','011','88888888',174,'2014-3-3');
INSERT INTO usertbl VALUES('JKW','조관우',1965,'경기','018','99999999',172,'2010-10-10');
INSERT INTO usertbl VALUES('BBK','바비킴',1973,'서울','010','00000000',176,'2013-5-5');

INSERT INTO buytbl VALUES(NULL, 'KBS','운동화',NULL,30,2);
INSERT INTO buytbl VALUES(NULL, 'KBS','노트북','전자',1000,1);
INSERT INTO buytbl VALUES(NULL, 'JYP','모니터','전자',200,1);
INSERT INTO buytbl VALUES(NULL, 'BBK','모니터','전자',200,5);
INSERT INTO buytbl VALUES(NULL, 'KBS','청바지','의류',50,3);
INSERT INTO buytbl VALUES(NULL, 'BBK','메모리','전자',80,10);
INSERT INTO buytbl VALUES(NULL, 'SSK','책','서적',15,5);
INSERT INTO buytbl VALUES(NULL, 'EJW','책','서적',15,2);
INSERT INTO buytbl VALUES(NULL, 'EJW','청바지','의류',50,1);
INSERT INTO buytbl VALUES(NULL, 'BBK','운동화',NULL,30,2);
INSERT INTO buytbl VALUES(NULL, 'EJW','책','서적',15,1);
INSERT INTO buytbl VALUES(NULL, 'BBK','운동화',NULL,30,2);

SELECT * FROM usertbl;
SELECT * FROM buytbl;
-- 김경호 찾기
SELECT * FROM usertbl WHERE NAME = '김경호';

-- 1970년 이후 출생하고, 키가 182 이상인 사람의 아이디와 이름 조회
SELECT userID, NAME
FROM usertbl
WHERE birthYear >= 1970 AND height >= 182;

-- 1970년 이후 출생했거나, 키가 182 이상인 사람의 아이디와 이름.
SELECT userID, NAME
FROM usertbl
WHERE birthYear >= 1970 OR height >=182;

--키가 180~183인 사람 조회
SELECT NAME , height
FROM usertbl
WHERE height >= 180 AND height <= 183;

-- 지역이 '경남'이거나, '전남'이거나, '경북'인사람 찾기
SELECT NAME, addr 
FROM usertbl
WHERE addr = '경남' OR addr = '전남' OR addr = '경북';

-- 동일하게 연속적인 값이 아닌 이산적인 값을 위해 IN() 사용
SELECT NAME, addr
FROM usertbl
WHERE addr IN ('경남','전남','전북');

-- 문자열의 내용을 검색하기 위해선 like 연산자 사용 가능
-- 김으로 시작하는 사람 찾기
SELECT NAME, height
FROM usertbl
WHERE NAME LIKE '김%';

-- 맨 앞 글자가 한글자이고, 그 다음이 '종신'인 사람 찾기
SELECT NAME, height
FROM usertbl
WHERE NAME LIKE '_종신';

-- any/all/some , 서브쿼리
-- 일반적으로 177보다 큰사람을 출력하는 코드
SELECT NAME, height
FROM usertbl
WHERE height > 177;

-- 서브 쿼리를 써서 '김경호'보다 키가 같거나 큰 사람 찾기
SELECT NAME, height
FROM usertbl
WHERE height > (SELECT height FROM usertbl WHERE NAME = '김경호');

-- '경남'사람의 키보다 크거나 같은 사람 출력.
-- 오류발생코드 - 이유: 173과 170이라는 두 개의 값을 반환하기 때문.
-- SELECT NAME, height 
-- FROM usertbl 
-- WHERE height >= (SELECT height FROM usertbl WHERE addr = '경남');

-- 이럴때 any 사용, 옳바른 코드예시.
SELECT NAME, height
FROM usertbl
WHERE height >= ANY (SELECT height FROM usertbl WHERE addr = '경남');

-- any를 all로 바꿔서 실행할 때. all은 7명출력됨.
-- 이유: all은 170보다크거나 같고, 173보다 크거나 같아야하는 두 조건을 모두 충족해야함.
-- 한마디로 173 이상만 출력됨.
SELECT NAME, height
FROM usertbl
WHERE height >= ALL (SELECT height FROM usertbl WHERE addr = '경남');

-- >= any대신,  = 'any' 사용해보기
SELECT NAME, height
FROM usertbl
WHERE height = ANY (SELECT height FROM usertbl WHERE addr = '경남');

-- any(서브쿼리)는 in(서브쿼리)와 동일한 의미다.
SELECT NAME, height
FROM usertbl
WHERE height IN (SELECT height FROM usertbl WHERE addr = '경남');

-- sort (정렬) order by mdate별로 정렬
SELECT NAME, mDate 
FROM userTbl
ORDER BY mdate;




