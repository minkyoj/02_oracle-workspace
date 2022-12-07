--

-- 저장 먼저 하기 
-------------------- QUIZ 1 ---------------------------
-- 보너스를 안받지만 부서배치는 안된 사원 조회
SELECT *
FROM EMPLOYEE
WHERE BONUS = NULL AND DEPT_CODE != NULL;
-- NULL 값에 대한 정상적인 비교 처리 되지않음!!

-- 문제점 : 
-- 해결방법 : 

-- 조치한 SQL문
SELECT *
FROM EMPLOYEE
WHERE BONUS IS NULL AND DEPT_CODE IS NOT NULL;

-------------
-------------------- QUIZ 2 ---------------------------

-- 검색하고자 하는 내용
-- JOB_CODE가 J7이거나 J6이면서 SALARY값이 200만원 이상이고
-- BONUS가 있고 여자이며 이메일 주소는 _앞에 3글자만 있는 사원의
-- EMP_NAME, EMP_NO, JOB_CODE, DEPT_CODE, SALRARY, BONUS를 조회하려한다.
-- 정상적으로 조회가 잘 된다면 실행결과는 2행 이어야 한다.

-- 위의 내용을 실행시키고자 작성한 SQL문은 아래와 같다
SELECT EMP_NAME, EMP_NO, JOB_CODE, DEPT_CODE, SALARY, BONUS
FROM EMPLOYEE
WHERE JOB_CODE = 'J7' OR JOB_CODE = 'J6' AND SALARY > 2000000
AND EMAIL LIKE '____%' AND BONUS IS NULL;

-- 위의 SQL문 실행시 원하는 결과가 제대로 조회가 되지 않는다.
-- 이때 어떤 문제점들이 있는지 모두 찾아서 서술하시오.
-- 조치한 완벽한 SQL문을 작성해 볼 것!

-- 문제점 : 5개
-- 1. 여자인 조건 빠짐
-- 2. AND OR 잘못됌
-- 3. 이상인데 초과라씀
-- 4. 이스케이프문써야됌 INSTR도됌
-- 5. 보너스 낫널임


-- 정답 쿼리
SELECT EMP_NAME, EMP_NO, JOB_CODE, DEPT_CODE, SALARY, BONUS, EMAIL
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) IN (2, 4) AND (JOB_CODE = 'J7' OR JOB_CODE = 'J6') AND SALARY >= 2000000
AND EMAIL LIKE '___$_%' ESCAPE '$' AND BONUS IS NOT NULL;


-------------------- QUIZ 3 ---------------------------

-- [계정생성구문] CREATE USER 계정명 IDENTIFIED BY 비밀번호;

-- 계정명 : SCOTT, 비밀번호 : TIGER 계정을 생성하고 싶다!
-- 이때 일반사용자 계정인 KH계정에 접속해서 CREATE USE SCOTT;로 실행하니 문제 발생!!

-- 문제점 1. KH계정말고 관리자계정 ㄱㄱ
-- 문제점 2. 비번입력하셈

-- 조치내용1. 관리자계정접속
-- 조치내용2. CREATE USER SCOTT IDENTIFIED BY TIGER;

-- 위의 SQL(CREATE)만 실행 후 접속을 만들어서 접속을 하려고 했더니 실패! 
-- 뿐만 아니라 해당 계정에 테이블 생성같은 것도 되지 않음! 왜그럴까?

-- 문제점. 권한을줘야지 ㅡㅡ 테이블생성 접속 등등 권한줘야돼 다
-- 조치내용. GRANT CONNECT, RESOURCE TO SCOTT;








