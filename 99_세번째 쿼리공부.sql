--

-- QUIZ1
-- CREATE USER TEST IDENTIFIED BY 1234; 실행
-- User TEST(이)가 생성됐습니다.
-- 계정생성만 하고 접속 => 에러!

-- 왜 오류가 났는지?
-- 문제점 : 계정생성만 했고 접속권한을 부여하지 않았기 때문에
-- 조치된 커리문 : GRANT CONNECT, RESOURCE TO TEST;

-- QUIZ2 (JOIN)
CREATE TABLE TB_JOB(
    JOBCODE NUMBER PRIMARY KEY,
    JOBNAME VARCHAR2(10) NOT NULL
);

CREATE TABLE TB_EMP(
    EMPNO NUMBER PRIMARY KEY,
    EMPNAME VARCHAR2(10) NOT NULL,
    JOBNO NUMBER REFERENCES TB_JOB(JOBCODE)
);

-- 위의 두 테이블이 있다는 가정하에
-- 두 테이블 조인해서 EMPNO, EMPNAME, JOBNO, JOBNAME 컬럼을 조회할꺼임
-- 이때 실행한 SQL문
SELECT EMPNO, EMPNAME,JOBNO, JOBNAME
FROM TB_EMP
JOIN TB_JOB USING(JOBNO);
-- 에러
-- ORA-00904: "TB_JOB"."JOBNO": invalid identifier

-- 문제점 : JOBNO컬럼이 TB_EMP에는 존재하지만 TB_JOB에는 존재하기 않기 때문에 USING 구문 안된다.
-- 해결내용 : USING(JOBNO)이 아니라 ON절 ON (JOBNO = JOBCODE)를 사용한다.
SELECT EMPNO, EMPNAME,JOBNO, JOBNAME
FROM TB_EMP
JOIN TB_JOB ON (JOBNO = JOBCODE);

--------------------------------------------------------------------------------
-- 테이블생성관련해서 데이터 타입 (CHAR, VARCHAR2 차이점)
-- 오라클객체 (SEQUENCE, VIEW, ..) 각가 뭔지 (정의)
-- 제약조건 => 뒤늦게 제약조건을 추가할 수 있는 ALTER문
-- DCL이 뭐냐?
-- 커밋 롤백 뭐냐?

-- QUIZ3 (JOIN 복습)

-- 아래의 SQL구문은 부서별 월급합계가 15,000,000을 초과하는 부서를 조회한 것이다.
-- 그 결과가 올바르지 않다고 할 때 그 원인과 조치사항

SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
WHERE SALARY > 15000000
GROUP BY DEPT_CODE;

--

SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING SUM(SALARY) > 15000000;

-- QUIZ 4 (제약조건)
CREATE TABLE QUIZ4(
    QNO NUMBER PRIMARY KEY,
    QNAME VARCHAR2(10),
    SCORE NUMBER
);

INSERT INTO QUIZ4 VALUES(1, '퀴즈1번', 30);
INSERT INTO QUIZ4 VALUES(1, '퀴즈2번', 50);
-- 왜안되는지 PRIMARY KEY

-- 직원의 급여 조회시 각 직급별로 인상해서 조회
-- J7인 사원은 급여를 10% 인상 (SALARY * 1.1)
-- J6인 사원은 급여를 15% 인상 (SALARY * 1.15)
-- J5인 사원은 급여를 20% 인상 (SALARY * 1.2)

SELECT EMP_NAME, JOB_CODE, SALARY,
       DECODE(JOB_CODE, 'J7', SALARY * 1.1,
                        'J6', SALARY * 1.15,
                        'J5', SALARY * 1.2,
                        SALARY * 1.05) AS "인상된 급여"
FROM EMPLOYEE;


-- '21/09/28'와 같은 문자열을 가지고 '2021-09-28'로 표현해보기
SELECT TO_CHAR(TO_DATE('21/09/28'), 'YYYY-MM-DD')
FROM DUAL;

-- '210908'와 같은 문자열을 가지고 2021년 9월 8일 표현
SELECT TO_CHAR(TO_DATE('210908'), 'YYYY"년" FMMM"월" DD"일"')
FROM DUAL;

-- 초급개발자 중급개발자 고급개발자
-- CASE WHEN

SELECT EMP_NAME, SALARY,
       CASE WHEN SALARY >= 5000000 THEN '고급개발자'
            WHEN SALARY >= 3500000 THEN '중급개발자'
            ELSE '초급개발자'
       END AS "레벨"
FROM EMPLOYEE;





