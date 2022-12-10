--
/*
1. 계열 정보를 저장할 카테고리 테이블을 만들려고 한다. 다음과 같은 테이블을
작성하시오.

테이블 이름
TB_CATEGORY

컬럼
NAME, VARCHAR2(10)
USE_YN, CHAR(1), 기본값은 Y 가 들어가도록
*/

CREATE TABLE TB_CATEGORY (
    NAME VARCHAR2(10),
    USE_YN CHAR(1) DEFAULT 'Y'
);

/*
2. 과목 구분을 저장핛 테이블을 만들려고 핚다. 다음과 같은 테이블을 작성하시오.

테이블이름
TB_CLASS_TYPE

컬럼
NO, VARCHAR2(5), PRIMARY KEY
NAME , VARCHAR2(10)
*/

CREATE TABLE TB_CLASS_TYPE (
    NO VARCHAR2(10) PRIMARY KEY,
    NAME VARCHAR2(30)
);

DROP TABLE TB_CLASS_TYPE;

/*
3. TB_CATAGORY 테이블의 NAME 컬럼에 PRIMARY KEY 를 생성하시오.
(KEY 이름을 생성하지 않아도 무방함. 만일 KEY 이를 지정하고자 한다면 이름은 본인이
알아서 적당한 이름을 사용한다.)
*/

ALTER TABLE TB_CATEGORY ADD PRIMARY KEY(NAME);

/*
4. TB_CLASS_TYPE 테이블의 NAME 컬럼에 NULL 값이 들어가지 않도록 속성을 변경하시오.
*/

ALTER TABLE TB_CLASS_TYPE MODIFY NAME NOT NULL;

/*
5. 두 테이블에서 컬럼 명이 NO 인 것은 기존 타입을 유지하면서 크기는 10 으로, 컬럼명이
NAME 인 것은 마찬가지로 기존 타입을 유지하면서 크기 20 으로 변경하시오.
*/

ALTER TABLE TB_CLASS_TYPE MODIFY NO VARCHAR2(10);
ALTER TABLE TB_CATEGORY MODIFY NAME VARCHAR2(20);

/*
6. 두 테이블의 NO 컬럼과 NAME 컬럼의 이름을 각 각 TB_ 를 제외한 테이블 이름이 앞에
붙은 형태로 변경핚다.
(ex. CATEGORY_NAME)
*/

ALTER TABLE TB_CLASS_TYPE RENAME COLUMN NO TO CATEGORY_NO;
ALTER TABLE TB_CATEGORY RENAME COLUMN NAME TO CATEGORY_NAME;

/*
7. TB_CATAGORY 테이블과 TB_CLASS_TYPE 테이블의 PRIMARY KEY 이름을 다음과 같이
변경하시오.
Primary Key 의 이름은 ?PK_ + 컬럼이름?으로 지정하시오. (ex. PK_CATEGORY_NAME )
*/
-- ALTER TABLE DEPT_COPY RENAME CONSTRAINT SYS_C007270 TO DCOPY_DID_NN;

ALTER TABLE TB_CATEGORY RENAME CONSTRAINT SYS_C007292 TO PK_CATEGORY_NAME;
ALTER TABLE TB_CLASS_TYPE RENAME CONSTRAINT SYS_C007150 TO PK_CATEGORY_NO;

/*
8. 다음과 같은 INSERT 문을 수행핚다.
INSERT INTO TB_CATEGORY VALUES ('공학','Y');
INSERT INTO TB_CATEGORY VALUES ('자연과학','Y');
INSERT INTO TB_CATEGORY VALUES ('의학','Y');
INSERT INTO TB_CATEGORY VALUES ('예체능','Y');
INSERT INTO TB_CATEGORY VALUES ('인문사회','Y');
COMMIT;
*/

INSERT INTO TB_CATEGORY VALUES ('공학','Y');
INSERT INTO TB_CATEGORY VALUES ('자연과학','Y');
INSERT INTO TB_CATEGORY VALUES ('의학','Y');
INSERT INTO TB_CATEGORY VALUES ('예체능','Y');
INSERT INTO TB_CATEGORY VALUES ('인문사회','Y');
COMMIT;

/*
9.TB_DEPARTMENT 의 CATEGORY 컬럼이 TB_CATEGORY 테이블의 CATEGORY_NAME 컬럼을 부모
값으로 참조하도록 FOREIGN KEY 를 지정하시오. 이 때 KEY 이름은
FK_테이블이름_컬럼이름으로 지정한다. (ex. FK_DEPARTMENT_CATEGORY )
*/

--ALTER TABLE DEPT_COPY
--   ADD CONSTRAINT DCOPY_PK PRIMARY KEY(DEPT_ID)

ALTER TABLE TB_DEPARTMENT
    ADD CONSTRAINT FK_DEPARTMENT_CATEGORY FOREIGN KEY (CATEGORY) REFERENCES TB_CATEGORY(CATEGORY_NAME);

--15. 춘 기술대학교는 매년 수강신청 기간만 되면 특정 인기 과목들에 수강 신청이 몰려
--문제가 되고 있다. (2005~2009) 기준으로 수강인원이 가장 많았던 3 과목을 찾는 구문을
--작성해보시오.

-- 내쿼리
SELECT *
FROM (SELECT CLASS_NO AS "과목번호", CLASS_NAME AS "과목이름", COUNT(*) AS "누적수강생수(명)"
        FROM TB_CLASS
        JOIN TB_GRADE USING (CLASS_NO)
        WHERE SUBSTR(TERM_NO, 1, 4) IN ('2005', '2006', '2007', '2008', '2009')
        GROUP BY CLASS_NO, CLASS_NAME
        ORDER BY COUNT(*) DESC)
WHERE ROWNUM <= 3;

-- 쌤쿼리
SELECT V.과목번호
     , V.과목이름
     , V."누적수강생수(명)"
  FROM (SELECT C.CLASS_NO 과목번호
             , C.CLASS_NAME 과목이름
             , COUNT(*) "누적수강생수(명)"
          FROM TB_CLASS C
          JOIN TB_GRADE G ON(C.CLASS_NO = G.CLASS_NO)
         WHERE SUBSTR(G.TERM_NO, 1, 4) IN ('2005', '2006', '2007', '2008', '2009')
         GROUP BY C.CLASS_NO, C.CLASS_NAME
         ORDER BY 3 DESC) V
 WHERE ROWNUM < 4;
 
 -- 승협님쿼리
 SELECT 과목번호, 과목이름, 누적수강생수
FROM (
SELECT C.CLASS_NO 과목번호, C.CLASS_NAME 과목이름, COUNT(S.STUDENT_NO) 누적수강생수
FROM TB_STUDENT S, TB_CLASS C, TB_GRADE G
WHERE S.STUDENT_NO = G.STUDENT_NO
AND G.CLASS_NO = C.CLASS_NO
AND EXTRACT(YEAR FROM (TO_DATE(G.TERM_NO,'YYYYMM'))) BETWEEN 2005 AND 2009
GROUP BY C.CLASS_NO, C.CLASS_NAME
ORDER BY 3 DESC)
WHERE ROWNUM <= 3;




-- DML --
/*
1. 과목유형 테이블(TB_CLASS_TYPE)에 아래와 같은 데이터를 입력하시오.
번호, 유형이름
------------
01, 전공필수
02, 전공선택
03, 교양필수
04, 교양선택
05. 논문지도
*/

INSERT INTO TB_CLASS_TYPE
    VALUES('01', '전공필수');
INSERT INTO TB_CLASS_TYPE
    VALUES('02', '전공선택');
INSERT INTO TB_CLASS_TYPE
    VALUES('03', '교양필수');
INSERT INTO TB_CLASS_TYPE
    VALUES('04', '교양선택');
INSERT INTO TB_CLASS_TYPE
    VALUES('05', '논문지도');

/*
2. 춘 기술대학교 학생들의 정보가 포함되어 있는 학생일반정보 테이블을 만들고자 핚다.
아래 내용을 참고하여 적절한 SQL 문을 작성하시오. (서브쿼리를 이용하시오)
테이블이름
TB_학생일반정보
컬럼
학번
학생이름
주소
*/

CREATE TABLE TB_학생일반정보
AS SELECT STUDENT_NO AS "학번", STUDENT_NAME AS "학생이름", STUDENT_ADDRESS AS "주소"
   FROM TB_STUDENT;

--SELECT * FROM TB_학생일반정보;

/*
3. 국어국문학과 학생들의 정보만이 포함되어 있는 학과정보 테이블을 만들고자 핚다.
아래 내용을 참고하여 적절한 SQL 문을 작성하시오. (힌트 : 방법은 다양함, 소신껏
작성하시오)
테이블이름
TB_국어국문학과
컬럼
학번
학생이름
출생년도 <= 네자리 년도로 표기
교수이름
*/

SELECT STUDENT_NO AS "학번", STUDENT_NAME AS "학생이름", EXTRACT(YEAR FROM TO_DATE(SUBSTR(STUDENT_SSN, 1, 6), 'RRMMDD')) AS "출생년도", PROFESSOR_NAME AS "교수이름"
FROM TB_STUDENT
JOIN TB_PROFESSOR ON (COACH_PROFESSOR_NO = PROFESSOR_NO);
/*
SELECT EXTRACT(YEAR FROM TO_DATE(SUBSTR(STUDENT_SSN, 1, 6), 'YYYYMMDD'))
FROM TB_STUDENT;
SELECT EXTRACT(YEAR FROM TO_DATE(SUBSTR(STUDENT_SSN, 1, 6), 'RRMMDD')) FROM TB_STUDENT;
SELECT TO_DATE(SUBSTR(STUDENT_SSN, 1, 6), 'RRMMDD') FROM TB_STUDENT;
*/

CREATE TABLE TB_국어국문학과
AS SELECT STUDENT_NO AS "학번", STUDENT_NAME AS "학생이름", EXTRACT(YEAR FROM TO_DATE(SUBSTR(STUDENT_SSN, 1, 6), 'RRMMDD')) AS "출생년도", PROFESSOR_NAME AS "교수이름"
   FROM TB_STUDENT
   JOIN TB_PROFESSOR ON (COACH_PROFESSOR_NO = PROFESSOR_NO);

SELECT * FROM TB_국어국문학과;


-- 4. 현 학과들의 정원을 10% 증가시키게 되었다. 이에 사용한 SQL 문을 작성하시오. (단,
-- 반올림을 사용하여 소수점 자릿수는 생기지 않도록 한다)
/*
SELECT CAPACITY, ROUND(CAPACITY * 1.1)
FROM TB_DEPARTMENT;
*/

UPDATE TB_DEPARTMENT
SET CAPACITY = ROUND(CAPACITY * 1.1);


-- 5. 학번 A413042 인 박건우 학생의 주소가 "서울시 종로구 숭인동 181-21 "로 변경되었다고
-- 한다. 주소지를 정정하기 위해 사용한 SQL 문을 작성하시오.
/*
SELECT *
FROM TB_STUDENT
WHERE STUDENT_NO = 'A413042';
*/
UPDATE TB_STUDENT
SET STUDENT_ADDRESS = '서울시 종로구 숭인동 181-21'
WHERE STUDENT_NO = 'A413042';

-- 6. 주민등록번호 보호법에 따라 학생정보 테이블에서 주민번호 뒷자리를 저장하지 않기로
-- 결정하였다. 이 내용을 반영핛 적절한 SQL 문장을 작성하시오.
-- (예. 830530-2124663 ==> 830530 )

-- SELECT SUBSTR(STUDENT_SSN, 1, 6) FROM TB_STUDENT;

UPDATE TB_STUDENT
SET STUDENT_SSN = SUBSTR(STUDENT_SSN, 1, 6);

SELECT * FROM TB_STUDENT;

-- 7. 의학과 김명훈 학생은 2005 년 1 학기에 자신이 수강핚 '피부생리학' 점수가
-- 잘못되었다는 것을 발견하고는 정정을 요청하였다. 담당 교수의 확인 받은 결과 해당
-- 과목의 학점을 3.5 로 변경키로 결정되었다. 적절한 SQL 문을 작성하시오.
/*
SELECT TERM_NO, STUDENT_NAME, POINT, CLASS_NAME
FROM TB_GRADE
JOIN TB_STUDENT USING (STUDENT_NO)
JOIN TB_CLASS USING (CLASS_NO)
WHERE STUDENT_NAME = '김명훈'
AND TERM_NO = 200501
AND CLASS_NAME = '피부생리학';
*/

UPDATE TB_GRADE
SET POINT = 3.5 -- 1.5
WHERE (STUDENT_NO, TERM_NO) = (SELECT STUDENT_NO, TERM_NO
                  FROM TB_GRADE
                  JOIN TB_STUDENT USING (STUDENT_NO)
                  JOIN TB_CLASS USING (CLASS_NO)
                  WHERE STUDENT_NAME = '김명훈'
                  AND TERM_NO = 200501
                  AND CLASS_NAME = '피부생리학');

-- ROLLBACK;

-- 8. 성적 테이블(TB_GRADE) 에서 휴학생들의 성적항목을 제거하시오.


SELECT POINT, ABSENCE_YN
FROM TB_GRADE
JOIN TB_STUDENT USING (STUDENT_NO)
WHERE ABSENCE_YN = 'Y';
  

DELETE
FROM (SELECT POINT, ABSENCE_YN
    FROM TB_GRADE
    JOIN TB_STUDENT USING (STUDENT_NO)
    WHERE ABSENCE_YN = 'Y');


-- ROLLBACK;

























