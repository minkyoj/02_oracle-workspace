--아래의 SQL구문은 부서 별 평균 월급이 2,800,000을 초과하는 부서를 조회한 것이다.
--결과가 올바르지 않다고 할 때, 그 원인(20점)과 올바르게 수정한 조치사항(20점)을 각각 항목에 맞게 기술하시오. (총 40점)

SELECT DEPT, SUM(SALARY) 합계, FLOOR(AVG(SALARY)) 평균, COUNT(*) 인원수
FROM EMP
WHERE SALARY > 2800000
GROUP BY DEPT
ORDER BY DEPT ASC;

1. WHERE절 때문에 순서가 뒤바뀌었다.
 => HAVING절을 사용해야한다.
2.


SELECT DEPT, SUM(SALARY) 합계, FLOOR(AVG(SALARY)) 평균, COUNT(*) 인원수
FROM EMP
GROUP BY DEPT
HAVING FLOOR(AVG(SALARY)) > 2800000
ORDER BY DEPT ASC;


SELECT DEPT_CODE, SUM(SALARY) 합계, FLOOR(AVG(SALARY)) 평균, COUNT(*) 인원수
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING FLOOR(AVG(SALARY)) > 2800000
ORDER BY DEPT_CODE ASC;

-------------------------

MNO | NUMBER | PRIMARY KEY | 회원번호

MNAME | VARCHAR2(300) | NOT NULL | 회원명

ADDRESS | VARCHAR2(1000) | ㅡ | 주소

TEL | VARCHAR2(13) | UNIQUE | 연락처



----- < 실행한 SQL > -----

INSERT INTO MEMBER_KH VALUES(1, '홍길동', '서울시 강남구', '011-0000-0000');

INSERT INTO MEMBER_KH VALUES(2, '고길동', '부산시 해운대구', '010-0000-0000');

INSERT INTO MEMBER_KH VALUES(3, '김갑환', '인천시 연수구', '019-0000-0000');

PRIMARY KEY 는 식별자의 역할로 자동적으로 NOT NULL, UNIQUE의 제약조건을 가지기 때문에 같은 값이 담길 수 없다.
하지만 위 상황에서는 PRIMARY KEY인 MNO에 같은값 1이 중복해서 담겼기 때문에 UNIQUE제약조건에 위배되어 에러가 났다.


직원의 급여를 인상하고자 한다
직급코드가 J7인 직원은 급여의 8%를 인상하고,

직급코드가 J6인 직원은 급여의 7%를 인상하고,

직급코드가 J5인 직원은 급여의 5%를 인상한다.

그 외 직급의 직원은 3%만 인상한다.

직원 테이블(EMP)에서 직원명(EMPNAME), 직급코드(JOBCODE), 급여(SALARY), 인상급여(위 조건)을

조회하세요(단, DECODE를 이용해서 출력하시오.) (20점)

SELECT EMPNAME AS "이름", JOBCODE, SALARY,
       DECODE(JOBCODE, 'J7', SALARY * 1.08,
                        'J6', SALARY * 1.07,
                        'J5', SALARY * 1.05,
                        SALARY * 1.03) AS "인상급여"
FROM EMP;

SELECT * FROM EMPLOYEE;


SELECT EMP_NAME AS "직원명", JOB_CODE, SALARY,
       DECODE(JOB_CODE, 'J7', SALARY * 1.08,
                        'J6', SALARY * 1.07,
                        'J5', SALARY * 1.05,
                        SALARY * 1.03)AS "인상급여"
FROM EMPLOYEE;
